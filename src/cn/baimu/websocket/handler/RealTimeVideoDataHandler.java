package cn.baimu.websocket.handler;

import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import java.util.HashSet;
import java.util.concurrent.ConcurrentHashMap;

public class RealTimeVideoDataHandler extends BinaryWebSocketHandler {
    /**
     * 此处用uid+eid组合来区分用户当前正在查看哪一个边缘端的数据，便于推送
     */

    //用户连接
    private static ConcurrentHashMap<String, HashSet<WebSocketSession>> userWebSocketSet = new ConcurrentHashMap<>();

    //初次连接成功
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String uidAndEid = (String) session.getAttributes().get("uid") + (String) session.getAttributes().get("eid");

        HashSet<WebSocketSession> set = userWebSocketSet.get(uidAndEid);
        set = null == set ? new HashSet<>() : set;
        set.add(session);
        userWebSocketSet.put(uidAndEid, set);
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

        String uidAndEid = (String)session.getAttributes().get("uid") + (String)session.getAttributes().get("eid");
        HashSet<WebSocketSession> set = userWebSocketSet.get(uidAndEid);
        if (set != null) {
            if (set.size() == 0)
                userWebSocketSet.remove(uidAndEid);
            else
                set.remove(session);
        }

        super.afterConnectionClosed(session, status);
    }

    /**
     * 将视频数据推送给指定用户
     * @param message
     * @param uidAndEid
     */
    public void sendToUser(byte[] message, String uidAndEid) {
        if (userWebSocketSet.get(uidAndEid) != null) {
            for (WebSocketSession session : userWebSocketSet.get(uidAndEid)) {
                sendVideo(session, message);
            }
        }
    }

    /**
     * 推送视频数据
     * @param message
     */
    public void sendVideo(WebSocketSession session, byte[] message) {
        try {
            session.sendMessage(new BinaryMessage(message));
        } catch (Exception e) {
        }
    }

}
