<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/4/7
  Time: 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=yes" />
    <style type="text/css">
        body, html,#container {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
        .show_div{width: 100%;height: 100%;position: absolute;z-index: 1000;visibility: hidden;}
        .show_div:hover{cursor: default}
        #left {height: 100%;width: 0px;background-color: cadetblue;float: left;transition: all .5s;-webkit-transition: all .5s;box-shadow: 0px 0px 20px rgba(0,0,0,0.5)}
        #right {height: 1000px;width: 0px;background-color: cadetblue;float:right;transition: all .5s;-webkit-transition: all .5s;box-shadow: 0px 0px 20px rgba(0,0,0,0.5)}
        #center {position: absolute;left:17%;width: 66%;height: 98%;margin-top: -50%;background-color: white;transition: all .6s;-webkit-transition: all .6s;border-radius: 10px; box-shadow: 0px 0px 20px rgba(0,0,0,0.5);overflow: hidden}
        #centerIframe {width: 101.8%;height: 95%;border: none;border-radius: 0px 0px 10px 10px;transition: all .6s;-webkit-transition: all .6s;overflow-x: hidden;overflow-y: scroll;}
        #icon:hover{cursor: pointer}
    </style>
</head>
<body>
    <div id = "container" align="center">

        <div id="cen" class="show_div">
            <div id="left">
                <a><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">实时监控</div></a>
                <a href="<c:url value="/showOutliers.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">数据分析</div></a>
                <a href="<c:url value="/showOutliers.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">边缘端管理</div></a>
                <a href="<c:url value="/showOutliers.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">安保人员管理</div></a>
                <a href="<c:url value="/showOutliers.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">实时疏导情况</div></a>
            </div>
            <div id="right"></div>
            <div id="center">
                <div style="width: 100%;height: 5%;background-color: aquamarine;border-radius: 10px 10px 0px 0px;">
                    <img id="icon" onclick="hidde()" style="float: right;margin-top: 2px;margin-right: 2px" width="3%" src="<c:url value="/image/箭头2.png"/> ">
                </div>
                <iframe id="centerIframe" name="centerIframe"></iframe>
            </div>
        </div>

    </div>
<script type="text/javascript">
    var map,markers;

    window.init = function() {
        createMap('container','${sessionScope.get('receptionUser').jurisdiction}');
    }

    function show(element) {
        //自适应标记点
        map.setFitView();
        document.getElementById('cen').style.visibility = 'visible';
        document.getElementById('left').style.width = '16%';
        document.getElementById('right').style.width = '16%';
        document.getElementById('center').style.marginTop = '.5%';
        element.firstElementChild.submit();
    }

    function hidde() {
        document.getElementById('left').style.width = '0%';
        document.getElementById('right').style.width = '0%';
        document.getElementById('center').style.marginTop = '-50%';
        document.getElementById('cen').style.visibility = 'hidden';
    }

    function test1(dom) {
        dom.style.backgroundColor = 'green';
    }

    function test2(dom) {
        dom.style.backgroundColor = 'red';
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
                        //mapStyle: 'amap://styles/18a28064ad41b5db6d016ebac881a059',
                        center: [lng, lat], // 设置地图的中心点
                        zoom: 15 　　　　　　 // 设置地图的缩放级别，0 - 20
                    });
                    //标记监控点
                    var arr = new Array("王府井","长安大厦","天安门广场");
                    for(var pos in arr) {
                        markLocation('${sessionScope.get('receptionUser').jurisdiction}' + ' ' + arr[pos]);
                    }
                }
            });
        });
    }

    //标记地点
    function markLocation(address) {
        AMap.plugin('AMap.Geocoder', function() {
            var geocoder = new AMap.Geocoder();
            geocoder.getLocation(address, function(status, result) {
                if (status === 'complete' && result.info === 'OK') {

                    // 经纬度
                    var lng = result.geocodes[0].location.lng;
                    var lat = result.geocodes[0].location.lat;

                    var endIcon = "<div onmouseover='test1(this)' onmouseleave='test2(this)' style='width:20px;height:20px;background-color: red;' onclick='show(this)'>"
                            + "<form method='post' target='centerIframe' action='${pageContext.request.contextPath}/showDetail.action'></form>"
                            + "</div>";
                    // 添加标记
                    var marker = new AMap.Marker({
                        content:endIcon,
                        map:map,
                        position: new AMap.LngLat(lng, lat),   // 经纬度
                        offset: new AMap.Pixel(-10, -20)
                    });
                } else {
                    console.log('定位失败！');
                }
            });
        });
    }

</script>
<script src="https://webapi.amap.com/maps?v=1.4.13&key=2778de5c45eaa7653553c3d919b956c2&callback=init"></script>
</body>
</html>

