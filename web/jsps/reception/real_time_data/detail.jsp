<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <style>
        * {font-family: 微软雅黑;}
        ._background {border-radius: 3px;background-color: darkgray;color: white;padding: .1% 2% 0% 2%;display: inline-block}
        h1 {font-size: 2rem;font-weight: bold;}
        h2 {font-size: 1.5rem;font-weight: bold;}
        h3 {font-size: 1rem;display: inline-block;font-weight: bold;}
        h4 {font-size: .8rem;font-weight: bold;}
        a {text-decoration:none;out-line: none;color: black;}
        a:hover {text-decoration:none;out-line: none;color: black;}
        a span {font-size: medium;font-family: 黑体;font-weight: bold;opacity: .5;}
        .videoBox {width: 58%;height: 94%;margin-right: 1%;padding: 1%;background-color: white;box-shadow: 0px 0px 8px rgba(10,10,10,.2);border-radius: 3px;float: right;}
        .videoBox img {border-radius: 3px;}
        #history {width: 47%;height: 47%;margin-left: 1%;border-radius: 3px;background-color: #e35b5a;box-shadow: 0px 0px 8px rgba(10,10,10,.2);float: left;}
        #history span {margin-top: 15%;margin-left: 3%;display: inline-block;float: left;}
        #history img {opacity: .5;float: left;}
        #now {width: 47%;height: 47%;margin-left: 3%;border-radius: 3px;background-color: #f29503;box-shadow: 0px 0px 8px rgba(10,10,10,.2);float: left;}
        #now span {margin-top: 15%;margin-left: 3%;display: inline-block;float: left;}
        #now img {opacity: .5;float: left;}
        #last {width: 97%;height: 49.5%;margin-top: 3%;margin-left: 1%;border-radius: 3px;background-color: #44b6ae;box-shadow: 0px 0px 8px rgba(10,10,10,.2);float: left;}
        #last img {margin-top: 20%;opacity: .5;}
        #last div {float: left;margin: 0%;}
        .chartDiv {width: 98.6%;margin-left: .4%;border-radius: 3px;height: 600px;margin-top: 2%;background-color: white;box-shadow: 0px 0px 8px rgba(10,10,10,.2);}
        .title {width: 99%;height: 5%;padding-top: 1%;padding-left: 1%;border-radius: 3px 3px 0px 0px;background-color: rgb(253,253,253);border-bottom: 1px rgba(0,0,0,.1) solid;}
        .title img {float: left;}
        .title span {color: #777;font-size: 12px;display: block;float: left;margin-top: .5%;margin-left: .5%;}
        .guidance h3 {color: #777;font-size: 12px;display: block;margin-top: .5%;}
        .guidanceDiv {width: 98.6%;margin-left: .4%;height:600px;border-radius: 3px;margin-top: 2%;background-color: white;box-shadow: 0px 0px 8px rgba(10,10,10,.2);}
    </style>
</head>
<body onload="forMobile()" style="overflow-x: hidden;">
    <div>
        <div style="width: 98%;padding-top:10px;margin-bottom: 10px;margin-left: 10px"><a href="<c:url value="/showBreakOut.action"/>"><h3>实时监控</h3>&nbsp;<span>&gt;</span>&nbsp;</a><h3><!--显示监控地点，只显示详细地址的最后一个-->${fn:trim(fn:replace(edgeTerminal.monitoring, sessionScope.receptionUser.jurisdiction, ''))}</h3></div>
        <div id="top" style="height: 400px;">
            <div style="width: 38%;height: 100%;float: left;color: white">
                <div id="history">
                    <div>
                        <img width="50%" src="<c:url value="/icon/history.png"/>">
                        <span><h2 id="historyMax">${tempRecord.max}</h2></span>
                    </div>
                    <div align="center" style="width: 100%;float: left;margin-top: 2%"><h3>历史最高</h3></div>
                </div>
                <div id="now">
                    <div>
                        <img width="50%" src="<c:url value="/icon/now.png"/>">
                        <span><h2 id="nowNumber">${tempDatas[0].now}</h2></span>
                    </div>
                    <div align="center" style="width: 100%;float: left;margin-top: 2%"><h3>当前人流</h3></div>
                </div>
                <div id="last">
                    <div style="width: 30%;height: 100%;">
                        <img width="100%" src="<c:url value="/icon/last.png"/>">
                    </div>
                    <div style="width: 70%;height: 25%;margin-top: 6%">
                        <h4 style="display: inline-block">开始时间：&nbsp;&nbsp;&nbsp;&nbsp;</h4><span style="font-size: .8rem"><fmt:formatDate value="${tempRecord.startTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></span>
                    </div>
                    <div style="width: 70%;height: 75%;">
                        <h3>持续时间：</h3>
                        <div align="center" style="width: 98%;margin-top: 1%"><h1 id="lastTime">${lastTime}</h1></div>
                    </div>
                </div>
            </div>
            <div align="center" class="videoBox">
                <div style="width: 100%;height: 100%;border-radius: 3px;background-color: rgba(0,0,0,.01)">
                    <img id="imgData" style="width: 100%;height: 100%;" alt="">
                    <img id="img_load" style="height: 15%;margin-top: -32%;" src="<c:url value="/image/loading.gif"/>"/>
                </div>
            </div>
        </div>
    </div>
    <div class="chartDiv">
        <div class="title">
            <img height="80%" src="<c:url value="/icon/chart.png"/>">
            <span>人流变化趋势</span>
        </div>
        <div id="chart" style="width: 98%;height: 88%;margin-left: 1%;margin-top:1%;"></div>
    </div>
    <div class="guidanceDiv">
        <div class="title">
            <img height="80%" src="<c:url value="/icon/guidance.png"/>">
            <span>疏导人员推荐</span>
        </div>
        <div align="center" style="width: 100%;height: 50%;">
            <div id="guidance" style="width: 98%">
                <c:if test="${tempRecord.status eq 0 and staffs != null}">
                    <h3>推荐派遣以下人员前往疏导</h3>
                    <table id="edge_table" class="layui-hide" lay-filter="test"></table>
                    <div>
                        <button type="button" onclick="assign()" class="layui-btn">派遣选中人员</button>
                    </div>
                </c:if>
                <c:if test="${tempRecord.status eq 0 and staffs == null}">
                    <div style="margin-top: 50px;color: #777;"><h3>---暂无合适人选！---</h3></div>
                </c:if>
                <c:if test="${tempRecord.status eq 1}">
                    <div style="margin-top: 50px;color: #777;"><h3>---正在疏导中！---</h3></div>
                </c:if>
            </div>
        </div>
    </div>
    <div style="width: 100%;height: 5%;display: block;"></div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    //防止页面后退
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });

    var myChart = echarts.init(document.getElementById('chart'));
    var date = [<c:forEach items="${tempDatas}" var="tempData">'${tempData.time}',</c:forEach>];
    var data = [<c:forEach items="${tempDatas}" var="tempData">'${tempData.now}',</c:forEach>];
    var eid = '${edgeTerminal.eid}';
    //计算表格纵坐标最大值，以适应显示
    var max = Math.max.apply(null,data);
    max = max + max * 0.2

    //获取ip
    var curWwwPath = window.document.location.href;
    var pathname = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathname);
    var localhostPath = curWwwPath.substring(7, pos);

    /*连接视频推送socket*/
    var url1 = "ws://" + localhostPath + "/realTimeVideoData.action?isEdge=false&uid=" + "${receptionUser.uid}" + "&eid=" + eid;
    var wc1 =new WebSocket(url1); //接收视频数据推送

    wc1.onopen = function(evt) {
        wc1.binaryType = 'blob';
    };

    wc1.onmessage = function(evt) {
        var reader = new FileReader();
        reader.readAsDataURL(evt.data);
        reader.onload = function(evt){
            if(evt.target.readyState == FileReader.DONE){
                var url = evt.target.result;
                var img = document.getElementById("imgData");
                document.getElementById("img_load").style.display = "none"
                img.src = new URL("data:image/jpg" + url.toString().slice(5,url.toString().length)) //显示推送图片
            }
        }
    };

    wc1.onerror = function() {
        wc1 =new WebSocket(url1); //出错重连
    }

    wc1.onclose = function(evt) {
        wc1 =new WebSocket(url1); //断开重连
    };

    /*连接消息推送socket*/
    var url2 = "ws://" + localhostPath + "/realTimeTextData.action?isEdge=false&uid=" + "${receptionUser.uid}";
    var wc2 =new WebSocket(url2); //接收消息推送

    wc2.onopen = function(evt) {
        wc2.binaryType = 'arraybuffer'
    }

    //解析推送数据
    wc2.onmessage = function(evt) {
        if (evt.data.substring(0,5) == 'data:') { //是否为数据
            var content = evt.data.substring(5);
            content = content.split(',');
            if (content[2] == eid) { //是否推送给此页面
                data.push(content[0]);
                date.push(content[1]);
                max = Math.max.apply(null,data);
                document.getElementById('historyMax').innerText = max;
                document.getElementById('nowNumber').innerText = content[0];
                max = max + max * 0.2;
                myChart.setOption(option);
            }
        }
    };

    wc2.onerror = function() {
        wc2 =new WebSocket(url2); //出错重连
    }

    wc2.onclose = function(evt) {
        wc2 =new WebSocket(url2); //断开重连
    };


    option = {
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: date
        },
        tooltip: {
            trigger: 'axis'
        },
        yAxis: {
            boundaryGap: [0, '50%'],
            type: 'value',
            max: max,
            axisLine: {onZero: false}
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
                color: 'rgba(0,0,0,.3)',
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
                        yAxis: parseInt('${edgeTerminal.threshold}')
                    }]
                }
            }
        ]
    };
    myChart.setOption(option);

    //计算持续时间
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

    function IsPC() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break;
            }
        }
        return flag;
    }

    function forMobile() {
        if (!IsPC()) {
            document.getElementById("top").style.height = "350px"
        }
    }

    var data = [<c:forEach items="${staffs}" var="staff">
        {"ssid":"${staff.ssid}",
            "name":"${staff.name}",
            "workPlace":"${staff.workPlace}",
            "distance":"${staff.distance}",
            "time":"${staff.time}"},
        </c:forEach>]

    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#edge_table'
            ,id:'t1'
            ,data: data
            ,initSort:{field:'time',type:'asc'}
            ,cols: [[ //表头
                {field: 'name', title: '姓名',fixed: 'left'}
                ,{field: 'workPlace', title: '任职地点'}
                ,{field: 'distance', title: '步行距离(米)',sort:true}
                ,{field: 'time', title: '步行时间(分)',sort:true
                    ,templet: function(d){
                        if (d.time < 30)
                            return '<span class="_background" style="background-color:green">' + d.time + '</span>'
                        else if (d.time < 90 )
                            return '<span class="_background" style="background-color:orange">' + d.time + '</span>'
                        else
                            return '<span class="_background" style="background-color:#c00">' + d.time + '</span>'
                    }}
                ,{type:'checkbox',fixed:'right'}
            ]]
        });

    });

    function assign() {
        var selected = layui.table.checkStatus('t1').data
        if (selected.length == 0) {
            layer.msg("请先选择要指派的人员！",{offset:400})
            return
        }
        var staffs = selected[0].ssid
        for (var i = 1; i < selected.length; i++) {
            staffs += ',' + selected[i].ssid
        }
        alert("123")
        $.ajax({
            url:'${pageContext.request.contextPath}/assign.action?staffs=' + staffs + "&eid=" + eid,
            type:'get',
            success:function(data){
                if (data == 'succeed') {
                    layer.msg("指派成功！",{offset:400})
                    location.reload(true)
                }else {
                    layer.msg("指派失败！",{offset:400})
                }
            }
        })
    }

</script>
</body>
</html>
