package cn.baimu.websocket.handler;

import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

public class RealTimeDataHandler extends BinaryWebSocketHandler {

    //用户连接
    private static ConcurrentHashMap<String, HashSet<WebSocketSession>> userWebSocketSet = new ConcurrentHashMap<>();
    //边缘端连接
    private static ConcurrentHashMap<String, WebSocketSession> edgeWebSocketSet = new ConcurrentHashMap<>();

    //初次连接成功
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println(session.getAttributes());
        System.out.println(Boolean.valueOf((String)session.getAttributes().get("isEdge")) + ":" + (String) session.getAttributes().get("eid"));
        //判断连接是用户还是边缘端
        if (Boolean.valueOf((String)session.getAttributes().get("isEdge"))) {
            String eid = (String) session.getAttributes().get("eid");
            edgeWebSocketSet.put(eid, session);
        } else {
            String uid = (String) session.getAttributes().get("uid");
            HashSet<WebSocketSession> set = userWebSocketSet.get(uid);
            set = null == set ? new HashSet<>() : set;
            set.add(session);
            userWebSocketSet.put(uid, set);
            System.out.println(session.getAttributes());
            System.out.println(userWebSocketSet);
            System.out.println( userWebSocketSet.get(uid) + ":" + uid);
        }
        super.afterConnectionEstablished(session);
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        System.out.println(session.getAttributes().get("uid") + "****");
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
            userWebSocketSet.get(session.getAttributes().get("uid")).remove(session);
        }

        super.afterConnectionClosed(session, status);
    }

    public void sendVideo(byte[] message, String uid) {
        if (userWebSocketSet.get(uid) != null) {
            System.out.println(userWebSocketSet.get(uid));
            for (WebSocketSession session : userWebSocketSet.get(uid)) {
                if (session.isOpen()) {
                    try {
                        session.sendMessage(new BinaryMessage(message));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    public void sendToEdge() {

    }

}
