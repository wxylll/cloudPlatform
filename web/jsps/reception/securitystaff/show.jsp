<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/4/21
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<style>
    ._background {border-radius: 3px;background-color: darkgray;color: white;padding: .1% 2% 0% 2%;display: inline-block}
    * {font-family: 微软雅黑;}
    h3 {font-size: 1rem;font-weight: bold;}
    #add {float:left;margin-top: .5%}
    #add:hover {cursor:pointer;}
</style>
<body>
<div align="center" style="width: 100%;height: 100%">
    <div align="left" style="width: 98%;margin-bottom: 10px;padding-top: 10px"><h3>安保人员管理</h3></div>
    <div style="width: 98%;height: 100%">
        <table id="edge_table" class="layui-hide" lay-filter="test">
            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                    <img id="add" height="40px" onclick="add()" onmouseover="mouseOn(this)" onmouseout="mouseOver(this)" src="<c:url value="/icon/add.png"/>">
                </div>
            </script>
        </table>
    </div>
</div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
<script>
    //防止页面后退
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });

    //数据转换处理
    var data = [<c:forEach items="${staffs}" var="staff">
        {"ssid":"${staff.ssid}",
            "name":"${staff.name}",
            "contact":"${staff.contact}",
            "workPlace":"${staff.workPlace}",
            "workStatus":${staff.workStatus}},
        </c:forEach>]

    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#edge_table'
            ,data: data
            ,page: true //开启分页
            ,toolbar:'#toolbarDemo'
            ,cols: [[ //表头
                {field: 'ssid', title: 'ID', fixed: 'left'}
                ,{field: 'name', title: '安保人员姓名'}
                ,{field: 'contact', title: '联系方式'}
                ,{field: 'workPlace', title: '任职地点'}
                ,{field: 'workStatus', title: '工作状态'
                    ,templet: function(d){
                        if (!d.workStatus)
                            return '<span class="_background" style="background-color: green">空闲</span>'
                        else
                            return '<span class="_background" style="background-color: orange">任务中</span>'
                    }}
            ]]
        });

        table.on('row(test)', function(obj){
            var data = obj.data;
            layer.open({
                type: 2,
                area: ['400px', '400px'],
                fixed: false, //不固定
                maxmin: true,
                content: ['${pageContext.request.contextPath}/getStaff.action?ssid=' + data.ssid,'no']
            })

            //标注选中样式
            obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
        });

    });

    function add() {
        layer.open({
            type: 2,
            title: '添加',
            area: ['400px', '400px'],
            fixed: false, //不固定
            maxmin: true,
            content: ['${pageContext.request.contextPath}/jsps/reception/securitystaff/add.jsp','no']
        })
    }

    function mouseOn(ele) {
        ele.src = "${pageContext.request.contextPath}/icon/add_hover.png"
    }

    function mouseOver(ele) {
        ele.src = "${pageContext.request.contextPath}/icon/add.png"
    }

</script>
</body>
</html>
