<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <style type="text/css">
        * {-webkit-touch-callout: none;-webkit-user-select: none;-khtml-user-select: none;-moz-user-select: none;-ms-user-select: none;user-select: none;}
        a {text-decoration: none;color:black;}
        body, html,#container {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
        .show_div{width: 100%;height: 100%;position: absolute;z-index: 1000;}
        .show_div:hover{cursor: default}
        #left {height: 100%;width: 16%;background-color: #222d32;float: left;overflow: hidden}
        #left ul{list-style: none;width: 100%;padding: 0px;}
        .navigation{width: 95%;font-size: 0;height: 40px;display: block;padding-left: 5%;text-align: left;border-left: 4px solid rgba(0,0,0,0);}
        .navigation:hover {border-left: 4px solid #3c8dbc;cursor: pointer;background-color: rgba(0,0,0,0.3);}
        .navigation_clicked{width: 95%;font-size: 0;height: 40px;display: block;padding-left: 5%;text-align: left;border-left: 4px solid #3c8dbc;background-color: rgba(0,0,0,0.3);}
        .navigation_clicked:hover {cursor: pointer;}
        .navigation_clicked_div {color: #ffffff;}
        #left a:hover .textDiv{color: #ffffff;}
        #left img{top: 4px;position: relative;display: inline-block;}
        .textDiv{height: 40px;display: inline-block;font-size: 13px;line-height: 40px;color: #cdcdcd;}
        .textDiv_clicked {height: 40px;display: inline-block;font-size: 13px;line-height: 40px;color: #ffffff;}
        .innerRightDiv {float: right;margin-right: 30px;font-family: 黑体;}
        #center {position: absolute;left:16%;width: 84%;height: 100%;background-color: rgb(240,240,240);overflow: hidden}
        #centerIframe {width: 101.8%;height: 95%;padding-right:0px;box-shadow: 0px 0px 10px rgba(0,0,0,.5) inset;border: none;border-radius: 0px 0px 4px 4px;overflow: hidden;overflow-y: scroll;}
        .head {position: absolute;z-index: 1002;margin-left: 95%;margin-top: 1%;border-radius: 50%;border: rgba(0,0,0,0) 2px solid;}
        #right {position: absolute;z-index: 1001;margin-top: 10%;margin-left: 95%;height: 50%;width: 5%;border-radius: 5px 0px 0px 5px;background-color: white;float:right;box-shadow: 0px 0px 20px rgba(0,0,0,.5);overflow: hidden;}
        #right:hover {cursor: default;}
        .positionMsgBox {vertical-align:middle;padding-left: 10%;padding-top: 10px;width: 100%;height: 30px;transition: all 1s;-webkit-transition: all 1s;}
        .positionMsgBox:hover {cursor: pointer;background-color: rgba(255,255,255,.1);}
        #headBox {width: 0px;height: 0px;overflow: hidden;background-color: #3c8dbc;color: white;}
        .positionNameBox {margin-left: 10px;display: inline-block;width: 0px;height: 0px;overflow: hidden;color: white;float: left;}
        .dataBox {display: block;float: left;width: 30px;color: green;margin-left: 10px;}
        .markBox {border-radius: 50%;width: 20px;height: 20px;background-color: green;display: inline-block;float: left;box-shadow: 0px 0px 5px rgba(0,0,0,0.5);}
        #msgBoxContainer::-webkit-scrollbar {display: none;}
        #img_button:hover {cursor: pointer;}
        .left_user {padding-left: 5%;padding-top: 2%;height: 8%;width: 95%;color: white;font-size: 12px;}
        .left_user img {float: left;}
        .left_user span {display: block;margin-bottom: 5px;text-align: left;}
        .left_user .inner {height: 100%;display: block;padding-left: 6%;padding-top: 5%;float: left;}
        span div {width: 12px;height: 12px;margin-top: 2px;border-radius: 50%;position: absolute;background-color: green;}
        #logout {height: 100%;width: 40%;float: right;transition: .3s;}
        #logout:hover {background-color: rgba(0,0,0,.1);cursor: pointer;}
        #logout img {margin-top: 25%;}
        body .layui-msg-1 {background-color: rgba(0,0,0,0); boder:none}
        body .layui-msg-1 .layui-layer-content{background-color: #c00; color:white; border-radius:10px; border:none;}
        body .layui-msg-2 {background-color: rgba(0,0,0,0); boder:none}
        body .layui-msg-2 .layui-layer-content{background-color: rgba(46,139,87,.8); color:white; border-radius:10px; border:none;}
        body .layui-msg-3 {background-color: rgba(0,0,0,0); boder:none}
        body .layui-msg-3 .layui-layer-content{background-color: rgba(222,184,135,.8); color:white; border-radius:10px; border:none;}
    </style>
</head>
<body>
<div id = "container" align="center">
    <div id="cen" class="show_div">
        <div id="left">
            <div style="width: 100%;height: 8%;background-color: #3c8dbc;box-shadow: 0px 0px 40px rgba(0,0,0,.1) inset">
                <img height="100%" width="45%" src="${pageContext.request.contextPath}/image/logo.png">
            </div>
            <div class="left_user">
                <img height="90%" style="border-radius: 50%" src="<c:url value="/image/head.jpg"/>">
                <div class="inner">
                    <span>Administrator</span>
                    <span><div></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在线</span>
                </div>
            </div>
            <ul>
                <li>
                    <a id="firstLink" class="navigation" onclick="clickBar(this)" onmouseover="changeIcon(this,'staff_hover.png')" onmouseout="changeIcon(this,'staff.png')" href="<c:url value="/showReceptionUsers.action"/>" target="centerIframe">
                        <img src="<c:url value="/icon/staff.png"/>" width="20" height="20">
                        <div class="textDiv">&nbsp;&nbsp;&nbsp;前台用户管理</div>
                        <div class="innerRightDiv textDiv">&gt;</div>
                    </a>
                </li>
                <li>
                    <a class="navigation" onclick="clickBar(this)" onmouseover="changeIcon(this,'table_hover.png')" onmouseout="changeIcon(this,'table.png')" href="<c:url value="/showPositionCategorys.action"/>" target="centerIframe">
                        <img src="<c:url value="/icon/table.png"/>" width="20" height="20">
                        <div class="textDiv">&nbsp;&nbsp;&nbsp;分类管理</div>
                        <div class="innerRightDiv textDiv">&gt;</div>
                    </a>
                </li>
            </ul>
        </div>
        <div id="center">
            <div style="width: 100%;height: 8%;background-color: #3c8dbc;"></div>
            <iframe id="centerIframe" name="centerIframe"></iframe>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/javascript">
    var isShow = false; //记录当前页面状态

    //头像被点击
    function clickHead() {
        if (isShow) {
            hide();
        } else {
            show();
        }
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

    //对爆发地点按人流排序
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

    //隐藏操作页面时，头像变化
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

    //显示操作页面时头像变化
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

    //显示操作页面
    function show() {
        if (!isShow) {
            document.getElementById('cen').style.visibility = 'visible';
            document.getElementById('left').style.marginLeft = '0%';
            document.getElementById('right').style.width = '16%';
            document.getElementById('right').style.height = '100%';
            document.getElementById('right').style.marginTop = '0%';
            document.getElementById('right').style.marginLeft = '84%';
            document.getElementById('right').style.borderRadius = '0px';
            document.getElementById('right').style.backgroundColor = '#222d32';
            document.getElementById('right').style.boxShadow = 'none';
            document.getElementById('headBox').style.width = '100%';
            document.getElementById('headBox').style.height = '8%';
            document.getElementById('headBox').style.marginBottom = '5%';
            document.getElementById('headBox').style.boxShadow = '0px 2px 10px 0px rgba(0,0,0,0.1)';
            document.getElementById('msgBoxContainer').style.height = '87%';
            document.getElementById('userBox').style.display = 'block';
            document.getElementById('center').style.marginTop = '0%';
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

    //隐藏操作界面
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
            document.getElementById('right').style.boxShadow = '0px 0px 20px rgba(0,0,0,.5)';
            document.getElementById('right').style.backgroundColor = 'white';
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

    //使左侧第一个导航标签处于选中状态
    function firstLinkClicked() {
        clickBar(document.getElementById('firstLink'));
    }

    //鼠标悬停改变图标
    function changeIcon(ele,icon) {
        if (ele.getAttribute('class') == 'navigation')
            ele.children[0].src = '${pageContext.request.contextPath}/icon/' + icon;
    }

    //左侧导航标签被点击
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
</script>
</body>
</html>

