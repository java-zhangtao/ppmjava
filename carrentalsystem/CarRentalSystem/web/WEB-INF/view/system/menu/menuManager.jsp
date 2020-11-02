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
    <title>菜单管理</title>
</head>
<frameset cols="250,*" border="1" frameborder="yes">
    <frame src="${ctx}/sys/toMenuManagerLeft" id="left" name="left">
    <frame src="${ctx}/sys/toMenuManagerRight" id="right" name="right">
</frameset>
</html>