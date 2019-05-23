<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 小星星
  Date: 2019/4/20
  Time: 19:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
</head>
<body>
<div id="msg"></div>
<div id="imgDiv" style="width:100%;height:200px;background-color:red;" onclick="fun()"></div>
<div id="imgD" style="width:100%;height:200px;background-color:green;" onclick="fun2()"></div>
<img id="imgData" src="" >
<input id="inp"/>
<canvas id="mycanvas" width="500" height="500"></canvas>
<script>

    var wc;

    wc.onopen = function(evt) {
        if (typeof WebSocket == 'undefined') {
            alert("不支持")
        } else{
            alert("支持")
        }
        document.getElementById('msg').innerText += "Connection open ..."
        wc.binaryType = "blob";

        //wc.send("Hello WebSockets!123456");
    };

    wc.onerror = function() {
        if (typeof WebSocket == 'undefined') {
            alert("不支持")
        } else{
            alert("支持")
        }
        alert(wc.url)
    }

    wc.onmessage = function(evt) {
        // alert(URL.createObjectURL(evt.data));
        // var img = document.getElementById("imgData").src = URL.createObjectURL(evt.data);
        //
        // img.onload = function() {
        //     window.URL.revokeObjectURL(this.src);
        // }

            var reader = new FileReader();
        reader.readAsDataURL(evt.data);
        reader.onload = function(evt){
            if(evt.target.readyState == FileReader.DONE){
                var url = evt.target.result;
                var img = document.getElementById("imgData");
                img.src = new URL("data:image/jpg" + url.toString().slice(5,url.toString().length))
            }
        }
    };

    wc.onclose = function(evt) {
        document.getElementById('msg').innerText += "Connection closed."
    };

    function fun() {
        wc =new WebSocket("ws://10.104.9.70:8080/realTimeData.action?isEdge=false&uid=" + document.getElementById('inp').value);
    }

    function fun2() {
        wc.send(new ArrayBuffer("123"));
    }

</script>
</body>
</html>
