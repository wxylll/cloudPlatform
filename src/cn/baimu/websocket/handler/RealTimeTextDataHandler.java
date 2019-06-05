package cn.baimu.websocket.handler;

import cn.baimu.service.EdgeTerminalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashSet;
import java.util.concurrent.ConcurrentHashMap;

public class RealTimeTextDataHandler extends TextWebSocketHandler {

    @Autowired
    private EdgeTerminalService edgeTerminalService;

    //用户连接
    private static ConcurrentHashMap<String, HashSet<RealTimeTextDataHandler>> userWebSocketSet = new ConcurrentHashMap<>();
    //边缘端连接
    private static ConcurrentHashMap<String, RealTimeTextDataHandler> edgeWebSocketSet = new ConcurrentHashMap<>();
    //与客户端的链接会话
    private WebSocketSession session;
    //标志边缘端是否接收到消息
    private boolean hasReceived;

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        System.out.println(message.getPayload());
        if (message.getPayload().equals("received")) {
            hasReceived = true; //确认对方收到消息
            System.out.println("received:" + message.getPayload());
        }
        System.out.println(message.getPayload());
        super.handleTextMessage(session, message);
    }

    //连接成功
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //判断连接是用户还是边缘端，并分别储存
        if (Boolean.valueOf( (String)session.getAttributes().get("isEdge")) ) {
            String eid = (String) session.getAttributes().get("eid");
            if (edgeTerminalService.getEdgeTerminal(eid) != null) { //判断边缘端是否合法，合法则允许连接,否则关闭连接
                this.session = session;
                edgeWebSocketSet.put(eid, this);
                System.out.println(eid + ":edge连接成功！");
            }else {
                session.sendMessage(new TextMessage("非法的边缘端！"));
                session.close();
            }
        } else {
            String uid = (String) session.getAttributes().get("uid");
            HashSet<RealTimeTextDataHandler> set = userWebSocketSet.get(uid);
            set = null == set ? new HashSet<>() : set;
            this.session = session;
            set.add(this);
            userWebSocketSet.put(uid, set);
            System.out.println(uid + ":连接成功！");
        }
        super.afterConnectionEstablished(session);
    }

    //连接断开
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

        if (Boolean.valueOf((String)session.getAttributes().get("isEdge"))) {
            edgeWebSocketSet.remove(session.getAttributes().get("eid"));
            System.out.println(session.getAttributes().get("eid") + ":edge连接关闭！");
        } else {
            HashSet<RealTimeTextDataHandler> set = userWebSocketSet.get(session.getAttributes().get("uid"));
            set.remove(this);
            if (set.size() == 0)
                userWebSocketSet.remove(session.getAttributes().get("uid"));
            System.out.println(session.getAttributes().get("uid") + ":连接关闭！");
        }

        super.afterConnectionClosed(session, status);
    }

    /**
     * 向指定用户发送消息
     * @param message
     * @param uid
     */
    public void sendToUser(String message, String uid){
        if (userWebSocketSet.get(uid) != null) {
            for (RealTimeTextDataHandler handler : userWebSocketSet.get(uid)) {
                handler.sendText(message);
            }
        }
    }

    /**
     * 向边缘端发送消息
     * @param message
     * @param eid
     * @return 返回true表示边缘端接收到消息，false表示未接收到
     */
    public boolean sendToEdge(String message, String eid){
        hasReceived = false;
        edgeWebSocketSet.get(eid).sendText(message);
        for (int i = 0; i < 1000; i++) { //最大等待时间1000*100毫秒
            if (hasReceived) {
                System.out.println("对方已收到消息！");
                return true;
            }
            try {
                Thread.sleep(10); //每10毫秒确认一次是否收到消息
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("对方未收到消息！");
        return false;
    }

    /**
     * 推送文本消息
     * @param message
     */
    public void sendText(String message) {
        try {
            session.sendMessage(new TextMessage(message));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 判断边缘端连接是否正常
     * @param eid
     * @return
     */
    public boolean edgeIsOnline(String eid) {
        return edgeWebSocketSet.get(eid) != null;
    }

    /**
     * 判断用户是否在线
     * @param uid
     * @return
     */
    public boolean userIsOnline(String uid) {
        return userWebSocketSet.get(uid) != null;
    }

}
