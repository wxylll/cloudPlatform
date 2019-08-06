<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <style>
        h3 {font-size: 1rem;display: inline-block;font-weight: bold;}
        a {text-decoration:none;out-line: none;color: black;}
        * {font-family: 微软雅黑;}
        a span {font-size: medium;font-family: 黑体;font-weight: bold;opacity: .5;}
        a:hover {text-decoration:none;out-line: none;color: black;}
        #div1 div {
            float: left;
        }
    </style>
</head>
<body>
<div style="width: 98%;margin-bottom: 10px;padding-top: 10px;padding-left: 10px;"><a href=""><h3>数据分析</h3>&nbsp;<span>&gt;</span>&nbsp;</a><h3>各地人流爆发次数</h3></div>
<div id="div1" style="width: 100%;height: 500px;display: block;">
    <div style="width: 100%;height: 500px">
        <div id="chart" style="width: 100%; height: 100%;"></div>
    </div>
    <div style="width: 20%;height: 200px;border-radius: 5px;background-color: white;position: fixed;margin-left: 78%;z-index: 2000;">
        <div id="chart1" style="width: 100%; height: 100%;"></div>
    </div>
</div>
<div algin="center" style="width: 100%;height: 100%">
    <table id="outlier_table" class="layui-hide" lay-filter="test"></table>
</div>
<form id="from1" action="<c:url value='showDetails.action'/>">
    <input id="input1" type="hidden" name="position" value="">
</form>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/javascript">
    //防止页面后退
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });

    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('chart'));
    var myChart1 = echarts.init(document.getElementById('chart1'));

    myChart.showLoading();

    var data1 = [<c:forEach items="${outliers}" var="outlier">"${outlier.position}",</c:forEach>]
    var data2 = [<c:forEach items="${outliers}" var="outlier">"${outlier.outbreaks}",</c:forEach>]
    var data3 = [<c:forEach items="${categoryOutliers}" var="outlier">"${outlier.category}",</c:forEach>]
    var data4 = [<c:forEach items="${categoryOutliers}" var="outlier">{value:"${outlier.outbreaks}",name:"${outlier.category}"},</c:forEach>]

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: ''
        },
        tooltip: {},
        legend: {
            data:['爆发次数']
        },
        dataZoom: [{
            type: 'inside'
        }, {
            type: 'slider'
        }],
        visualMap: {
            top: 10,
            left: 10,
            min: 0,
            max: 100,
            type: 'continuous',
            inRange: {
                color:['#cc0033','#7e0023']
            }
        },
        xAxis: {
            data: data1
        },
        yAxis: {},
        series: [{
            name: '爆发次数',
            type: 'bar',
            data: data2
        }]
    };

    var option1 = {
        title : {
            text: '各分类人流爆发情况',
            x:'center',
            y:'bottom'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        series : [
            {
                name: '地点分类',
                type: 'pie',
                radius : '55%',
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

    // 使用刚指定的配置项和数据显示图表
    myChart.hideLoading();
    myChart.setOption(option);

    myChart.on('click',function(param) {
        document.getElementById('input1').value = param.name;
        document.getElementById('from1').submit();
    });
    myChart1.setOption(option1);

    //数据转换处理
    var data5 = [<c:forEach items="${detailOutliers}" var="outlier">
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

    });
</script>
</body>
</html>