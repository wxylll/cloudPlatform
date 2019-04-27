<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/4/21
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div style="width: 100%;height: 100%">
        <div style="width: 100%;height: 5%;background-color: darkgray"></div>
        <table>
            <tr><td>设备id</td><td>监管地点</td><td>地点分类</td></tr>
            <c:forEach items="${edgeTerminals}" var="edgeTerminal">
                <tr><td>${edgeTerminal.eid}</td><td>${edgeTerminal.monitoring}</td><td>${edgeTerminal.positionCategory}</td></tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
