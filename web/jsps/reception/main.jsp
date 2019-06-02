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
    <link href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
        * { /*禁止选中文字*/
            -webkit-touch-callout: none; /* iOS Safari */
            -webkit-user-select: none; /* Chrome/Safari/Opera */
            -khtml-user-select: none; /* Konqueror */
            -moz-user-select: none; /* Firefox */
            -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently*/
        }
        a {
            text-decoration: none;
            color:black;
        }
        body, html,#container {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
        .show_div{width: 100%;height: 100%;position: absolute;z-index: 1000;visibility: hidden;}
        .show_div:hover{cursor: default}
        #left {height: 100%;width: 16%;margin-left: -16%;background-color: #222d32;float: left;transition: all .5s;-webkit-transition: all .5s;box-shadow: 0px 0px 20px rgba(0,0,0,0.5);overflow: hidden}
        #left ul{
            list-style: none;
            width: 100%;
            padding: 0px;
        }
        .navigation{
            width: 95%;
            font-size: 0;
            height: 40px;
            display: block;
            padding-left: 5%;
            text-align: left;
            border-left: 4px solid rgba(0,0,0,0);
        }
        .navigation:hover {
            border-left: 4px solid #3c8dbc;
            cursor: pointer;
            background-color: rgba(0,0,0,0.3);
        }
        .navigation_clicked{
            width: 95%;
            font-size: 0;
            height: 40px;
            display: block;
            padding-left: 5%;
            text-align: left;
            border-left: 4px solid #3c8dbc;
            background-color: rgba(0,0,0,0.3);
        }
        .navigation_clicked:hover {
            cursor: pointer;
        }
        .navigation_clicked_div {
            color: #ffffff;
        }
        #left a:hover .textDiv{
            color: #ffffff;
        }
        #left img{
            top: 4px;
            position: relative;
            display: inline-block;
        }
        .textDiv{
            height: 40px;
            display: inline-block;
            font-size: 13px;
            line-height: 40px;
            color: #cdcdcd;
        }
        .textDiv_clicked {
            height: 40px;
            display: inline-block;
            font-size: 13px;
            line-height: 40px;
            color: #ffffff;
        }
        .innerRightDiv {
            float: right;
            margin-right: 30px;
            font-family: 黑体;
        }
        #center {position: absolute;left:17%;width: 66%;height: 98%;margin-top: -50%;background-color: #333;transition: all .6s;-webkit-transition: all .6s;border-radius: 4px; box-shadow: 0px 0px 20px rgba(0,0,0,0.5);overflow: hidden}
        #centerIframe {width: 101.8%;height: 95%;padding-right:0px;border: none;border-radius: 0px 0px 4px 4px;transition: all .6s;-webkit-transition: all .6s;overflow-x: hidden;overflow-y: scroll;}
        .head {
            position: absolute;
            z-index: 1002;
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
            background-color: rgba(255,255,255,1);
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
            vertical-align:middle;
            padding-left: 10%;
            padding-top: 10px;
            width: 100%;
            height: 30px;
            transition: all 1s;
            -webkit-transition: all 1s;
        }
        .positionMsgBox:hover {
            cursor: pointer;
            background-color: rgba(0,0,0,.1);
        }
        #headBox {
            width: 0px;
            height: 0px;
            overflow: hidden;
            background-color: #3c8dbc;
            color: white;
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
        #msgBoxContainer::-webkit-scrollbar {
            display: none;
        }
        #img_button:hover {
            cursor: pointer;
        }
        .left_user {
            padding-left: 5%;
            padding-top: 2%;
            height: 8%;
            width: 95%;
            color: white;
            font-size: 12px;
        }
        .left_user img {
            float: left;
        }
        .left_user span {
            display: block;
            margin-bottom: 5px;
            text-align: left;
        }
        .left_user .inner {
            height: 100%;
            display: block;
            padding-left: 6%;
            padding-top: 5%;
            float: left;
        }
        span div {
            width: 12px;
            height: 12px;
            margin-top: 2px;
            border-radius: 50%;
            position: absolute;
            background-color: green;
        }
        #logout {
            height: 100%;
            width: 40%;
            float: right;
            transition: .3s;
        }
        #logout:hover {
            background-color: rgba(0,0,0,.1);
            cursor: pointer;
        }
        #logout img {
            margin-top: 25%;
        }
    </style>
</head>
<body>
    <div id = "container" align="center">

        <div id="head" class="head" onclick="clickHead();">
            <img id="head_img" height="9%" style="border-radius: 50%;background-color: black;transition: all 1s;" src="<c:url value="/image/head.jpg"/>"/>
        </div>
        <div id="right">
            <div id="headBox">
                <div id="userBox" style="float: right;margin-right: 0%;width: 65%;height: 100%;display: none;">
                    <span style="float: left;margin-left: 6%;font-size:12px;margin-top: 11%">Erxiao_Wang</span>
                    <div id="logout">
                        <img width="30%" src="<c:url value="/icon/logout.png"/>">
                    </div>
                </div>
            </div>
            <div id="msgBoxContainer" style="overflow: scroll;height: 100%;width:100%;font-size: 16px;">
                <c:forEach items="${jurisdictions}" var="jurisdiction">
                    <a onclick="show();firstLinkClicked();" href="<c:url value="/showDetail.action?position=${jurisdiction.monitoring}"/>" target="centerIframe">
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
                <div style="width: 100%;height: 8%;background-color: #3c8dbc">
                    <img height="100%" width="45%" src="${pageContext.request.contextPath}/image/logo.png">
                </div>
                <div class="left_user">
                    <img height="90%" style="border-radius: 50%" src="<c:url value="/image/head.jpg"/>">
                    <div class="inner">
                        <span>Erxiao_Wang</span>
                        <span><div></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在线</span>
                    </div>
                </div>
                <ul>
                    <li>
                        <a id="firstLink" class="navigation" onclick="clickBar(this)" onmouseover="changeIcon(this,'monitoring_hover.png')" onmouseout="changeIcon(this,'monitoring.png')" href="<c:url value="/showOutliers.action"/>" target="centerIframe">
                            <img src="<c:url value="/icon/monitoring.png"/>" width="20" height="20">
                            <div class="textDiv">&nbsp;&nbsp;&nbsp;实时监控</div>
                            <div class="innerRightDiv textDiv">&gt;</div>
                        </a>
                    </li>
                    <li>
                        <a class="navigation" onclick="clickBar(this)" onmouseover="changeIcon(this,'table_hover.png')" onmouseout="changeIcon(this,'table.png')" href="<c:url value="/showOutliers.action"/>" target="centerIframe">
                            <img src="<c:url value="/icon/table.png"/>" width="20" height="20">
                            <div class="textDiv">&nbsp;&nbsp;&nbsp;数据分析</div>
                            <div class="innerRightDiv textDiv">&gt;</div>
                        </a>
                    </li>
                    <li>
                        <a class="navigation" onclick="clickBar(this)" onmouseover="changeIcon(this,'device_hover.png')" onmouseout="changeIcon(this,'device.png')" href="<c:url value="/showTerminal.action"/>" target="centerIframe">
                            <img src="<c:url value="/icon/device.png"/>" width="20" height="20">
                            <div class="textDiv">&nbsp;&nbsp;&nbsp;设备管理</div>
                            <div class="innerRightDiv textDiv">&gt;</div>
                        </a>
                    </li>
                    <li>
                        <a class="navigation" onclick="clickBar(this)" onmouseover="changeIcon(this,'staff_hover.png')" onmouseout="changeIcon(this,'staff.png')" href="<c:url value="/showOutliers.action"/>" target="centerIframe">
                            <img src="<c:url value="/icon/staff.png"/>" width="20" height="20">
                            <div class="textDiv">&nbsp;&nbsp;&nbsp;安保人员</div>
                            <div class="innerRightDiv textDiv">&gt;</div>
                        </a>
                    </li>
                </ul>
            </div>
            <div id="center">
                <div style="width: 100%;height: 5%;background-color: #3c8dbc;border-radius: 4px 4px 0px 0px;">
                    <img id="img_button" onmouseover="changeSrc(this,true)" onmouseout="changeSrc(this,false)" src="<c:url value="/icon/suo_fang.png"/>" width="2%" style="float: right;margin-right: 0.5%;margin-top: 0.5%" onclick="hide();"></img>
                </div>
                <iframe id="centerIframe" name="centerIframe"></iframe>
            </div>
        </div>
    </div>
<script type="text/javascript">
    var map;
    var isShow = false;

    window.init = function() {
        createMap('container','${sessionScope.get('receptionUser').jurisdiction}');
    }

    window.onload = function() {
        if (!!window.ActiveXObject || "ActiveXObject" in window) { //如果是IE，对URL中的中文进行转码
            var links = document.getElementById('msgBoxContainer').getElementsByTagName('a');
            for(var i=0;i<links.length;i++)
            {
                links[i].href = encodeURI(links[i].href);
            }
        }
    }

    setInterval("divSort();",5000); //每隔5秒根据人流对地点排序

    function clickHead() {
        if (isShow) {
            hide();
        } else {
            show();
        }
    }

    function changeSrc(ele,isOver) {
        if (isOver)
            ele.src = ele.src.replace('.png','_hover.png');
        else
            ele.src = ele.src.replace('_hover','');
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
        var img = document.getElementById('head_img');
        ele.style.marginLeft = '86%';
        ele.style.marginTop = '.5%';
        img.style.height = '5%';
        ele.style.webkitTransform = 'rotate(360deg)';
        ele.style.mozTransform = 'rotate(360deg)';
        ele.style.msTransform = 'rotate(360deg)';
        ele.style.oTransform = 'rotate(360deg)';
        ele.style.transform = 'rotate(360deg)';
    }

    function showHead() {
        var ele = document.getElementById('head');
        var img = document.getElementById('head_img');
        ele.style.marginLeft = '95%';
        ele.style.marginTop = '1%';
        img.style.height = '9%';
        ele.style.webkitTransform = 'rotate(0deg)';
        ele.style.mozTransform = 'rotate(0deg)';
        ele.style.msTransform = 'rotate(0deg)';
        ele.style.oTransform = 'rotate(0deg)';
        ele.style.transform = 'rotate(0deg)';
    }

    function show() {
        if (!isShow) {
            document.getElementById('cen').style.visibility = 'visible';
            document.getElementById('left').style.marginLeft = '0%';
            document.getElementById('right').style.width = '16%';
            document.getElementById('right').style.height = '100%';
            document.getElementById('right').style.marginTop = '0%';
            document.getElementById('right').style.marginLeft = '84%';
            document.getElementById('right').style.borderRadius = '0px';
            document.getElementById('headBox').style.width = '100%';
            document.getElementById('headBox').style.height = '8%';
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
                eles2[i].style.paddingLeft = '12%';
            }
            hideHead();
            isShow = true;
        }
    }

    function firstLinkClicked() {
        clickBar(document.getElementById('firstLink'));
    }

    function changeIcon(ele,icon) {
        if (ele.getAttribute('class') == 'navigation')
            ele.children[0].src = '${pageContext.request.contextPath}/icon/' + icon;
    }

    function clickBar(ele) {
        var eles = document.getElementById('left').getElementsByTagName('a');
        for (var i = 0; i < eles.length; i++) {
            eles[i].setAttribute('class','navigation');
            eles[i].children[0].src = eles[i].children[0].src.replace('_hover','');
            var divs = eles[i].getElementsByTagName('div');
            for (var j = 0; j < 2; j++) {
                divs[j].classList.remove('textDiv_clicked');
                divs[j].classList.add('textDiv');
            }
        }
        ele.setAttribute('class','navigation_clicked');
        ele.children[0].src = ele.children[0].src.replace('.png','_hover.png');
        var divs = ele.getElementsByTagName('div');
        for (var j = 0; j < 2; j++) {
            divs[j].classList.remove('textDiv');
            divs[j].classList.add('textDiv_clicked');
        }
    }

    function getOffsetLeft(obj){
        var tmp = obj.offsetLeft;
        var val = obj.offsetParent;
        while(val != null){
            tmp += val.offsetLeft;
            val = val.offsetParent;
        }
        return tmp;
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
                eles2[i].style.paddingLeft = '10%';
            }
            document.getElementById('left').style.marginLeft = '-16%';
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
            document.getElementById('msgBoxContainer').style.height = '100%';
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

                    var endIcon = "<div id='" + eid + "' style='width:19px;height:31px;background-image:url(${pageContext.request.contextPath}/image/mark_b.png);' onclick='show();markerSubmit(this);firstLinkClicked();'>"
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

