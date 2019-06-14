<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
</style>
<body>
<div align="center" style="width: 100%;height: 100%">
    <div align="left" style="width: 98%;margin-bottom: 10px;padding-top: 10px"><h3>实时监控</h3></div>
    <div style="width: 98%;height: 100%">
        <table id="edge_table" class="layui-hide" lay-filter="test"></table>
    </div>
    <a id="getData"></a>
</div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>

<script>
    //防止页面后退
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });

    var temp = false;

    //数据转换处理
    var data = [<c:forEach items="${records}" var="record">
        {"eid":"${record.eid}",
            "position":"${record.position}",
            "category":"${record.category}",
            "startTime":"<fmt:formatDate value='${record.startTime}' pattern='yyyy年MM月dd日 HH:mm:ss'/>",
            "numberOfStaff":"${record.numberOfStaff}",
            "status":"${record.status}"},
        </c:forEach>]

    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#edge_table'
            ,data: data
            ,cols: [[ //表头
                {field: 'position', title: '爆发地点', fixed: 'left'}
                ,{field: 'category', title: '地点分类'}
                ,{field: 'startTime', title: '开始时间'}
                ,{field: 'numberOfStaff', title: '疏导人员数量'}
                ,{field: 'status', title: '当前状态'
                    ,templet: function(d){
                        if (d.status == 0)
                            return '<span class="_background" style="background-color:#c00">未处理</span>'
                        else if (d.status == 1)
                            return '<span class="_background" style="background-color:orange">疏导中</span>'
                        else if (d.status == 2)
                            return '<span class="_background" style="background-color:green">疏导成功</span>'
                        else if (d.status == 3)
                            return '<span class="_background">自动解除</span>'
                    }}
                ,{field: 'status', title: '操作'
                    ,templet: function(d){
                        if (d.status > 1)
                            return '<span class="_background" id="' + d.eid + '" onclick="remove(this)" style="background-color:#c00">删除</span>'
                        else
                            return '<span class="_background">删除</span>'
                    }}
            ]]
        });

        table.on('row(test)', function(obj){
            if (!temp) {
                var data = obj.data;
                var ele = document.getElementById("getData")
                ele.href = "${pageContext.request.contextPath}/showDetail.action?eid=" + data.eid;
                ele.click();

                //标注选中样式
                obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
            }
        });

    });

    function remove(ele) {
        temp = true;
        layer.confirm("确定要删除吗？",
            {btn:['确定','取消']},
            function () {
                $.ajax({
                    url:'${pageContext.request.contextPath}/removeRecord.action?eid=' + ele.id,
                    type:'get',
                    success:function(data){
                        if (data == 'succeed') {
                            layer.msg("删除成功！")
                            location.reload(true)
                        }else {
                            layer.msg("删除失败！")
                        }
                    }
                })
                temp = false;
            },
            function() {
                temp = false;
            }
        )
    }

</script>
</body>
</html>
