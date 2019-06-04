package cn.baimu.websocket.handler;

import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

public class RealTimeVideoDataHandler extends BinaryWebSocketHandler {

    //用户连接
    private static ConcurrentHashMap<String, HashSet<RealTimeVideoDataHandler>> userWebSocketSet = new ConcurrentHashMap<>();
    //边缘端连接
    private static ConcurrentHashMap<String, RealTimeVideoDataHandler> edgeWebSocketSet = new ConcurrentHashMap<>();
    //与客户端的链接会话
    private WebSocketSession session;

    //初次连接成功
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //判断连接是用户还是边缘端，并分别储存
        if (Boolean.valueOf( (String)session.getAttributes().get("isEdge")) ) {
            String eid = (String) session.getAttributes().get("eid");
            this.session = session;
            edgeWebSocketSet.put(eid, this);
        } else {
            String uid = (String) session.getAttributes().get("uid");
            HashSet<RealTimeVideoDataHandler> set = userWebSocketSet.get(uid);
            set = null == set ? new HashSet<>() : set;
            this.session = session;
            set.add(this);
            userWebSocketSet.put(uid, set);
        }
        super.afterConnectionEstablished(session);
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        super.handleMessage(session, message);
    }

    //连接抛出异常
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        super.handleTransportError(session, exception);
    }

    //连接关闭后
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

        if (Boolean.valueOf((String)session.getAttributes().get("isEdge"))) {
            edgeWebSocketSet.remove(session.getAttributes().get("eid"));
        } else {
            HashSet<RealTimeVideoDataHandler> set = userWebSocketSet.get(session.getAttributes().get("uid"));
            set.remove(this);
            if (set.size() == 0)
                userWebSocketSet.remove(session.getAttributes().get("uid"));
        }

        super.afterConnectionClosed(session, status);
    }

    /**
     * 将视频数据推送给指定用户
     * @param message
     * @param uid
     */
    public void sendToUser(byte[] message, String uid) {
        if (userWebSocketSet.get(uid) != null) {
            for (RealTimeVideoDataHandler handler : userWebSocketSet.get(uid)) {
                handler.sendVideo(message);
            }
        }
    }

    /**
     * 推送视频数据
     * @param message
     */
    public void sendVideo(byte[] message) {
        try {
            session.sendMessage(new BinaryMessage(message));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isOnline() {
        return true;
    }

    public void sendToEdge() {

    }

}
