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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<style>
    ._background {
        border-radius: 3px;background-color: darkgray;color: white;padding: .1% 2% 0% 2%;display: inline-block
    }
    * {
        font-family: 微软雅黑;
    }
    h3 {
        font-size: 1rem;
        font-weight: bold;
    }
</style>
<body>
    <div align="center" style="width: 100%;height: 100%">
        <div align="left" style="width: 98%;margin-bottom: 10px;padding-top: 10px"><h3>设备管理</h3></div>
        <div style="width: 98%;height: 100%">
            <table id="edge_table" class="layui-hide" lay-filter="test"></table>
        </div>
    </div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>

<script>

    //数据转换处理
    var data = [<c:forEach items="${edgeTerminals}" var="edgeTerminal">
        {"eid":"${edgeTerminal.eid}",
            "monitoring":"${fn:trim(fn:replace(edgeTerminal.monitoring, sessionScope.receptionUser.jurisdiction, ''))}",/*截取掉地址中用户管辖范围部分*/
            "positionCategory":"${edgeTerminal.positionCategory}",
            "threshold":"${edgeTerminal.threshold}",
            "status":"${edgeTerminal.status}",
            "isOnline":"${edgeTerminal.online}"},
        </c:forEach>]

    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#edge_table'
            ,data: data
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'eid', title: 'ID', fixed: 'left'}
                ,{field: 'monitoring', title: '监管地点'}
                ,{field: 'positionCategory', title: '地点分类'
                    ,templet: function(d){
                        if (d.positionCategory == null || d.positionCategory == "")
                            return '<span class="_background">未设置</span>'
                        else
                            return d.positionCategory
                    }}
                ,{field: 'threshold', title: '人流阈值'}
                ,{field: 'status', title: '监管状态'
                    ,templet: function(d){
                        if (d.status == 1)
                            return '<span class="_background" style="background-color:green">已监管</span>'
                        else
                            return '<span class="_background" style="#c00">未监管</span>'
                    }}
                ,{field: 'isOnline', title: '连接状态'
                    ,templet: function(d){
                        if (d.isOnline == true)
                            return '<span class="_background" style="background-color:green">正常</span>'
                        else
                            return '<span class="_background" style="background-color:#c00">断开</span>'
                    }}
            ]]
        });

        table.on('row(test)', function(obj){
            var data = obj.data;

            layer.alert(JSON.stringify(data), {
                title: '当前行数据：'
            });

            //标注选中样式
            obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
        });

    });

</script>
</body>
</html>
