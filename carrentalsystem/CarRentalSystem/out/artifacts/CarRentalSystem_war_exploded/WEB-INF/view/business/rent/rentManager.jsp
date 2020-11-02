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
    <title>出租管理</title>
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
    <form action="/rent/loadAllRent" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">出租单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="rentid"    class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">汽车号牌</label>
                <div class="layui-input-inline">
                    <input type="text" name="carnumber" id="carnumber"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-inline">
                    <input type="text" name="identity" id="identity"   class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">

            <div class="layui-inline">
                <label class="layui-form-label">起租时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="begindate" placeholder="yyyy-MM-dd HH:mm:ss" readonly="readonly" id="search_begindate"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">还车时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="returndate" placeholder="yyyy-MM-dd HH:mm:ss" class="layui-input" readonly="readonly" id="search_returndate">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出租单状态</label>
                <div class="layui-input-block">
                    <input type="radio" name="rentflag" value="1" title="未归还">
                    <input type="radio" name="rentflag" value="0" title="已归还">
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
    <table class="layui-hide" id="rentTable" lay-filter="rentTable"></table>
</div>
<script id="rentRowBar" type="text/html">
    {{#  if(d.rentflag ==0){ }}
    {{#  } else { }}
    <button type="button" lay-event="update"  class="layui-btn layui-btn-sm layui-btn-warm"><span class="layui-icon layui-icon-edit"></span>修改</button>
    <button type="button" lay-event="delete"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
    {{#  } }}
</script>
<!--数据表格结束-->
<!--修改的弹出层 开始-->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" id="rentForm" class="layui-form layui-form-pane" lay-filter="rentForm">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">起租时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="begindate" id="begindate" placeholder="yyyy-MM-dd HH:mm:ss" lay-verify="required"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">归回时间</label>
                <div class="layui-input-block">
                    <input type="text" name="returndate" id="returndate" placeholder="yyyy-MM-dd HH:mm:ss" lay-verify="required" class="layui-input">
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
                    <input type="text" name="carnumber"  lay-verify="required" readonly="readonly"  class="layui-input">
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
<!--修改的弹出层 结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/layui_ext/dtree/dtree.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','table','layer','laydate'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        var laydate=layui.laydate;
        //初始化时间选择器
        laydate.render({
            elem: "#search_begindate",
            type: "datetime"
        });
        laydate.render({
            elem: "#search_returndate",
            type: "datetime"
        });
        laydate.render({
            elem: "#begindate",
            type: "datetime"
        });
        laydate.render({
            elem: "#returndate",
            type: "datetime"
        });
        //表格数据渲染
        var tableIns=table.render({
            elem: '#rentTable'
            ,url:'${ctx}/rent/loadAllRent'
            ,toolbar: '#rentToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '汽车出租表'
            ,height: 'full-230'
            ,page: true
            ,cols: [ [
               {field:'rentid', title:'出租单号',align: 'center',width:'280'}
               ,{field:'price', title:'出租价格',align: 'center',width:'120'}
               ,{field:'begindate', title:'起租时间',align: 'center',width:'180'}
               ,{field:'returndate', title:'还车时间',align: 'center',width:'180'}
                ,{field:'identity', title:'身份证号',align: 'center',width:'180'}
                ,{field:'carnumber', title:'汽车号牌',align: 'center',width:'150'}
                ,{field:'opername', title:'操作员',align: 'center',width:'120'}
                ,{field:'createtime', title:'创建时间',align: 'center',width:'180'}
                ,{field:'rentflag', title:'是否出租',align: 'center',width:'120',templet: function(d){
                        return d.rentflag==0?'<font style="color:blue">已归还</font>':'<font style="color:red">未归还</font>';
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#rentRowBar',align: 'center',width:200}
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
        //行工具监听
        table.on("tool(rentTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'update':
                    updateRentLayer(data);
                    break;
                case 'delete':
                    deleteRent(data);
                    break;
            }
        });
        var mainIndex;
        var url;
        //修改弹出层设置
        function updateRentLayer(data){
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'修改出租',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#rentForm')[0].reset();
                    //表单加载数据
                    form.val('rentForm',data);
                    <%--$.post("${ctx}/rent/initRentCarForm",function (res) {--%>
                    <%--    form.val("rentForm",data);--%>
                    <%--});--%>
                    url='${ctx}/rent/updateRent'
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
        function deleteRent(data) {
            layer.confirm('你确定要删除【'+data.rentid+'】这条出租吗？', {icon: 3, title:'提示'}, function(index){
                $.post("${ctx}/rent/deleteRent",{id:data.rentid},function(res){
                    if(res.code==200){
                        tableIns.reload();
                    }
                    layer.msg(res.msg);
                });
                layer.close(index);
            });
        }
    })
</script>
</body>
</html>