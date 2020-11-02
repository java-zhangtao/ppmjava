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
    <title>客户管理</title>
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
    <form action="${ctx}/customer/loadAllCustomer" method="post" id="dataForm" lay-filter="dataForm" class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">客户姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="custname"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-inline">
                    <input type="text" name="identity"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="phone"  class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">客户职称</label>
                <div class="layui-input-inline">
                    <input type="text" name="career"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">客户地址</label>
                <div class="layui-input-inline">
                    <input type="text" name="address"   class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-inline">
                    <input type="radio" name="sex" class="layui-input" value="1" title="男">
                    <input type="radio" name="sex" class="layui-input" value="0" title="女">
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
    <table class="layui-hide" id="customerTable" lay-filter="customerTable"></table>
    <div id="customerToolBar" style="display: none">
        <button type="button" lay-event="add"  class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加</button>
        <button type="button" lay-event="batchDelete" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>批量删除</button>
    </div>
    <div id="customerRowBar" style="display: none">
        <button type="button" lay-event="update"  class="layui-btn layui-btn-sm layui-btn-warm"><span class="layui-icon layui-icon-edit"></span>修改</button>
        <button type="button" lay-event="delete"  class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
    </div>
</div>
<!--数据表格结束-->
<!--添加与修改的弹出层开始-->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <form action="" method="post" id="customerForm" class="layui-form layui-form-pane" lay-filter="customerForm">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">客户姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="custname" lay-verify="required" autocomplete="off" placeholder="请输入客户名称" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-block">
                    <input type="text" name="identity" lay-verify="required" autocomplete="off" placeholder="请输入身份证号" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客户地址</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input" name="address" lay-verify="required" placeholder="请输入客户地址" id="address"/>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">客户职称</label>
                <div class="layui-input-inline">
                    <input type="text" name="career" lay-verify="required" autocomplete="off" placeholder="请输入客户职称" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="phone" lay-verify="required" autocomplete="off" placeholder="请输入联系电话" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-inline">
                    <input type="radio" name="sex" value="1"  class="layui-input" title="男" checked/>
                    <input type="radio" name="sex" value="0"  class="layui-input" title="女"/>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center">
                <button type="button" class="layui-btn layui-btn-normal" id="doSubmit" lay-submit="" lay-filter="doSubmit"><span class="layui-icon layui-icon-ok"></span>提交</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
<!--添加与修改的弹出层结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','table','layer'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var table=layui.table;
        var layer=layui.layer;
        //表格数据渲染
        var tableIns=table.render({
            elem: '#customerTable'
            ,url:'${ctx}/customer/loadAllCustomer'
            ,toolbar: '#customerToolBar' //开启头部工具栏，并为其绑定左侧模板
            ,title: '客户数据表'
            // ,height: 'full-200'
            ,page: true
            ,cols: [ [
                {type: 'checkbox', fixed: 'left'}
                ,{field:'identity', title:'身份证号',align: 'center',width:'180'}
                ,{field:'custname', title:'客户姓名',align: 'center',width:'120'}
                ,{field:'career', title:'客户职称',align: 'center',width:'150'}
                ,{field:'address', title:'客户地址',align: 'center',width:'150'}
                ,{field:'phone', title:'联系电话',align: 'center',width:'180'}
                ,{field:'sex', title:'性别',align: 'center',width:'80',templet: function(d){
                        return d.sex==1?'<font style="color:blue">男</font>':'<font style="color:red">女</font>';
                    }}
                ,{field:'createtime', title:'创建时间',align: 'center',width:'180'}
                ,{fixed: 'right', title:'操作', toolbar: '#customerRowBar',align: 'center',width:'200'}
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
        table.on("toolbar(customerTable)",function(obj){

            switch(obj.event){
                case 'batchDelete':
                    batchDelete();
                    break;
                case 'add':
                    addCustomerLayer();
                    break;
            }
        });
        //行工具监听
        table.on("tool(customerTable)", function(obj){
            var data=obj.data;
            switch(obj.event){
                case 'update':
                    updateCustomerLayer(data);
                    break;
                case 'delete':
                    deleteCustomer(data);
                    break;
            }
        });
        var mainIndex;
        var url;
        //添加弹出层设置
        function addCustomerLayer() {
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'添加客户',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#customerForm')[0].reset();
                    url='${ctx}/customer/addCustomer'
                }
            });
        }
        //修改弹出层设置
        function updateCustomerLayer(data){
            //初始化添加弹出层
            mainIndex=layer.open({
                type: 1,
                title:'修改客户',
                content: $('#addOrUpdateDiv'),
                area:['800px','550px'],
                success: function () {
                    //重置
                    $('#customerForm')[0].reset();
                    //表单加载数据
                    form.val('customerForm',data);
                    url='${ctx}/customer/updateCustomer'
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
        })
        // $('#doSubmit').click(function () {
        //     //表单数据序列化
        //     var data=$('#customerForm').serialize();
        //
        // });
        //删除函数
        function deleteCustomer(data) {
            layer.confirm('你确定要删除【'+data.custname+'】这个客户吗？', {icon: 3, title:'提示'}, function(index){
                $.post("${ctx}/customer/deleteCustomer",{id:data.identity},function(res){
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
            var checkStatus=table.checkStatus('customerTable');
            var len=checkStatus.data.length;
            console.log(checkStatus.data);
            if(len>0){
                layer.confirm('你确定要删除这些客户吗？', {icon: 3, title:'提示'}, function(index){
                    var data=checkStatus.data;
                    $.each(data,function (index,item) {
                        if(index==0){
                            ids+="ids="+item.identity;
                        }else{
                            ids+="&ids="+item.identity;
                        }
                    });
                    $.post("${ctx}/customer/batchDeleteCustomer",ids,function(res){
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