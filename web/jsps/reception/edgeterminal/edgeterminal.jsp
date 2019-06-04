<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <style>
        tr:hover {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div style="width: 100%;height: 100%">
        <div style="width: 100%;height: 5%;background-color: darkgray"></div>
        <table>
            <tr><th>设备id</th><th>监管地点</th><th>地点分类</th><th>人流阈值</th><th>监管状态</th><th>连接状态</th></tr>
            <c:forEach items="${edgeTerminals}" var="edgeTerminal">
                <tr>
                    <td>${edgeTerminal.eid}</td>
                    <td>${fn:split(edgeTerminal.monitoring, " ")[fn:length(fn:split(edgeTerminal.monitoring, " ")) - 1]}</td>
                    <td>
                        <c:if test="${empty edgeTerminal.positionCategory}">未设置</c:if>
                        <c:if test="${!empty edgeTerminal.positionCategory}">${edgeTerminal.positionCategory}</c:if>
                    </td>
                    <td>${edgeTerminal.threshold}</td>
                    <td>
                        <c:if test="${edgeTerminal.status eq 1}">已监管</c:if>
                        <c:if test="${edgeTerminal.status eq 0}">未监管</c:if>
                    </td>
                    <td>
                        <c:if test="${edgeTerminal.online}">正常</c:if>
                        <c:if test="${!edgeTerminal.online}">已断开</c:if>
                    </td>
                </tr>
                <div style="background-color: #f29503;width: 20%;height: 30%;position: relative;">

                </div>
            </c:forEach>
        </table>
    </div>
</body>
</html>
