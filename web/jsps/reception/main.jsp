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
        * { /*禁止选中文字*/
            -webkit-touch-callout: none; /* iOS Safari */
            -webkit-user-select: none; /* Chrome/Safari/Opera */
            -khtml-user-select: none; /* Konqueror */
            -moz-user-select: none; /* Firefox */
            -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently*/
        }
        body, html,#container {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
        .show_div{width: 100%;height: 100%;position: absolute;z-index: 1000;visibility: hidden;}
        .show_div:hover{cursor: default}
        #left {height: 100%;width: 0px;background-color: cadetblue;float: left;transition: all .5s;-webkit-transition: all .5s;box-shadow: 0px 0px 20px rgba(0,0,0,0.5)}
        #center {position: absolute;left:17%;width: 66%;height: 98%;margin-top: -50%;background-color: white;transition: all .6s;-webkit-transition: all .6s;border-radius: 4px; box-shadow: 0px 0px 20px rgba(0,0,0,0.5);overflow: hidden}
        #centerIframe {width: 101.8%;height: 95%;padding-right:0px;border: none;border-radius: 0px 0px 4px 4px;transition: all .6s;-webkit-transition: all .6s;overflow-x: hidden;overflow-y: scroll;}
        #icon:hover{cursor: pointer}
        .head {
            position: absolute;
            z-index: 1002;
            width: 70px;
            height: 70px;
            margin-left: 95%;
            margin-top: 1%;
            border-radius: 50%;
            border: rgba(0,0,0,0) 2px solid;
            transition: all 1s;
            -webkit-transition: all 1s;
        }
        .head:hover {box-shadow: 0px 0px 20px rgba(0,0,0,1);cursor: pointer;border: darkgray 2px solid;}
        #right {
            position: absolute;
            z-index: 1001;
            margin-top: 10%;
            margin-left: 95%;
            height: 50%;
            width: 5%;
            border-radius: 5px 0px 0px 5px;
            background-color: rgba(255,255,255,0.9);
            float:right;
            transition: all .5s;
            -webkit-transition: all .5s;
            box-shadow: 0px 0px 20px rgba(0,0,0,0.5);
            overflow: hidden;
        }
        #right:hover {
            cursor: default;
        }
        .positionMsgBox {
            margin-top: 5px;
            margin-bottom: 10px;
            margin-left: -10%;
            vertical-align:middle;
            padding-left: 10%;
            padding-top: 5px;
            width: 120%;
            height: 27px;
            transition: all .5s;
            -webkit-transition: all .5s;
        }
        .positionMsgBox:hover {
            box-shadow: 0px 0px 20px rgba(0,0,0,0.5);
            cursor: pointer;
        }
        #headBox {
            width: 0px;
            height: 0px;
            overflow: hidden;
            background-color: rgba(255,255,255,0.2);
            transition: all .5s;
            -webkit-transition: all .5s;
        }
        .positionNameBox {
            margin-left: 10px;
            display: inline-block;
            width: 0px;
            height: 0px;
            overflow: hidden;
            float: left;
            transition: all .5s;
            -webkit-transition: all .5s;
        }
        .dataBox {
            display: block;
            float: left;
            width: 30px;
            color: green;
            margin-left: 10px;
        }
        .markBox {
            border-radius: 50%;
            width: 20px;
            height: 20px;
            background-color: green;
            display: inline-block;
            float: left;
            box-shadow: 0px 0px 5px rgba(0,0,0,0.5);
        }
        .logout {
            float: right;
            margin-right: 5%;
            border-radius: 50%;
            margin-top: -5px;
            padding-top: 5px;
            width: 30px;
            height: 25px;
            background-color: rgba(0,0,0,0.1);
            transition: all .3s;
            -webkit-transition: all .3s;
        }
        .logout:hover {
            cursor: pointer;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.5);
        }
    </style>
</head>
<body>
    <div id = "container" align="center">

        <div id="head" class="head" onclick="clickHead();">
            <img style="border-radius: 50%;width: 100%;height:100%;background-color: black" src="<c:url value="/image/timg1.jpg"/>"/>
        </div>
        <div id="right">
            <div id="headBox">
                <div id="userBox" style="float: right;margin-right: 0%;width: 65%;height: 89%;padding-top: 11%;display: none">
                    <i style="float: left;margin-left: 6%">Erxiao_Wang</i>
                    <div class="logout">
                        <img width="20" src="<c:url value="/image/logout.png"/>">
                    </div>
                </div>
            </div>
            <div id="msgBoxContainer" style="padding: 5px;overflow: scroll;height: 102%;width:105.5%;">
                <c:forEach items="${jurisdictions}" var="jurisdiction">
                    <a onclick="show()" href="<c:url value="/showDetail.action?position=${jurisdiction.monitoring}"/>" target="centerIframe">
                        <div id="${jurisdiction.eid}" name="0" title="${jurisdiction.monitoring}" align="left" class="positionMsgBox">
                            <div  class="markBox"></div>
                            <div class="positionNameBox">${jurisdiction.monitoring}</div>
                            <div class="dataBox">&nbsp;&nbsp;--</div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
        <div id="cen" class="show_div">
            <div id="left">
                <a><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">实时监控</div></a>
                <a href="<c:url value="/showOutliers.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">数据分析</div></a>
                <a href="<c:url value="/showTerminal.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">边缘端管理</div></a>
                <a href="<c:url value="/showOutliers.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">安保人员管理</div></a>
                <a href="<c:url value="/showOutliers.action"/>" target="centerIframe"><div style="width: 90%;height: 5%;background-color: aqua;margin-top: 10px;overflow: hidden">实时疏导情况</div></a>
            </div>
            <div id="center">
                <div style="width: 100%;height: 5%;background-color: aquamarine;border-radius: 4px 4px 0px 0px;">
                    <img id="icon" onclick="hide();" style="float: right;margin-top: 2px;margin-right: 2px" width="3%" src="<c:url value="/image/箭头2.png"/> ">
                </div>
                <iframe id="centerIframe" name="centerIframe"></iframe>
            </div>
        </div>
    </div>
<script type="text/javascript">
    var map,markers;
    var isShow = false;

    window.init = function() {
        createMap('container','${sessionScope.get('receptionUser').jurisdiction}');
    }

    setInterval("divSort();",5000); //每隔5秒根据人流对地点排序

    function clickHead() {
        if (isShow) {
            hide();
        } else {
            show();
        }
    }

    function divSort() {
        var aDiv = document.getElementsByClassName('positionMsgBox')
        var arr = [];
        var isSorted = false;
        for(var i=0;i<aDiv.length;i++)
        {
            arr.push(aDiv[i]);
        }
        arr.sort(function(a,b){
            var result;
            if (result = b.getAttribute('name') - a.getAttribute('name'))  {
                isSorted = true;
            }
            return result;
        });
        if (isSorted)  { //如果排序结果发生变化则更新
            for(var i=0;i<arr.length;i++)
            {
                document.getElementById('msgBoxContainer').appendChild(arr[i]); //将排好序的元素，重新塞到容器里面显示。
            }
        }
    }

    function hideHead() {
        var ele = document.getElementById('head');
        ele.style.marginLeft = ele.offsetLeft - 140;
        ele.style.width = '50px';
        ele.style.height = '50px';
        ele.style.webkitTransform = 'rotate(360deg)';
        ele.style.mozTransform = 'rotate(360deg)';
        ele.style.msTransform = 'rotate(360deg)';
        ele.style.oTransform = 'rotate(360deg)';
        ele.style.transform = 'rotate(360deg)';
    }

    function showHead() {
        var ele = document.getElementById('head');
        ele.style.marginLeft = ele.offsetLeft + 140;
        ele.style.width = '70px';
        ele.style.height = '70px';
        ele.style.webkitTransform = 'rotate(0deg)';
        ele.style.mozTransform = 'rotate(0deg)';
        ele.style.msTransform = 'rotate(0deg)';
        ele.style.oTransform = 'rotate(0deg)';
        ele.style.transform = 'rotate(0deg)';
    }

    function show() {
        if (!isShow) {
            hideHead();
            document.getElementById('cen').style.visibility = 'visible';
            document.getElementById('left').style.width = '16%';
            document.getElementById('right').style.width = '16%';
            document.getElementById('right').style.height = '100%';
            document.getElementById('right').style.marginTop = '0%';
            document.getElementById('right').style.marginLeft = '84%';
            document.getElementById('right').style.borderRadius = '0px';
            document.getElementById('headBox').style.width = '100%';
            document.getElementById('headBox').style.height = '12%';
            document.getElementById('headBox').style.marginBottom = '5%';
            document.getElementById('headBox').style.boxShadow = '0px 2px 10px 0px rgba(0,0,0,0.1)';
            document.getElementById('msgBoxContainer').style.height = '87%';
            document.getElementById('userBox').style.display = 'block';
            document.getElementById('center').style.marginTop = '.5%';
            var eles = document.getElementsByClassName('positionNameBox');
            for (var i = 0; i < eles.length; i++) {
                eles[i].style.width = '50%';
                eles[i].style.height = '20px';
            }
            var eles2 = document.getElementsByClassName('positionMsgBox');
            for (var i = 0; i < eles2.length; i++) {
                eles2[i].style.height = '37px';
                eles2[i].style.paddingTop = '13px';
            }
            isShow = true;
        }
    }

    function markerSubmit(ele) {
        //自适应标记点
        map.setFitView();
        ele.firstElementChild.submit();
    }

    function hide() {
        if (isShow) {
            var eles = document.getElementsByClassName('positionNameBox');
            for (var i = 0; i < eles.length; i++) {
                eles[i].style.width = '0px';
                eles[i].style.height = '0px';
            }
            var eles2 = document.getElementsByClassName('positionMsgBox');
            for (var i = 0; i < eles2.length; i++) {
                eles2[i].style.height = '27px';
                eles2[i].style.paddingTop = '5px';
            }
            document.getElementById('left').style.width = '0%';
            document.getElementById('right').style.width = '5%';
            document.getElementById('right').style.height = '50%';
            document.getElementById('right').style.marginTop = '10%';
            document.getElementById('right').style.marginLeft = '95%';
            document.getElementById('right').style.borderRadius = '5px 0px 0px 5px';
            document.getElementById('userBox').style.display = 'none';
            document.getElementById('headBox').style.width = '0%';
            document.getElementById('headBox').style.height = '0%';
            document.getElementById('headBox').style.marginBottom = '0%';
            document.getElementById('headBox').style.boxShadow = 'none';
            document.getElementById('msgBoxContainer').style.height = '102%';
            document.getElementById('center').style.marginTop = '-50%';
            document.getElementById('cen').style.visibility = 'hidden';
            showHead();
            isShow = false;
        }
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
                        markLocation('${sessionScope.get('receptionUser').jurisdiction}' + ' ' + '${jurisdiction.monitoring}','${jurisdiction.monitoring}','${jurisdiction.eid}');
                    </c:forEach>
                }
            });
        });
    }

    //标记地点
    function markLocation(address,position,eid) {
        AMap.plugin('AMap.Geocoder', function() {
            var geocoder = new AMap.Geocoder();
            geocoder.getLocation(address, function(status, result) {
                if (status === 'complete' && result.info === 'OK') {

                    // 经纬度
                    var lng = result.geocodes[0].location.lng;
                    var lat = result.geocodes[0].location.lat;

                    var endIcon = "<div id='" + eid + "' style='width:19px;height:31px;background-image:url(${pageContext.request.contextPath}/image/mark_b.png);' onclick='show();markerSubmit(this);'>"
                            + "<form method='post' target='centerIframe' action='${pageContext.request.contextPath}/showDetail.action?position=" + encodeURI(position) + "'></form>"
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

</script>
<script src="https://webapi.amap.com/maps?v=1.4.13&key=2778de5c45eaa7653553c3d919b956c2&callback=init"></script>
</body>
</html>

