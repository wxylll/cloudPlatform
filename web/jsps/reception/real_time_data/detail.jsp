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
        .msgBox {
            height: 150px;
            width: 40%;
            float: left;
            margin-left: 6%;
        }
        .dataBox {
            width:33%;
            height:94%;
            background-color: white;
            float:right;
            margin-right: 1%;
            box-shadow: 0px 0px 8px rgba(10,10,10,.2);
            border-radius: 3px;
            padding:1%;
        }
        .videoBox {
            width: 59%;
            height: 94%;
            margin-left: 1%;
            padding: 1%;
            background-color: white;
            box-shadow: 0px 0px 8px rgba(10,10,10,.2);
            border-radius: 3px;
            float: left;
        }
    </style>
</head>
<body style="background-color:rgb(245,245,245)">
    <div>
        <div style="width: 98%;margin-bottom: 10px;"><h3>${position}</h3></div>
        <div style="height: 50%;">
            <div class="videoBox">
                <img id="imgData" style="width: 100%;height: 100%;" src="<c:url value="/jsps/reception/real_time_data/456.jpg"/>"/>
            </div>
            <div class="dataBox">
                <div style="width: 100%;height: 5%;">实时人流</div>
                <hr style="opacity: 0.5"/>
                <div id="chart" style="width: 100%;height: 50%;margin-left: 1%;"></div>
                <div align="center" style="width: 98%;padding: 1%">
                    <div class="msgBox">
                        <h3>历史最高</h3>
                        <h3>80</h3>
                    </div>
                    <div class="msgBox">
                        <h3>当前人流</h3>
                        <h3>80</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="width: 100%;height: 500px;padding-top: 10px">
        <div style="border: 1px solid;width: 100%;height: 400px;">

        </div>
    </div>
<script>

    var myChart = echarts.init(document.getElementById('chart'));
    myChart.showLoading();
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
    myChart.hideLoading();

</script>
</body>
</html>
