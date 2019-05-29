package cn.baimu.websocket.handler;

import org.bytedeco.javacv.Frame;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.HashSet;

public class WebsocketEndPoint extends TextWebSocketHandler {

    private HashSet<WebSocketSession> sessions = new HashSet<>();

    @Override
    protected void handleTextMessage(WebSocketSession session,
                                     TextMessage message) throws Exception {
        super.handleTextMessage(session, message);
        System.out.println(session + ":" + message);
    }

    @Override
    protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
        super.handleBinaryMessage(session, message);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        super.afterConnectionEstablished(session);
        sessions.add(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        super.afterConnectionClosed(session, status);
    }

    public void sendMessage(String message) throws IOException {
        for (WebSocketSession session : sessions)
            session.sendMessage(new TextMessage(message));
    }

    public void sendVideo(byte[] message) throws IOException {
        for (WebSocketSession session : sessions)
            if (session.isOpen())
                session.sendMessage(new BinaryMessage(message));
    }

}
