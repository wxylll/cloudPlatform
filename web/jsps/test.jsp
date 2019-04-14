<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/4/14
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
</head>
<body>
    <div id="chart" style="width: 100%; height: 500px; background-color: white"></div>
    <div id="chart1" style="width: 100%; height: 500px; background-color: white"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('chart'));
        var myChart1 = echarts.init(document.getElementById('chart1'));

        var data1 = [<c:forEach items="${outliers}" var="outlier">"${outlier.position}",</c:forEach>]
        var data2 = [<c:forEach items="${outliers}" var="outlier">"${outlier.outbreaks}",</c:forEach>]
        var data3 = [<c:forEach items="${categoryOutliers}" var="outlier">"${outlier.category}",</c:forEach>]
        var data4 = [<c:forEach items="${categoryOutliers}" var="outlier">{value:"${outlier.outbreaks}",name:"${outlier.category}"},</c:forEach>]

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '各地人流爆发次数'
            },
            tooltip: {},
            legend: {
                data:['爆发次数']
            },
            xAxis: {
                data: data1
            },
            yAxis: {},
            series: [{
                name: '爆发次数',
                type: 'bar',
                data: data2
            },
            {
                name: '1024',
                type: 'bar',
                data: data2
            }]
        };

        var option1 = {
            title : {
                text: '各分类人流爆发情况',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data:  data3
            },
            series : [
                {
                    name: '地点分类',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '60%'],
                    data: data4,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        myChart1.setOption(option1);
    </script>
</body>
</html>
