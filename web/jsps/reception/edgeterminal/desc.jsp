<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/6/9
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<body style="padding-top: 5%">
<div align="center" style="width:100%">
    <form id="form1" class="layui-form" action="<c:url value="/updateEdgeTerminal.action"/>" style="width: 80%;margin-left: -10%" method="post" lay-filter="test1">
        <input type="hidden" name="uid" value="${sessionScope.receptionUser.uid}">
        <input type="hidden" name="eid" value="${edgeTerminal.eid}">
        <div class="layui-form-item">
            <label class="layui-form-label">设备ID</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title"  class="layui-input" value="${edgeTerminal.eid}" disabled="disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">监管地点</label>
            <div class="layui-input-block">
                <input type="text" name="monitoring"  lay-verify="title"  class="layui-input" value="${edgeTerminal.monitoring}" disabled="disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">地点分类</label>
            <div class="layui-input-block">
                <select id="category" lay-verify="required" name="pcid" lay-filter="aihao" style="text-align: left">
                    <option value="" selected="selected"></option>
                    <c:forEach items="${categorys}" var="category">
                        <option value="${category.pcid}" <c:if test="${category.pcid eq edgeTerminal.pcid}">selected="selected"</c:if>>${category.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">人流阈值</label>
            <div class="layui-input-block">
                <input id="threshold" type="text" name="threshold" lay-verify="title"  class="layui-input" value="${edgeTerminal.threshold}">
            </div>
        </div>
    </form>
    <br/>
    <div>
        <button type="button" onclick="update('是否接管此设备？')" class="layui-btn <c:if test="${edgeTerminal.status != 0}">layui-btn-disabled</c:if>">接管</button>
        <button type="button" onclick="update('您确定要修改吗？')" class="layui-btn layui-btn-warm <c:if test="${edgeTerminal.status == 0}">layui-btn-disabled</c:if>">修改</button>
        <button type="button" onclick="remove()" class="layui-btn layui-btn-danger">删除</button>
        <button type="button" onclick="quit()" class="layui-btn layui-btn-primary">取消</button>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    layui.use('form', function(){
        var form = layui.form;
        form.render(null, 'test1');
    });
    function remove() {
        layui.use('layer', function() {
            var $ = layui.jquery, layer = layui.layer;
            layer.confirm('您确定要删除吗？',
                {btn:['确定','取消']},
                function () {
                    $.ajax({
                        url:'${pageContext.request.contextPath}/removeEdgeTerminal.action?eid=' + '${edgeTerminal.eid}',
                        type:'get',
                        success:function(data){
                            if (data == 'succeed') {
                                layer.msg("删除成功！")
                                parent.location.reload(true)
                                quit()
                            }else {
                                layer.msg("删除失败！")
                            }
                        }
                    })
                }
            )
        })
    }

    function update(msg) {
        layui.use('layer', function() {
            var $ = layui.jquery, layer = layui.layer;
            if (document.getElementById('category').selectedIndex == 0) {
                layer.msg("请先完善信息！")
            } else {
                layer.confirm(msg,
                    {btn:['确定','取消']},
                    function () {
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/updateEdgeTerminal.action" ,
                            data: $('#form1').serialize(),
                            success: function (result) {
                                if (result == 'succeed') {
                                    layer.msg("修改成功！")
                                    parent.location.reload(true)
                                    quit()
                                }else {
                                    layer.msg("修改失败！")
                                }
                            }
                        });
                    }
                )
            }
        })
    }

    function quit() {
        var index = parent.layer.getFrameIndex(window.name)
        parent.layer.close(index)
    }
</script>
</body>
</html>
