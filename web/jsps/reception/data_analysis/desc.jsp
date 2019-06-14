<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/4/15
  Time: 19:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<body>
    <div>
        <div id="chart" style="width: 100%; height: 500px;"></div>
        <div>
            <div algin="center" style="width: 100%;height: 100%">
                <table id="outlier_table" class="layui-hide" lay-filter="test"></table>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('chart'));

        var data1 = [<c:forEach items="${outliers}" var="outlier">"${outlier.startTime}",</c:forEach>]
        var data2 = [<c:forEach items="${outliers}" var="outlier">"${outlier.maxFlow}",</c:forEach>]
        var data3 = [<c:forEach items="${outliers}" var="outlier">"${outlier.averageFlow}",</c:forEach>]
        var data4 = [<c:forEach items="${outliers}" var="outlier">"${outlier.duration}",</c:forEach>]
        var data5 = [<c:forEach items="${outliers}" var="outlier">"${outlier.numberOfSecurity}",</c:forEach>]

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '${position}'+ '人流异常数据'
            },
            tooltip: {},
            legend: {
                data:['最大人流','平均人流','安保人员数量']
            },
            dataZoom: [{
                type: 'inside'
            }, {
                type: 'slider'
            }],
            xAxis: {
                data: data1
            },
            yAxis: {},
            series: [{
                name: '最大人流',
                type: 'bar',
                data: data2
            },
            {
                name: '平均人流',
                type: 'bar',
                data: data3
            },
            {
                name: '安保人员数量',
                type: 'bar',
                data: data5
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);

        //数据转换处理
        var data5 = [<c:forEach items="${outliers}" var="outlier">
            {"position":"${outlier.position}",
                "positionCategory":"${outlier.positionCategory}",
                "startTime":"<fmt:formatDate value='${outlier.startTime}' pattern='yyyy年MM月dd日 HH:mm:ss'/>",
                "duration":"<fmt:formatNumber maxFractionDigits='0' minIntegerDigits='2' value='${outlier.duration / 1000 / 60 / 60 % 60}'/>:<fmt:formatNumber maxFractionDigits='0' minIntegerDigits='2' value='${outlier.duration / 1000 / 60 % 60}'/>:<fmt:formatNumber maxFractionDigits='0' minIntegerDigits='2' value='${outlier.duration / 1000 % 60}'/>",
                "maxFlow":"${outlier.maxFlow}",
                "averageFlow":"${outlier.averageFlow}",
                "video":"${outlier.video}",
                "numberOfSecurity":"${outlier.numberOfSecurity}"},
            </c:forEach>]

        layui.use('table', function(){
            var table = layui.table;

            //第一个实例
            table.render({
                elem: '#outlier_table'
                ,data: data5
                ,page: true //开启分页
                ,limit: 20
                ,cols: [[ //表头
                    {field: 'position', title: '爆发地点', fixed: 'left'}
                    ,{field: 'positionCategory', title: '地点分类'}
                    ,{field: 'startTime', title: '开始时间', sort:true}
                    ,{field: 'duration', title: '持续时间', sort:true}
                    ,{field: 'maxFlow', title: '最大人流', sort:true}
                    ,{field: 'averageFlow', title: '平均人流', sort:true}
                    ,{field: 'video', title: '视频'
                        ,templet: function(d){
                            return '<img src="${pageContext.request.contextPath}/icon/video.png" height="98%"></img>'
                        }}
                    ,{field: 'numberOfSecurity', title: '安保人员数量', sort:true}
                ]]
            });

            table.on('row(test)', function(obj){
                var data = obj.data;

                layer.open({
                    type: 2,
                    title:false,
                    offset:'100px',
                    area: ['630px', '360px'],
                    shade:0.8,
                    closeBtn:0,
                    shadeClose:true,
                    content: "${pageContext.request.contextPath}/" + data.video
                })

                //标注选中样式
                obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
            });
        })
    </script>
</body>
</html>
