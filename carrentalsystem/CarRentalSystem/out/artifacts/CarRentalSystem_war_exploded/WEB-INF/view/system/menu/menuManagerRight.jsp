<%--
Created by IntelliJ IDEA.
User: ASUS
Date: 2020/1/30
Time: 16:41
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:shiro="http://www.pollix.at/thymeleaf/shiro">
<head>
    <meta charset="UTF-8">
    <title>菜单管理</title>
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
<body class="childrenBody">
<!--查询条件开始-->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
    <legend>查询条件</legend>
</fieldset>
<blockquote class="layui-elem-quote">
    <form action="${ctx}/menu/loadAllMenu" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">菜单名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="title"   class="layui-input">
                </div>
            </div>
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
    <table class="layui-hide" id="menuTable" lay-filter="menuTable"></table>
    <div id="menuToolBar" style="display: none">
        <button type="button" lay-event="add"  class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加</button>
    </div>
    <div id="menuRowBar" style="display: none">
        <button type="button" lay-event="update"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
    </div>
</div>
<!--数据表格结束-->
<!--添加与修改的弹出层开始-->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" id="menuForm" class="layui-form layui-form-pane" lay-filter="menuForm">

        <div class="layui-form-item">
            <label class="layui-form-label">父级菜单</label>
            <div class="layui-input-block">
                <input type="hidden" name="pid" id="pid" lay-verify="required"/>
                <ul id="menuTree" class="dtree" data-id="0" ></ul>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜单名称</label>
            <div class="layui-input-block">
                <input type="hidden" name="id"/>
                <input type="text" name="title" lay-verify="required" autocomplete="off" placeholder="请输入菜单名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜单地址</label>
            <div class="layui-input-block">
                <input type="text" name="href" lay-verify="href" autocomplete="off" placeholder="请输入菜单地址" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜单图标</label>
            <div class="layui-input-inline">
                <input type="text" name="icon" lay-verify="icon" autocomplete="off" placeholder="请输入菜单地址" class="layui-input">
            </div>
            <label class="layui-form-label">TARGET</label>
            <div class="layui-input-inline">
                <input type="text" name="target" lay-verify="target" autocomplete="off" placeholder="请输入菜单地址" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否展开</label>
            <div class="layui-input-inline">
                <input type="radio" name="spread" value="1" title="展开" checked="">
                <input type="radio" name="spread" value="0" title="不展开">
            </div>
            <label class="layui-form-label">是否可用</label>
            <div class="layui-input-inline">
                <input type="radio" name="available" value="1" title="可用" checked="">
                <input type="radio" name="available" value="0" title="不可用">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center">
                <button type="button" class="layui-btn layui-btn-normal" id="doSubmit" lay-filter="doSubmit" lay-submit=""><span class="layui-icon layui-icon-ok"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<!--添加与修改的弹出层结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/layui_ext/dtree/dtree.js"></script>
<script type="text/javascript">
    //提升作用域
    var tableIns;

    layui.extend({
        dtree: '${ctx}/resources/layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['jquery','form','table','layer','dtree'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var dtree = layui.dtree;

        //表格数据渲染
        tableIns=table.render({
            elem: '#menuTable'
            ,url:'${ctx}/menu/loadAllMenu'
            ,toolbar: '#menuToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '菜单数据表'
            ,height: 'full-230'
            ,page: true
            ,cols: [ [
                {field:'id', title:'ID',align: 'center',width:'80'}
                ,{field:'pid', title:'父级菜单ID',align: 'center',width:'100'}
                ,{field:'title', title:'菜单名称',align: 'center',width:'100'}
                ,{field:'spread', title:'是否展开',align: 'center',width:'100',templet: function(d){
                        return d.spread==1?'<font style="color:blue">展开</font>':'<font style="color:red">不展开</font>';
                    }}
                ,{field:'target',hide:true,align: 'center',width:'60'}
                ,{field:'icon', title:'菜单图标',align: 'center',width:'200',templet:function (d) {
                    return '<font class="layui-icon">'+d.icon+'</font>';
                    }}
                ,{field:'href', title:'菜单地址',align: 'center',width:'150'}
                ,{field:'available', title:'是否可用',align: 'center',width:'100',templet: function(d){
                        return d.available==1?'<font style="color:blue">可用</font>':'<font style="color:red">不可用</font>';
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#menuRowBar',align: 'center',width:'200'}
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
        table.on("toolbar(menuTable)",function(obj){

            switch(obj.event){
                case 'add':
                    addMenuLayer();
                    break;
            }
        });
        //行工具监听
        table.on("tool(menuTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'update':
                    updateMenuLayer(data);
                    break;
                case 'delete':
                    deleteMenu(data);
                    break;
            }
        });
        //初始化父级菜单的下拉选项
        var menuTreeSelect=dtree.renderSelect({
            elem: "#menuTree",
            width: "100%", // 可以在这里指定树的宽度来填满div
            url: "${ctx}/menu/loadMenuManagerLeftTreeJson",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0} //修改response中返回数据的定义
        });
        dtree.on("node('menuTree')" ,function(obj){
            $("#pid").val(obj.param.nodeId);

            //layer.msg(JSON.stringify(obj.param.nodeId));
        });
        var mainIndex;
        var url;
        //添加弹出层设置
        function addMenuLayer() {
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'添加菜单',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#menuForm')[0].reset();
                    $('#pid').val("");
                    //设置菜单的值
                    url='${ctx}/menu/addMenu'
                }
            });
        }
        //修改弹出层设置
        function updateMenuLayer(data){
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'修改菜单',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#menuForm')[0].reset();
                    //表单加载数据
                    form.val('menuForm',data);
                    dtree.dataInit("menuTree", data.pid);
                    // 也可以在这里指定，第二个参数如果不填，则会自动返显当前选中的数据
                    dtree.setSelectValue("menuTree");
                    url='${ctx}/menu/updateMenu'

                }
            });
        }
        form.on("submit(doSubmit)",function (data) {
            // alert(data.field);
            $.post(url,data.field,function (res) {
                if(res.code==200){
                    tableIns.reload();
                    //选择的下拉框
                    menuTreeSelect.reload();
                    //刷新左侧的菜单树
                    window.parent.left.DemoTree.reload();
                }
                layer.msg(res.msg);
                layer.close(mainIndex);
            });
            return false;
        });
        //监听提交
        // $('#doSubmit').click(function () {
        //     //表单数据序列化
        //     var data=$('#menuForm').serialize();
        //     // alert(data);
        //     $.post(url,data,function (res) {
        //         if(res.code==200){
        //             tableIns.reload();
        //             //选择的下拉框
        //             menuTreeSelect.reload();
        //             //刷新左侧的菜单树
        //             window.parent.left.DemoTree.reload();
        //         }
        //         layer.msg(res.msg);
        //         layer.close(mainIndex);
        //
        //     });
        // });
        //删除函数
        function deleteMenu(data) {
            $.post("${ctx}/menu/checkDeleteMenuChildren",{id:data.id},function (res) {
                if(res.value){
                    layer.msg("你不能删除，存在子菜单。")
                }else {
                    layer.confirm('你确定要删除【'+data.title+'】这个菜单吗？', {icon: 3, title:'提示'}, function(index){
                        $.post("${ctx}/menu/deleteMenu",{id:data.id},function(res){
                            if(res.code==200){
                                tableIns.reload();
                                //选择的下拉框
                                menuTreeSelect.reload();
                                //刷新左侧的菜单树
                                window.parent.left.DemoTree.reload();
                            }
                            layer.msg(res.msg);
                        });

                        layer.close(index);
                    });
                }
            })

        }
    });

    function tableFlush(id) {
        // alert(id);
        tableIns.reload({
            where:{
                id:id
            },
            page:{
                curr:1
            }
        });
    }
</script>
</body>
</html>