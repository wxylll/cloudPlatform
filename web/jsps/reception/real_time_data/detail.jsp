<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <style>
        * {
            font-family: 微软雅黑;
        }
        h2 {
            font-size: 1.5rem;
        }
        h3 {
            font-size: 1rem;
        }
        h4 {
            font-size: .8rem;
        }
        .videoBox {
            width: 59%;
            height: 94%;
            margin-right: 1%;
            padding: 1%;
            background-color: white;
            box-shadow: 0px 0px 8px rgba(10,10,10,.2);
            border-radius: 3px;
            float: right;
        }
        .videoBox img {
            border-radius: 3px;
        }
        #history {
            width: 47%;
            height: 47%;
            margin-left: 1%;
            border-radius: 3px;
            background-color: #e35b5a;
            box-shadow: 0px 0px 8px rgba(10,10,10,.2);
            float: left;
        }
        #history span {
            margin-top: 5%;
            margin-left: 3%;
            display: inline-block;
            float: left;
        }
        #history img {
            opacity: .5;
            float: left;
        }
        #now {
            width: 47%;
            height: 47%;
            margin-left: 3%;
            border-radius: 3px;
            background-color: #f29503;
            box-shadow: 0px 0px 8px rgba(10,10,10,.2);
            float: left;
        }
        #now span {
            margin-top: 5%;
            margin-left: 3%;
            display: inline-block;
            float: left;
        }
        #now img {
            opacity: .5;
            float: left;
        }
        #last {
            width: 97.5%;
            height: 49.5%;
            margin-top: 3%;
            margin-left: 1%;
            border-radius: 3px;
            background-color: #44b6ae;
            box-shadow: 0px 0px 8px rgba(10,10,10,.2);
            float: left;
        }
        #last img {
            margin-top: 20%;
            opacity: .5;
        }
        #last div {
            float: left;
            margin: 0%;
        }
    </style>
</head>
<body style="background-color: rgba(255,255,255,0.98)">
    <div>
        <div style="width: 98%;margin-bottom: 10px;"><h3>${position}</h3></div>
        <div style="height: 50%;">
            <div style="width: 38%;height: 100%;float: left;color: white">
                <div id="history">
                    <div>
                        <img width="50%" src="<c:url value="/icon/history.png"/>">
                        <span><h2>1000</h2></span>
                    </div>
                    <div align="center" style="width: 100%;float: left"><h3>历史最高</h3></div>
                </div>
                <div id="now">
                    <div>
                        <img width="50%" src="<c:url value="/icon/now.png"/>">
                        <span><h2>850</h2></span>
                    </div>
                    <div align="center" style="width: 100%;float: left"><h3>当前人流</h3></div>
                </div>
                <div id="last">
                    <div style="width: 30%;height: 100%;">
                        <img width="100%" src="<c:url value="/icon/last.png"/>">
                    </div>
                    <div style="width: 70%;height: 25%;">
                        <h4 style="display: inline-block">开始时间：&nbsp;&nbsp;&nbsp;&nbsp;</h4><span style="font-size: .8rem">2019年6月2日 10:26:35</span>
                    </div>
                    <div style="width: 70%;height: 75%;">
                        <h3>持续时间：</h3>
                        <div align="center" style="width: 98%;margin-top: -5%"><h1 id="lastTime">00:00:00</h1></div>
                    </div>
                </div>
            </div>
            <div align="center" class="videoBox">
                <img id="imgData" style="height: 15%;margin-top: 20%" src="<c:url value="/image/loading.gif"/>"/>
            </div>
        </div>
    </div>
    <div style="width: 100%;height: 500px;padding-top: 10px">
        <div style="border: 1px solid;width: 100%;height: 400px;">
            <div id="chart" style="width: 100%;height: 50%;margin-left: 1%;"></div>
        </div>
    </div>
<script>

    var myChart = echarts.init(document.getElementById('chart'));
    var date = ['2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00','2019/5/01/22:12:00'];
    var data = [20,200,86,10,15,68,400,26,65,165,65,86,35,300,
    65];

    var url = "ws://localhost:8080/realTimeData.action?isEdge=false&uid=" + "${receptionUser.uid}"
    var wc =new WebSocket(url);
    var wc2 =new WebSocket("ws://localhost:8080/socket.action");
    wc.onopen = function(evt) {
        wc.binaryType = 'blob';
        ws.send("Hello WebSockets!");
    };

    wc2.onopen = function(evt) {
        wc2.binaryType = 'arraybuffer'
    }

    wc.onerror = function() {
        alert(wc.url)
    }

    wc.onmessage = function(evt) {
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

    wc2.onmessage = function(evt) {
        data.push(evt.data)
        console.log(evt.data)
        date.push('123')
        if (data.length > 100)  {
            data.shift();
            date.shift();
        }

        myChart.setOption(option);
    };

    wc.onclose = function(evt) {
        document.getElementById('msg').innerText += "Connection closed."
    };

    option = {
        xAxis: {
            show:false,
            type: 'category',
            boundaryGap: false,
            data: date
        },
        tooltip: {
            trigger: 'axis'
        },
        yAxis: {
            show:false,
            boundaryGap: [0, '50%'],
            type: 'value'
        },
        grid: {
            left: 0,
            right: 19,
            top: 0,
            bottom: 0
        },
        series: [
            {
                name:'人数',
                type:'line',
                smooth:true,
                symbol: 'none',
                color: 'none',
                areaStyle: {
                    color: '#2894FF'
                },
                data: data,
                markLine: {
                    silent: true,
                    symbol: 'none',
                    lineStyle: {
                        type: 'solid',
                        color: 'red'
                    },
                    data: [{
                        yAxis: 20
                    }]
                }
            }
        ]
    };
    myChart.setOption(option);

    setInterval("getLastTime();",1000);

    function getLastTime() {
        var ele = document.getElementById('lastTime');
        var lastTime = ele.innerText.split(':');
        for (var i = 0; i < lastTime.length; i++) {
            lastTime[i] = parseInt(lastTime[i]);
        }
        lastTime[2] += 1;
        if (lastTime[2] >= 60) {
            lastTime[2] = 0;
            lastTime[1] += 1;
            if (lastTime[1] >= 60) {
                lastTime[1] = 0;
                lastTime[0] += 1;
            }
        }
        for (var i = 0; i < lastTime.length; i++) {
            if ((lastTime[i] + '').length < 2)
                lastTime[i] = 0 + '' + lastTime[i];
        }
        ele.innerText = lastTime[0] + ':' + lastTime[1] + ':' + lastTime[2];
    }

</script>
</body>
</html>
