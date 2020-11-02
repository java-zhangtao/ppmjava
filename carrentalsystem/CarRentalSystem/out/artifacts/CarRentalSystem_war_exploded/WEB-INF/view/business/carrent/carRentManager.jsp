<%--
Created by IntelliJ IDEA.
User: ASUS
Date: 2020/1/30
Time: 16:41
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>汽车出租管理</title>
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
</head>
<body class="childrenBody">
<!--查询条件开始-->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
    <legend>查询条件</legend>
</fieldset>
<blockquote class="layui-elem-quote">
    <form  method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-inline">
                   <input type="text" class="layui-input" id="identity" name="identity"/>
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
<%--添加出租单信息 开始--%>
<div id="rentCarDiv" style="display: none;">
    <form action="" method="post" id="rentForm" class="layui-form layui-form-pane" lay-filter="rentForm">
        <input type="hidden" name="identity" id="add_identity"/>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">起租时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="begindate" id="begindate" lay-verify="required"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">归回时间</label>
                <div class="layui-input-block">
                    <input type="text" name="returndate" id="returndate" lay-verify="required" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出租单号</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="rentid" readonly="readonly"  id="rentid"/>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">汽车号码</label>
                <div class="layui-input-inline">
                    <input type="text" name="carnumber" id="carnumber" lay-verify="required" readonly="readonly"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出租价格</label>
                <div class="layui-input-inline">
                    <input type="text" name="price" lay-verify="required" autocomplete="off" placeholder="请输入出租价格" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">操作员</label>
                <div class="layui-input-block">
                    <input type="text" name="opername"   readonly="readonly" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center">
                <button type="button" class="layui-btn layui-btn-normal"  lay-submit="" lay-filter="doSubmit"><span class="layui-icon layui-icon-ok"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<%--添加出租单信息 结束--%>
<!--数据表格开始-->
<div id="CarRentDiv" style="display: none;">
    <table class="layui-hide" id="carTable" lay-filter="carTable"></table>
    <div id="carRowBar" style="display: none">
        <button type="button" lay-event="rentcar"  class="layui-btn layui-btn-sm layui-btn-warm"><span class="layui-icon layui-icon-release"></span>出租</button>
        <button type="button" lay-event="viewImg"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-template"></span>查看大图</button>
    </div>
</div>
<!--数据表格结束-->
<%--查看汽车图片 开始--%>
<div id="showCarImageDiv" style="display: none;text-align: center">
    <img id="car_image" width="500px" height="450px" alt="无图片"/>
</div>
<%--查看汽车图片 结束--%>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','table','layer','laydate'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var laydate=layui.laydate;
        //初始化时间选择器
        laydate.render({
            elem: '#begindate',
            type: 'datetime'
        });
        laydate.render({
            elem: '#returndate',
            type: 'datetime'
        });
        //表格数据渲染
        function initTable(){
            var tableIns=table.render({
                elem: '#carTable'
                ,url:'${ctx}/car/loadAllCar?isrenting=0&page=1&limit=10'
                ,toolbar: true //开启头部工具栏，并为其绑定左侧模板
                ,title: '汽车数据表'
                // ,height: 'full-200'
                ,page: true
                ,cols: [ [
                    {field:'carnumber', title:'汽车号码',align: 'center',width:'150'}
                    ,{field:'cartype', title:'汽车类型',align: 'center',width:'150'}
                    ,{field:'color', title:'汽车颜色',align: 'center',width:'120'}
                    ,{field:'price', title:'汽车价格',align: 'center',width:'120'}
                    ,{field:'rentprice', title:'汽车出租价格',align: 'center',width:'120'}
                    ,{field:'deposit', title:'汽车出租订金',align: 'center',width:'120'}
                    ,{field:'description', title:'汽车描述',align: 'center',width:'150'}
                    ,{field:'createtime', title:'创建时间',align: 'center',width:'150'}
                    ,{field:'carimg', title:'汽车图片',align: 'center',width:'150',templet: function(d){
                            return '<img width=40 height=40 src=${ctx}/file/showImageByPath?path='+d.carimg+'/>';
                        }}
                    ,{field:'isrenting', title:'是否出租',align: 'center',width:'100',templet: function(d){
                            return d.isrenting==0?'<font color="blue">已出租</font>':'<font color="red">未出租</font>';
                        }}
                    ,{fixed: 'right', title:'操作', toolbar: '#carRowBar',align: 'center',width:'200'}
                ] ]
            });
        }
        //模糊查询
        // form.on("submit(doSearch)",function (data) {
        //     tableIns.reload({
        //         where: data.field
        //         ,page: {
        //             curr: 1
        //         }
        //     });
        //     return false;
        // });
        //判断客户是否存在
        $('#doSearch').click(function () {
            var data=$('#dataForm').serialize();
            $.post("${ctx}/rent/checkCustomerExist",data,function (res) {
                if(res.code>0){
                    $('#CarRentDiv').show();
                    //初始化表格
                    initTable();
                }else{
                    layer.msg(res.msg);
                    $('#CarRentDiv').hide();
                }
            })
        });
        //行工具监听
        table.on("tool(carTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'rentcar':
                    rentCarLayer(data);
                    break;
                case 'viewImg':
                    showCarImageLayer(data);
                    break;
            }
        });
        //监听提交
        form.on("submit(doSubmit)",function (data) {
            var identity=$("#identity").val();
            $("#add_identity").val(identity);
            $.post("${ctx}/rent/addRentCar",data.field,function (res) {
                if(res.code==200){
                    $("#identity").val("");
                    $("#CarRentDiv").hide();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            });
        });
        //出租汽车
        function rentCarLayer(data) {
            mainIndex=layer.open({
                type: 1,
                title:'出租汽车',
                content: $('#rentCarDiv'),
                area:['700px','600px'],
                success: function () {
                    $('#rentForm')[0].reset();
                    var identity=$("#identity").val();
                    var price=data.rentprice;
                    var carnumber=data.carnumber;
                    $.post("${ctx}/rent/initRentCarForm",{
                        identity:identity,
                        price:price,
                        carnumber:carnumber
                    },function (res) {
                        form.val("rentForm",res);
                    })
                }
            });
        }
        //查看图片
        function showCarImageLayer(data){
            mainIndex=layer.open({
                type: 1,
                title:'汽车图片',
                content: $('#showCarImageDiv'),
                area:['600px','550px'],
                success: function () {
                    $('#car_image').attr('src',"${ctx}/file/showImageByPath?path="+data.carimg);
                }
            });
        }
    })
</script>
</body>
</html>