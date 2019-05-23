package cn.baimu.websocket;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request,
                                   ServerHttpResponse response, WebSocketHandler wsHandler,
                                   Map<String, Object> attributes) throws Exception {
        HttpServletRequest req = ((ServletServerHttpRequest) request).getServletRequest();
        System.out.println(req.getParameter("isEdge") + " " + req.getParameter("eid") + " " + req.getParameter("uid"));
        attributes.put("isEdge",req.getParameter("isEdge"));
        if (req.getParameter("eid") != null)
            attributes.put("eid",req.getParameter("eid"));
        if (req.getParameter("uid") != null)
            attributes.put("uid",req.getParameter("uid"));
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }

    @Override
    public void afterHandshake(ServerHttpRequest request,
                               ServerHttpResponse response, WebSocketHandler wsHandler,
                               Exception ex) {
        super.afterHandshake(request, response, wsHandler, ex);
    }

}
