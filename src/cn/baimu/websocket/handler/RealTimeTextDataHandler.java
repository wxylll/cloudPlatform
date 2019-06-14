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
    private static ConcurrentHashMap<String, HashSet<WebSocketSession>> userWebSocketSet = new ConcurrentHashMap<>();
    //边缘端连接
    private static ConcurrentHashMap<String, WebSocketSession> edgeWebSocketSet = new ConcurrentHashMap<>();

    //标志边缘端是否接收到消息
    private static HashSet<String> hasReceived = new HashSet<>();

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        if (message.getPayload().equals("received")) {
            hasReceived.add((String)session.getAttributes().get("eid")); //确认对方收到消息
            System.out.println("received:" + message.getPayload());
        }
        super.handleTextMessage(session, message);
    }

    //连接成功
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //判断连接是用户还是边缘端，并分别储存
        if (Boolean.valueOf( (String)session.getAttributes().get("isEdge")) ) {
            String eid = (String) session.getAttributes().get("eid");
            if (edgeTerminalService.getEdgeTerminal(eid) != null) { //判断边缘端是否合法，合法则允许连接,否则关闭连接
                edgeWebSocketSet.put(eid, session);
            }else {
                session.sendMessage(new TextMessage("非法的边缘端！"));
                session.close();
            }
        } else {
            String uid = (String) session.getAttributes().get("uid");
            HashSet<WebSocketSession> set = userWebSocketSet.get(uid);
            set = null == set ? new HashSet<>() : set;
            set.add(session);
            userWebSocketSet.put(uid, set);
        }
        super.afterConnectionEstablished(session);
    }

    //连接断开
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

        if (Boolean.valueOf((String)session.getAttributes().get("isEdge"))) {
            edgeWebSocketSet.remove(session.getAttributes().get("eid"));
        } else {
            HashSet<WebSocketSession> set = userWebSocketSet.get(session.getAttributes().get("uid"));
            set.remove(session);
            if (set.size() == 0)
                userWebSocketSet.remove(session.getAttributes().get("uid"));
        }

        super.afterConnectionClosed(session, status);
    }

    /**
     * 向指定用户发送消息
     * 内容格式为 消息类型：内容
     * msg表示提示信息，data表示数据信息，如：
     *      msg:new 表示要提示用户有新的边缘端接入
     *      data:250,2019-6-6 15:22:20,10086表示边缘端推送来了数据需要进行展示，
     *          具体意义为：此次爆发当前人流为250,此数据在2019-6-6 15:22:20获取,来自id为10086的边缘端
     * @param message
     * @param uid
     */
    public void sendToUser(String message, String uid){
        if (userWebSocketSet.get(uid) != null) {
            for (WebSocketSession session : userWebSocketSet.get(uid)) {
                sendText(session, message);
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
        /*
         *此方法需确保边缘端收到发送的消息，实现方法为：
         *      初始将hasReceived设为false，
         *      当handleTextMessage接收到回执信息后将其置为true
         *      在此期间，每隔10ms确认一次hasReceived是否为true，是则返回成功信息
         *      最多确认3000次，即等待时间为30秒
         *      若10秒后未确认到成功信息，则认为发送失败，返回失败信息
         */
        hasReceived.remove(eid);
        if (edgeWebSocketSet.size() == 0 || edgeWebSocketSet.get(eid) == null) return false;
        sendText(edgeWebSocketSet.get(eid), message);
        for (int i = 0; i < 3000; i++) { //最大等待时间1000*10毫秒
            if (hasReceived.contains(eid)) {
                return true;
            }
            try {
                Thread.sleep(10); //每10毫秒确认一次是否收到消息
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    /**
     * 推送文本消息
     * @param message
     */
    public void sendText(WebSocketSession session, String message) {
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
        return edgeWebSocketSet.size() > 0 && edgeWebSocketSet.get(eid) != null;
    }

    /**
     * 判断用户是否在线
     * @param uid
     * @return
     */
    public boolean userIsOnline(String uid) {
        return userWebSocketSet.size() > 0 && userWebSocketSet.get(uid) != null;
    }

}
