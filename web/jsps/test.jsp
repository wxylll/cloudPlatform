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
    </style>
</head>
<body >
    <div id = "container">
        <div id="cen" style="width: 500px;height:500px;margin-left:100px;background-color: red;z-index: 1000;position: absolute; visibility: hidden">
            <iframe name="cenif"></iframe>
        </div>
    </div>
<script type="text/javascript">
    var map,markers;

    window.init = function() {
        createMap('container','${sessionScope.get('receptionUser').jurisdiction}');
    }

    function test(element) {
        //自适应标记点
         map.setFitView();
         document.getElementById('cen').style.visibility = 'visible';
         element.firstElementChild.submit();
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

                    var endIcon = "<div onmouseover='test1(this)' onmouseleave='test2(this)' style='width:20px;height:20px;background-color: red;' onclick='test(this)'>"
                            + "<form method='post' target='cenif' action='${pageContext.request.contextPath}/test.action'></form>"
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

