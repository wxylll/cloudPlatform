<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/9
  Time: 13:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="screen-orientation" content="portrait"><!-- uc强制竖屏 -->
    <meta name="x5-orientation" content="portrait"><!-- QQ强制竖屏 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/jsps/mobile/main.css" type="text/css">
    <style>
        body .layui-msg-1 {background-color: rgba(0,0,0,0); boder:none}
        body .layui-msg-1 .layui-layer-content{background-color: #c00; color:white; border-radius:10px; border:none;}
        body .layui-msg-2 {background-color: rgba(0,0,0,0); boder:none}
        body .layui-msg-2 .layui-layer-content{background-color: rgba(46,139,87,.8); color:white; border-radius:10px; border:none;}
        body .layui-msg-3 {background-color: rgba(0,0,0,0); boder:none}
        body .layui-msg-3 .layui-layer-content{background-color: rgba(222,184,135,.8); color:white; border-radius:10px; border:none;}
    </style>
</head>
<body>
    <div id="warning" align="center" style="position: absolute;width: 100%;height: 100%;z-index: 2000;display: none;background-color: black;color: white;">
        <h1 style="margin-top: 25%">请竖屏操作以获得良好的体验</h1>
    </div>
    <a id="confirmLogout" href="<c:url value="/logout.action"/>"></a>
    <div class="head_div" id="head">
        <div class="back_but" onclick="onclick_back();">
            <img src="<c:url value="/icon/back.png"/>" width="60" height="60">
        </div>
    </div>
    <div class="map_div" id="map"></div>
    <iframe name="center" id="ifr"></iframe>
    <div class="menu_div" id="menu">
        <a class="menu_item" id="1" href="<c:url value="/showBreakOut.action"/>" target="center" onclick="onclick_a();"><img src="<c:url value="/icon/monitoring.png"/>" width="80" height="80"></a>
        <a class="menu_item" id="2" href="<c:url value="/showOutliers.action"/>" target="center" onclick="onclick_a();"><img src="<c:url value="/icon/table.png"/>" width="80" height="80"></a>
        <a class="menu_item" id="3" href="<c:url value="/showTerminal.action"/>" target="center" onclick="onclick_a();"><img src="<c:url value="/icon/device.png"/>" width="80" height="80"></a>
        <a class="menu_item" id="4" href="<c:url value="/showSecurityStaffs.action"/>" target="center" onclick="onclick_a();"><img src="<c:url value="/icon/staff.png"/>" width="80" height="80"></a>
        <a class="menu_item" id="5" href="javascript:void(0)" target="center" onclick="confirmLogout()"><img src="<c:url value="/icon/logout.png"/>" width="80" height="80"></a>
        <div class="image_div" onclick="onclick_img();">
            <img src="<c:url value="/image/head.jpg"/>" width="240" height="240">
        </div>
    </div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    var map;
    var count=0;
    var arr= [[340,340],[53,417],[53,263],[130,130],[263,53],[417,53]];

    window.onorientationchange=function(){
        if(window.orientation==90||window.orientation==-90){
            document.getElementById('warning').style.display = 'block'
            document.getElementById('warning').style.width = document.body.clientWidth
            document.getElementById('warning').style.height = document.body.clientHeight
        }else{
            document.getElementById('warning').style.display = 'none'
        }
    }

    window.init = function() {
        createMap('map','${sessionScope.get('receptionUser').jurisdiction}'); //创建地图
    }

    //询问是否退出
    function confirmLogout() {
        layui.use('layer', function(){
            var layer = layui.layer;
            layer.confirm('您确定要退出？'
                ,{skin: 'layui-layer-lan',btn:['确定','取消']}
                ,function () {
                    document.getElementById('confirmLogout').click();
                }
            );
        });
    }

    function onclick_img() {
        if(count%2!=0){
            document.getElementById("menu").style.backgroundColor="rgba(0,0,0,0)";
            count++;
            for (var i=1;i<=5;i++){
                move(i,arr[0]);
            }
        }else {
            document.getElementById("menu").style.backgroundColor="rgba(0,0,0,.1)";
            count--;
            for (var i=1;i<=5;i++){
                move(i,arr[i]);
            }
        }
    }

    function move(i,a) {
        document.getElementById(i).style.top=a[0];
        document.getElementById(i).style.left=a[1];
    }

    function onclick_a() {
        document.getElementById("menu").style.opacity="0";
        document.getElementById("head").style.display="block";
        document.getElementById("ifr").style.display="block";
        document.getElementById("map").style.display="none";
        document.getElementById("menu").style.backgroundColor="rgba(0,0,0,0)";
        count++;
        for (var i=1;i<=5;i++){
            move(i,arr[0]);
        }
    }
    function onclick_back() {
        document.getElementById("menu").style.opacity="1";
        document.getElementById("head").style.display="none";
        document.getElementById("ifr").style.display="none";
        document.getElementById("map").style.display="block";
    }
    //地图标记点被点击
    function markerSubmit(ele) {
        //自适应标记点
        map.setFitView();
        ele.firstElementChild.submit();
    }

    //创建地图
    function createMap(mapId, centerAddress) {
        AMap.plugin('AMap.Geocoder', function() {
            var geocoder = new AMap.Geocoder();
            geocoder.getLocation(centerAddress, function (status, result) {
                if (status === 'complete' && result.info === 'OK') {

                    // 经纬度
                    var lng = result.geocodes[0].location.lng;
                    var lat = result.geocodes[0].location.lat;

                    // 地图实例
                    map = new AMap.Map(mapId, {
                        resizeEnable: true, // 允许缩放
                        viewMode: '3D',
                        pitch: 60,
                        center: [lng, lat], // 设置地图的中心点
                        zoom: 15 　　　　　　 // 设置地图的缩放级别，0 - 20
                    });
                    //标记监控点
                    <c:forEach items="${jurisdictions}" var="jurisdiction">
                    markLocation('${jurisdiction.monitoring}','${jurisdiction.eid}');
                    </c:forEach>
                }
            });
        });
    }

    //标记地点
    function markLocation(position,eid) {
        AMap.plugin('AMap.Geocoder', function() {
            var geocoder = new AMap.Geocoder();
            geocoder.getLocation(position, function(status, result) {
                if (status === 'complete' && result.info === 'OK') {

                    // 经纬度
                    var lng = result.geocodes[0].location.lng;
                    var lat = result.geocodes[0].location.lat;

                    var endIcon = "<div id='" + eid + "' style='width:19px;height:31px;background-image:url(${pageContext.request.contextPath}/image/mark_b.png);' onclick='onclick_a();markerSubmit(this);'>"
                        + "<form method='post' target='center' action='${pageContext.request.contextPath}/showDetail.action'>"
                        + "<input type='hidden' name='position' value='" + position + "'/>"
                        + "<input type='hidden' name='eid' value='" + eid + "'/>"
                        +"</form>"
                        + "</div>";
                    // 添加标记
                    var marker = new AMap.Marker({
                        content:endIcon,
                        map:map,
                        position: new AMap.LngLat(lng, lat),   // 经纬度
                    });
                } else {
                    console.log('定位失败！');
                }
            });
        });
    }

    //获取ip
    var curWwwPath = window.document.location.href;
    var pathname = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathname);
    var localhostPath = curWwwPath.substring(7, pos);

    /*连接消息推送socket*/
    var url = "ws://" + localhostPath + "/realTimeTextData.action?isEdge=false&uid=" + "${receptionUser.uid}";
    var wc =new WebSocket(url); //接收消息推送

    wc.onopen = function(evt) {
        wc.binaryType = 'arraybuffer'
    }

    //解析推送数据
    wc.onmessage = function(evt) {
        if (evt.data.substring(0,5) == 'data:') { //是数据推送

            var content = evt.data.substring(5);
            content = content.split(',');
            document.getElementById(content[2]).style.backgroundImage = 'url(${pageContext.request.contextPath}/image/mark_r.png)'

        } else if (evt.data.substring(0,4) == 'msg:') {  //其他消息推送

            var content = evt.data.substring(4);
            if (content.substring(0,5) == 'burst') {
                var eid = content.substring(5)
                layui.use('layer', function() {
                    var $ = layui.jquery, layer = layui.layer;
                    layer.msg("有地点人流爆发！",{skin: 'layui-msg-1'})
                })
                document.getElementById(eid).style.backgroundImage = 'url(${pageContext.request.contextPath}/image/mark_r.png)'

            } else if (content.substring(0,3) == 'end') {

                var eid = content.substring(3)
                layui.use('layer', function() {
                    var $ = layui.jquery, layer = layui.layer;
                    layer.msg("有地点解除报警！", {skin: 'layui-msg-2'})
                })
                document.getElementById(eid).style.backgroundImage = 'url(${pageContext.request.contextPath}/image/mark_b.png)'

            } else if (content.substring(0,3) == 'new') {

                layui.use('layer', function() {
                    var $ = layui.jquery, layer = layui.layer;
                    layer.msg("有新设备接入，请前往处理！", {skin: 'layui-msg-3'})
                })

            }
        }
    };

    wc.onerror = function() {
        wc =new WebSocket(url); //出错重连
    }

    wc.onclose = function(evt) {
        wc =new WebSocket(url); //断开重连
    };

</script>
<script src="https://webapi.amap.com/maps?v=1.4.13&key=2778de5c45eaa7653553c3d919b956c2&callback=init"></script>
</html>
