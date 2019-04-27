<%--
  Created by IntelliJ IDEA.
  User: 小星星
  Date: 2019/4/20
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
details
<div id="msg"></div>
<script>
    var wc =new WebSocket("ws://localHost:8080/socket.action");
    wc.onopen = function(evt) {
        document.getElementById('msg').innerText += "Connection open ..."
        ws.send("Hello WebSockets!");
    };

    wc.onerror = function() {
        alert(wc.url)
    }

    wc.onmessage = function(evt) {
        document.getElementById('msg').innerText += "Received Message: " + evt.data + "\n"
        ws.close();
    };

    wc.onclose = function(evt) {
        document.getElementById('msg').innerText += "Connection closed."
    };
</script>
</body>
</html>
