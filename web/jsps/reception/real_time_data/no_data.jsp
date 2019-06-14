<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/6/6
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <style>
        * {font-family: 微软雅黑;}
        h1 {font-size: 2rem;font-weight: bold;}
        h2 {font-size: 1.5rem;font-weight: bold;}
        h3 {font-size: 1rem;display: inline-block;font-weight: bold;}
        h4 {font-size: .8rem;font-weight: bold;}
        a {text-decoration:none;out-line: none;color: black;}
        a:hover {text-decoration:none;out-line: none;color: black;}
        a span {font-size: medium;font-family: 黑体;font-weight: bold;opacity: .5;}
    </style>
</head>
<body>
<div style="width: 98%;margin-bottom: 10px;margin-top: -15px"><a href="<c:url value="/showBreakOut.action"/>"><h3>实时监控</h3>&nbsp;<span>&gt;</span>&nbsp;</a><h3><!--显示监控地点，只显示详细地址的最后一个-->${fn:trim(fn:replace(edgeTerminal.monitoring, sessionScope.receptionUser.jurisdiction, ''))}</h3></div>
<div align="center" style="margin-top: 5%">
    <h1>---暂无数据---</h1>
</div>
<script>
    //防止页面后退
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });
</script>
</body>
</html>
