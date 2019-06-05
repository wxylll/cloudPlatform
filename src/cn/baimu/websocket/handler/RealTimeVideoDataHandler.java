package cn.baimu.websocket.handler;

import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import java.util.HashSet;
import java.util.concurrent.ConcurrentHashMap;

public class RealTimeVideoDataHandler extends BinaryWebSocketHandler {

    //用户连接
    private static ConcurrentHashMap<String, HashSet<RealTimeVideoDataHandler>> userWebSocketSet = new ConcurrentHashMap<>();
    //与客户端的链接会话
    private WebSocketSession session;

    //初次连接成功
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String uid = (String) session.getAttributes().get("uid");
        HashSet<RealTimeVideoDataHandler> set = userWebSocketSet.get(uid);
        set = null == set ? new HashSet<>() : set;
        this.session = session;
        set.add(this);
        userWebSocketSet.put(uid, set);
        System.out.println(uid + ":v连接成功！");
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

        HashSet<RealTimeVideoDataHandler> set = userWebSocketSet.get(session.getAttributes().get("uid"));
        set.remove(this);
        if (set.size() == 0) userWebSocketSet.remove(session.getAttributes().get("uid"));

        System.out.println(session.getAttributes().get("uid") + ":v连接关闭！");
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

}
