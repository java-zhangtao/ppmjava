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
    <title>公告管理</title>
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
    <form action="${ctx}/notice/loadAllNotice" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">公告标题</label>
                <div class="layui-input-inline">
                    <input type="text" name="title"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">发布人</label>
                <div class="layui-input-inline">
                    <input type="text" name="opername" id="opername"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">开始时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="startTime" readonly="readonly" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" id="startTime"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">结束时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="endTime" readonly="readonly" id="endTime" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input">
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
    <table class="layui-hide" id="noticeTable" lay-filter="noticeTable"></table>
    <div id="noticeToolBar" style="display: none">
        <button type="button" lay-event="add"  class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加</button>
        <button type="button" lay-event="batchDelete" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>批量删除</button>
    </div>
    <div id="noticeRowBar" style="display: none">
        <button type="button" lay-event="update"  class="layui-btn layui-btn-sm layui-btn-warm"><span class="layui-icon layui-icon-edit"></span>修改</button>
        <button type="button" lay-event="delete"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
        <button type="button" lay-event="show"  class="layui-btn layui-btn-sm layui-btn-normal"><span class="layui-icon layui-icon-about"></span>查看</button>
    </div>
</div>
<!--数据表格结束-->
<!--添加与修改的弹出层开始-->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" id="noticeForm" class="layui-form layui-form-pane" lay-filter="noticeForm">
        <div class="layui-form-item">
            <input type="hidden" name="id"/>
            <label class="layui-form-label">公告标题</label>
            <div class="layui-input-block">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">公告内容</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" name="content" lay-verify="content" id="content"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center">
                <button type="button" class="layui-btn layui-btn-normal" id="doSubmit" lay-submit=""><span class="layui-icon layui-icon-ok"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<!--添加与修改的弹出层结束-->
<!--查看弹出层开始-->
<div id="showNoticeDiv" style="display: none;padding: 10px">
    <h2 id="show_title" style="text-align: center"></h2>
    <div style="text-align: right">
        发布人：<span id="show_opername"></span>
        发布时间：<span id="show_createtime"></span>
    </div>
    <hr>
    <div id="show_content">

    </div>
</div>
<!--查看弹出层结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','table','layer','laydate','layedit'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var laydate=layui.laydate;
        var layedit=layui.layedit;
        //初始化日期
        laydate.render({
            elem: '#startTime',
            type: 'datetime'
        });
        laydate.render({
            elem: '#endTime',
            type: 'datetime'
        });
        //表格数据渲染
        var tableIns=table.render({
            elem: '#noticeTable'
            ,url:'${ctx}/notice/loadAllNotice'
            ,toolbar: '#noticeToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '公告数据表'
            ,height: 'full-230'
            ,page: true
            ,cols: [ [
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',align: 'center'}
                ,{field:'title', title:'公告标题',align: 'center'}
                ,{field:'createtime', title:'创建时间',align: 'center'}
                ,{field:'opername', title:'发布人',align: 'center'}
                ,{fixed: 'right', title:'操作', toolbar: '#noticeRowBar',align: 'center'}
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
        //创建一个编辑器
        var editIndex = layedit.build('content');
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
        table.on("toolbar(noticeTable)",function(obj){

            switch(obj.event){
                case 'batchDelete':
                    batchDelete();
                    break;
                case 'add':
                    addNoticeLayer();
                    break;
            }
        });
        //行工具监听
        table.on("tool(noticeTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'update':
                    updateNoticeLayer(data);
                    break;
                case 'delete':
                    deleteNotice(data);
                    break;
                case 'show':
                    showNoticeLayer(data);
                    break;
            }
        });
        var mainIndex;
        var url;
        //添加弹出层设置
        function addNoticeLayer() {
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'发布公告',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#noticeForm')[0].reset();
                    layedit.setContent(editIndex,"");
                    url='${ctx}/notice/addNotice'
                }
            });
        }
        //修改弹出层设置
        function updateNoticeLayer(data){
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'修改公告',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#noticeForm')[0].reset();
                    //表单加载数据
                    form.val('noticeForm',data);
                    layedit.setContent('editIndex',data.content);
                    url='${ctx}/notice/updateNotice'
                }
            });
        }
        //监听提交
        $('#doSubmit').click(function () {
            //富文本与textarea同步
            layedit.sync(editIndex);
            //表单数据序列化
            var data=$('#noticeForm').serialize();
            $.post(url,data,function (res) {
                if(res.code==200){
                    tableIns.reload();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            });
        });
        //查看弹出层的设置
        function showNoticeLayer(data){
            mainIndex=layer.open({
                type: 1,
                title:'查看公告',
                content: $('#showNoticeDiv'),
                area:['600px','400px'],
                success: function () {
                    $('#show_title').text(data.title);
                    $('#show_opername').text(data.opername);
                    $('#show_createtime').text(data.createtime);
                    $('#show_content').text(data.content);
                }
            });
        }
        //删除函数
        function deleteNotice(data) {
            layer.confirm('你确定要删除【'+data.title+'】这条公告吗？', {icon: 3, title:'提示'}, function(index){
                $.post("${ctx}/notice/deleteNotice",{id:data.id},function(res){
                    if(res.code==200){
                        tableIns.reload();
                    }
                    layer.msg(res.msg);
                });
                layer.close(index);
            });
        }
        //批量删除函数
        function batchDelete(){
            var ids = "";
            var checkStatus=table.checkStatus('noticeTable');
            var len=checkStatus.data.length;
            console.log(checkStatus.data);
            if(len>0){
                layer.confirm('你确定要删除这些公告吗？', {icon: 3, title:'提示'}, function(index){
                    var data=checkStatus.data;
                    $.each(data,function (index,item) {
                        if(index==0){
                            ids+="ids="+item.id;
                        }else{
                            ids+="&ids="+item.id;
                        }
                    });
                    $.post("${ctx}/notice/batchDeleteNotice",ids,function(res){
                        if(res.code==200){
                            tableIns.reload();
                        }
                        layer.msg(res.msg);
                    });
                    layer.close(index);
                });
            }else
            {
                layer.msg("你没有选中行。")
            }
        }
    })
</script>
</body>
</html>