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
    <title>菜单管理---左侧树</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${ctx}/resources/layui_ext/dtree/font/dtreefont.css">
</head>
<body>
    <%--菜单树 开始--%>
        <ul id="menuTree" class="dtree" data-id="0"></ul>
    <%--菜单树 结束--%>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/layui_ext/dtree/dtree.js"></script>
<script type="text/javascript">
    var DemoTree;
    layui.extend({
        dtree: '${ctx}/resources/layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['dtree','layer','jquery'], function(){
        var dtree = layui.dtree;
        var layer = layui.layer;
        var $ = layui.jquery;
        // var data ={
        //     status:{"code":200,"message":"操作成功"},
        //     data: [
        //         {id:"001",title: "湖南省",parentId: "0"},
        //         {id:"002",title: "湖北省",parentId: "0"},
        //         {id:"001004",title: "衡阳市",parentId: "001"},
        //         {id:"001005",title: "郴州市",parentId: "001"}
        //     ]
        // };
        // 初始化树
        DemoTree = dtree.render({
            elem: "#menuTree",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
            // checkbar:false, //开启复选框
            method:'get',//修改response中返回数据的定义
            url: "${ctx}/menu/loadMenuManagerLeftTreeJson"
    });
        // 绑定节点点击
        dtree.on("node('menuTree')" ,function(obj){
            // layer.msg(JSON.stringify(obj.param.nodeId));
            window.parent.right.tableFlush(obj.param.nodeId);
        });
    });
</script>
</body>
</html>