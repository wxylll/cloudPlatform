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
<body>
<div id = "container"></div>
<script src="https://webapi.amap.com/maps?v=1.4.13&key=2778de5c45eaa7653553c3d919b956c2"></script>
<script type="text/javascript">
    var map,markers;
    AMap.plugin('AMap.Geocoder', function() {
        var geocoder = new AMap.Geocoder();
        geocoder.getLocation('长春工业大学', function (status, result) {
            if (status === 'complete' && result.info === 'OK') {

                // 经纬度
                var lng = result.geocodes[0].location.lng;
                var lat = result.geocodes[0].location.lat;

                // 地图实例
                map = new AMap.Map('container', {
                    resizeEnable: true, // 允许缩放
                    viewMode: '3D',
                    pitch: 60,
                    center: [lng, lat], // 设置地图的中心点
                    zoom: 15 　　　　　　 // 设置地图的缩放级别，0 - 20
                });
            }
        });
    });
    markers = [{address:'长春工业大学'},
        {address:'长春 南湖广场'},
        {address:'长春 远创国际'}];
    markers.forEach(
        function(item) {
            AMap.plugin('AMap.Geocoder', function () {
                var geocoder = new AMap.Geocoder();
                geocoder.getLocation(item.address, function (status, result) {
                    if (status === 'complete' && result.info === 'OK') {

                        // 经纬度
                        var lng = result.geocodes[0].location.lng;
                        var lat = result.geocodes[0].location.lat;

                        var endIcon = "<div style='width:20px;height:20px;background-color: red;' onclick='test()'><img width='20px' src='C:/Users/zh/Desktop/temp/18944502-ggg8.jpg'/></div>";
                        // 添加标记
                        var marker = new AMap.Marker({
                            //content: endIcon,
                            map: map,
                            position: new AMap.LngLat(lng, lat),   // 经纬度
                            offset: new AMap.Pixel(-10, -20)
                        });
                    } else {
                        console.log('定位失败！');
                    }
                });
            });
        }
    );
    map.setFitView();

    function test() {
    }

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
                }
            });
        });
    }

    function markLocation(address) {
        AMap.plugin('AMap.Geocoder', function() {
            var geocoder = new AMap.Geocoder();
            geocoder.getLocation(address, function(status, result) {
                if (status === 'complete' && result.info === 'OK') {

                    // 经纬度
                    var lng = result.geocodes[0].location.lng;
                    var lat = result.geocodes[0].location.lat;

                    var endIcon = "<div style='width:20px;height:20px;background-color: red;' onclick='test()'><img width='20px' src='C:/Users/zh/Desktop/temp/18944502-ggg8.jpg'/></div>";
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
</body>
</html>

