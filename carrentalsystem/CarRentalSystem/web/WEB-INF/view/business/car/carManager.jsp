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
    <title>汽车管理</title>
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
    <form action="${ctx}/car/loadAllCar" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">车辆号码</label>
                <div class="layui-input-inline">
                   <input type="text" class="layui-input" name="carnumber"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">车辆类型</label>
                <div class="layui-input-inline">
                    <input type="text" name="cartype" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">车辆颜色</label>
                <div class="layui-input-inline">
                    <input type="text" name="color"  class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">车辆描述</label>
                <div class="layui-input-inline">
                    <input type="text" name="description"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">是否出租</label>
                <div class="layui-input-block">
                    <input type="radio" name="isrenting" value="1" title="已出租"  class="layui-input">
                    <input type="radio" name="isrenting" value="0" title="未出租" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item" style="text-align: center">
            <div class="layui-inline">
                <button type="button" class="layui-btn layui-btn-normal" lay-submit="" lay-filter="doSearch"><span class="layui-icon layui-icon-search"></span>查询</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</blockquote>
<!--查询条件结束-->
<!--数据表格开始-->
<div>
    <table class="layui-hide" id="carTable" lay-filter="carTable"></table>
    <div id="carToolBar" style="display: none">
        <button type="button" lay-event="add"  class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加</button>
    </div>
    <div id="carRowBar" style="display: none">
        <button type="button" lay-event="update"  class="layui-btn layui-btn-sm layui-btn-warm"><span class="layui-icon layui-icon-edit"></span>修改</button>
        <button type="button" lay-event="delete"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
        <button type="button" lay-event="viewImg"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-template"></span>查看大图</button>
    </div>
</div>
<!--数据表格结束-->
<%--查看汽车图片 开始--%>
<div id="showCarImageDiv" style="display: none;text-align: center">
    <img id="car_image" width="500px" height="450px" alt="无图片"/>
</div>
<%--查看汽车图片 结束--%>
<!--添加与修改的弹出层开始-->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" id="carForm" class="layui-form layui-form-pane" lay-filter="carForm">
        <div class="layui-col-md12 layui-col-xs12">
            <div class="layui-row layui-col-space10">
                <div class="layui-col-md9 layui-col-xs7">
                    <div class="layui-form-item magt3">
                        <label class="layui-form-label">车辆号码</label>
                        <div class="layui-input-block">
                            <input type="text" name="carnumber" class="layui-input" placeholder="请输入车辆号码">
                        </div>
                    </div>
                    <div class="layui-form-item magt3">
                        <label class="layui-form-label">汽车类型</label>
                        <div class="layui-input-block">
                            <input type="text" name="cartype" id="cartype" class="layui-input" placeholder="请输入汽车类型">
                        </div>
                    </div>
                    <div class="layui-form-item magt3">
                        <label class="layui-form-label">汽车描述</label>
                        <div class="layui-input-block">
                            <input type="text" name="description" id="description" class="layui-input" placeholder="请输入汽车描述">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3 layui-col-xs5">
                    <div class="layui-upload-list thumbBox mag0 magt3">
                        <input type="hidden" name="carimg" id="carimg" value="images/defaultImg.png">
                        <img class="layui-upload-img thumbImg" src="${ctx}/file/showImageByPath?path=images/defaultImg.png">
                    </div>
                </div>
            </div>
            <div class="layui-form-item magb0">
                <div class="layui-inline">
                    <label class="layui-form-label">汽车颜色</label>
                    <div class="layui-input-inline">
                        <input type="text" id="color" name="color" class="layui-input" placeholder="请输入汽车颜色">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">汽车价格</label>
                    <div class="layui-input-inline">
                        <input type="text" id="price" name="price" class="layui-input" placeholder="请输入汽车价格">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">出租价格</label>
                    <div class="layui-input-inline">
                        <input type="text" id="rentprice" name="rentprice" class="layui-input" placeholder="请输入汽车出租价格">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">出租订金</label>
                    <div class="layui-input-inline">
                        <input type="text" id="deposit" name="deposit" class="layui-input" placeholder="请输入汽车出租订金">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否出租</label>
            <div class="layui-input-block">
                <input type="radio" checked name="isrenting" class="layui-input" value="1" title="已出租"/>
                <input type="radio" name="isrenting"class="layui-input" value="0" title="未出租"/>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center;padding: 5px">
                <button type="button" class="layui-btn layui-btn-normal" id="doSubmit" lay-submit="" lay-filter="doSubmit"><span class="layui-icon layui-icon-ok"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<!--添加与修改的弹出层结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','table','layer','upload'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var upload=layui.upload;
        //表格数据渲染
        var tableIns=table.render({
            elem: '#carTable'
            ,url:'${ctx}/car/loadAllCar'
            ,toolbar: '#carToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '供应商数据表'
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
                ,{field:'createtime', title:'创建时间',align: 'center',width:'180'}
                ,{field:'carimg', title:'汽车图片',align: 'center',width:'150',templet: function(d){
                        return '<img width=40 height=40 src=/file/showImageByPath?path='+d.carimg+'/>';
                    }}
                ,{field:'isrenting', title:'是否出租',align: 'center',width:'100',templet: function(d){
                        return d.isrenting==1?'<font style="color:blue">已出租</font>':'<font style="color:red">未出租</font>';
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#carRowBar',align: 'center',width:'300'}
            ] ]
            ,done: function(res, curr, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                console.log(res);
                //得到当前页码
                console.log(curr);
                //得到数据总量
                console.log(count);
                //当删除数据表格最后一页的最后一条数据时 渲染上一页的数据
                if(res.data.length==0&&curr!=1){
                    tableIns.reload({
                        page:{
                            curr:(curr-1)
                        }
                    })
                }
            }
        });
        //模糊查询
        form.on("submit(doSearch)",function (data) {
            tableIns.reload({
                where: data.field
                ,page: {
                    curr: 1
                }
            });
            return false;
        });
        //头工具事件
        table.on("toolbar(carTable)",function(obj){

            switch(obj.event){
                case 'add':
                    addCarLayer();
                    break;
            }
        });
        //行工具监听
        table.on("tool(carTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'update':
                    updateCarLayer(data);
                    break;
                case 'delete':
                    deleteCar(data);
                    break;
                case 'viewImg':
                    showCarImageLayer(data);
                    break;
            }
        });
        var mainIndex;
        var url;
        //添加弹出层设置
        function addCarLayer() {
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'添加汽车',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#carForm')[0].reset();
                    url='${ctx}/car/addCar';
                    //设置默认的图片
                    $('.thumbImg').attr('src',"${ctx}/file/showImageByPath?path=images/defaultImg.png");
                    $('#carimg').val("images/defaultImg.png");//给隐藏域赋值
                }
            });
        }
        //上传缩略图
        upload.render({
            elem: '.thumbBox',
            field:'mf',
            url: '${ctx}/file/uploadFile',
            acceptMime:'image/*',
            done: function(res, index, upload){
                // alert(res.path);
                var path=res.path;
                //显示图片
                $('.thumbImg').attr('src',"${ctx}/file/showImageByPath?path="+path);
                $('.thumbBox').css("background","#fff");
                // alert(path);
                $('#carimg').val(path);//给隐藏域赋值
            }
        });
        //修改弹出层设置
        function updateCarLayer(data){
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'修改汽车',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#carForm')[0].reset();
                    //表单加载数据
                    form.val('carForm',data);
                    url='${ctx}/car/updateCar';
                    $('.thumbImg').attr('src',"${ctx}/file/showImageByPath?path="+data.carimg);
                }
            });
        }
        //监听提交
        form.on("submit(doSubmit)",function (data) {
            $.post(url,data.field,function (res) {
                if(res.code==200){
                    tableIns.reload();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            });
        });
        //删除函数
        function deleteCar(data) {
            layer.confirm('你确定要删除【'+data.cartype+'】这个汽车吗？', {icon: 3, title:'提示'}, function(index){
                $.post("${ctx}/car/deleteCar",{id:data.carnumber},function(res){
                    if(res.code==200){
                        tableIns.reload();
                    }
                    layer.msg(res.msg);
                });
                layer.close(index);
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