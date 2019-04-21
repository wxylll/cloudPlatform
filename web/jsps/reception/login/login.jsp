<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/4/5
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" type="text/css">
</head>
<body>
    <center>
    <div class="login_div">
        <span>${loginError}</span>
        <img id="logo" src="${pageContext.request.contextPath}/image/logo.png"/>
        <form id="loginForm" action="<c:url value="/login.action"/>" method="post">
            &nbsp;
            <input id="username" name="username" type="text" placeholder="请输入用户名" value="" onfocus="getFocus(this.id);" onblur="noFocus(this.id);"  oninput="change(this.id)"/>
            <span id="nameMsg"></span><br/>

            <input id="password" name="password" type="text" placeholder="请输入密码" value="" onfocus="getFocus(this.id);" onblur="noFocus(this.id);" oninput="change(this.id)"/>
            <span id="passwordMsg"></span>
        </form>
        <button  id="loginbutton" onclick="toSubmit()">登录</button>
    </div>
    </center>
</body>
<script>
    function getFocus(id){
        document.getElementById(id).setAttribute("placeholder","");
    }

    function noFocus(id){
        if(id == "username"){
            document.getElementById(id).setAttribute("placeholder","请输入用户名");
        }else{
            document.getElementById(id).setAttribute("placeholder","请输入密码");
        }
    }

    function toSubmit() {
        if (document.getElementById('username').value.trim() == '')  {
            document.getElementById('nameMsg').innerText = "用户名不能为空！";
            return false;
        }
        if (document.getElementById('password').value.trim() == '') {
            document.getElementById('passwordMsg').innerText  = "密码不能为空！";
            return false;
        }
        document.getElementById('loginForm').submit();
    }

    function change(id) {
        if(id == "username"){
            if (document.getElementById('username').value.trim() == '')  {
                document.getElementById('nameMsg').innerText = "用户名不能为空！";
            }else {
                document.getElementById('nameMsg').innerText = "";
            }
        }else {
            if (document.getElementById('password').value.trim() == '') {
                document.getElementById('passwordMsg').innerText  = "密码不能为空！";
            }else {
                document.getElementById('passwordMsg').innerText = "";
            }
        }
    }
</script>
</html>
