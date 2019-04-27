<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
</head>
<body>
    <div>
        <a href="<c:url value="/showOutliers.action"/> "><img width="3%" src="<c:url value="/image/箭头2.png"/> "/></a>
        <div id="chart" style="width: 100%; height: 500px; background-color: white"></div>
        <div>
            <table border="1">
                <tr><td>爆发地点</td><td>地点分类</td><td>开始时间</td><td>持续时间</td><td>最大人流</td><td>平均人流</td><td>视频</td><td>采用方案</td><td>安保人员数量</td></tr>
                <c:forEach items="${outliers}" var="outlier">
                    <tr><td>${outlier.position}</td><td>${outlier.positionCategory}</td><td>${outlier.startTime}</td><td>${outlier.duration}</td><td>${outlier.maxFlow}</td><td>${outlier.averageFlow}</td><td>${outlier.video}</td><td>${outlier.scheme}</td><td>${outlier.numberOfSecurity}</td></tr>
                </c:forEach>
            </table>
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
    </script>
</body>
</html>
