<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2020/2/11
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>操作员业绩统计</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/font/dtreefont.css">
</head>
<body style="height: 100%; margin: 0">
<!--查询条件开始-->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
    <legend>查询条件</legend>
</fieldset>
<blockquote class="layui-elem-quote">
    <form  method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">年份</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" readonly="readonly" id="year" name="year"/>
                </div>
            </div>
            <div class="layui-inline">
                <button type="button" class="layui-btn layui-btn-normal" id="doSearch"><span class="layui-icon layui-icon-search"></span>查询</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</blockquote>
<!--查询条件结束-->
<div id="container" style="height: 80%"></div>
<script type="text/javascript" src="${ctx}/resources/echarts/js/echarts.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/echarts/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','table','layer','laydate'],function () {
        var $ = layui.jquery;
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
        var laydate = layui.laydate;
        //初始化时间选择器
        laydate.render({
            elem: '#year',
            type: 'year',
            value: new Date()
        });
        $("#doSearch").click(function () {
            getOutstand();
        });
        function getOutstand(){
            var year=$("#year").val();
            // alert(year);
            //无法获取year 将其判断赋值
            if(year==''){
                year=new Date().getFullYear();
            }
            $.post("${ctx}/stat/loadOpernameYearOutstandJson",{year:year},function (data) {
                var dom = document.getElementById("container");
                var myChart = echarts.init(dom);
                var app = {};
                option = null;
                option = {
                    color: ['#3398DB'],
                    title: {
                        text: '业务销售额统计',
                        subtext: '真实有效',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: data.name,
                            axisTick: {
                                alignWithLabel: true
                            }
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value'
                        }
                    ],
                    series: [
                        {
                            name: '销售额',
                            type: 'bar',
                            barWidth: '60%',
                            data: data.value
                        }
                    ]
                };
                ;
                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }
            });
        }

        getOutstand();
    });

</script>
</body>
</html>
