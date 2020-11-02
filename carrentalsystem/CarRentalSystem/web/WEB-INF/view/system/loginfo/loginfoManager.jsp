<%--
Created by IntelliJ IDEA.
User: ASUS
Date: 2020/1/31
Time: 16:21
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>日志管理</title>
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
    <form action="${ctx}/loginfo/loadAllLoginfo" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">登录名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="loginname"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">登录地址</label>
                <div class="layui-input-inline">
                    <input type="text" name="loginip" id="loginip"  class="layui-input">
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
    <table class="layui-hide" id="loginfoTable" lay-filter="loginfoTable"></table>
    <div id="loginfoToolBar" style="display: none">
        <button type="button" lay-event="batchDelete" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>批量删除</button>
    </div>
    <div id="loginfoRowBar" style="display: none">
        <button type="button" lay-event="deleteLoinfo"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
    </div>

</div>
<!--数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['table','jquery','form','layer','laydate'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var laydate=layui.laydate;
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
            elem: '#loginfoTable'
            ,url:'${ctx}/loginfo/loadAllLoginfo'
            ,toolbar: '#loginfoToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户登录日志数据表'
            ,height: 'full-230'
            ,page: true
            ,cols: [ [
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',align: 'center'}
                ,{field:'loginname', title:'登录名称',align: 'center'}
                ,{field:'loginip', title:'登录地址',align: 'center'}
                ,{field:'logintime', title:'登录时间',align: 'center'}
                ,{fixed: 'right', title:'操作', toolbar: '#loginfoRowBar',align: 'center'}
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
        table.on("toolbar(loginfoTable)",function(obj){
            switch(obj.event){
                case 'batchDelete':
                    batchDelete();
                    break;
            }
        });
        //行工具监听
        table.on("tool(loginfoTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'deleteLoinfo':
                    deleteLoginfo(data);
                    break;
            }
        });
        //删除函数
        function deleteLoginfo(data) {
            layer.confirm('你确定要删除这条日志吗？', {icon: 3, title:'提示'}, function(index){
                $.post("${ctx}/loginfo/deleteLoginfo",{id:data.id},function(res){
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
            var checkStatus=table.checkStatus('loginfoTable');
            var len=checkStatus.data.length;
            console.log(checkStatus.data);
            if(len>0){
                layer.confirm('你确定要删除这些日志吗？', {icon: 3, title:'提示'}, function(index){
                    var data=checkStatus.data;
                    $.each(data,function (index,item) {
                        if(index==0){
                            ids+="ids="+item.id;
                        }else{
                            ids+="&ids="+item.id;
                        }
                    });
                    $.post("${ctx}/loginfo/batchDeleteLoginfo",ids,function(res){
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