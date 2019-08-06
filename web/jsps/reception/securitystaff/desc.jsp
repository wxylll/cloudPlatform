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
    <form id="form1" class="layui-form"  style="width: 80%;margin-left: -10%" method="post" lay-filter="test1">
        <input type="hidden" name="ssid" value="${staff.ssid}">
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="name"  class="layui-input" value="${staff.name}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-input-block">
                <input type="text" name="contact"  lay-verify="title"  class="layui-input" value="${staff.contact}">
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">任职地点</label>
            <div class="layui-input-block">
                <input type="text" name="workPlace" lay-verify="title"  class="layui-input" value="${staff.workPlace}">
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">工作状态</label>
            <div class="layui-input-block">
                <input type="text" name="workStatus" lay-verify="title" disabled="disabled" class="layui-input" value="<c:if test='${!staff.workStatus}'>空闲</c:if><c:if test='${staff.workStatus}'>任务中</c:if>">
            </div>
        </div>
    </form>
    <br/>
    <div>
        <button type="button" onclick="update('您确定要修改吗？')" class="layui-btn layui-btn-warm">修改</button>
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
                        url:'${pageContext.request.contextPath}/removeSecurityStaff.action?ssid=' + '${staff.ssid}',
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
            hasEmpty = false;
            var inputs = document.getElementsByTagName("input");
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].value == null || inputs[i].value.trim() == '')
                    hasEmpty = true
            }
            if (hasEmpty) {
                layer.msg("请先完善信息！");
            } else {
                layer.confirm(msg,
                    {btn:['确定','取消']},
                    function () {
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/updateSecurityStaff.action" ,
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
