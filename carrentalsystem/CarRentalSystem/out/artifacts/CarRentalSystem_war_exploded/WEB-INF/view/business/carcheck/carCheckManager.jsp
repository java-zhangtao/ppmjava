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
                <label class="layui-form-label">出租单号</label>
                <div class="layui-input-inline">
                   <input type="text" class="layui-input" id="search_rentid" name="rentid"/>
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
<%--检查单 开始--%>
<div id="checkCarDiv" style="display: none;">
    <blockquote class="layui-elem-quote">
    <h2>检查单</h2>
        <hr/>
    <form action="" method="post" id="rentForm" class="layui-form layui-form-pane" lay-filter="rentForm">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">出租单号</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input" name="rentid" readonly="readonly"  id="jc_rentid"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">检查单号</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input" name="checkid" readonly="readonly"  id="jc_checkid"/>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">检查时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="checkdate" id="checkdate" readonly="readonly" lay-verify="required"  class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">赔偿金额</label>
                <div class="layui-input-inline">
                    <input type="text" name="paymoney" lay-verify="required|number" autocomplete="off" placeholder="请输入赔偿金额" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">存在问题</label>
                <div class="layui-input-block">
                    <input type="text" name="problem"  placeholder="请输入存在的问题" class="layui-input">
                </div>
            </div>
            <div class="layui-block">
                <label class="layui-form-label">问题描述</label>
                <div class="layui-input-block">
                    <textarea class="layui-textarea" name="checkdesc"></textarea>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">操作员</label>
                <div class="layui-input-block">
                    <input type="text" name="opername"  id="jc_opername"  readonly="readonly" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: center">
                <button type="button" class="layui-btn layui-btn-normal"  lay-submit="" lay-filter="doSubmit"><span class="layui-icon layui-icon-release"></span>保存</button>
                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
    </blockquote>
</div>
<%--检查单 结束--%>
<div id="infoDiv" style="padding: 10px; background-color: #F2F2F2;display: none">
    <div class="layui-row layui-col-space8" >
        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">汽车信息</div>
                <div class="layui-card-body" id="carnumber"></div>
                <div class="layui-card-body" id="cartype"></div>
                <div class="layui-card-body" id="price"></div>
                <div class="layui-card-body" id="color"></div>
                <div class="layui-card-body" id="rentprice"></div>
                <div class="layui-card-body" id="description"></div>
                <div class="layui-card-body" id="isrenting"></div>
                <div class="layui-card-body" id="deposit"></div>
                <div class="layui-card-body">
                    车辆的图片：<img id="carimg" width="200px" height="100px"/>
                </div>
            </div>
        </div>
        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">出账单信息</div>
                <div class="layui-card-body" id="rentid"></div>
                <div class="layui-card-body" id="car_price"></div>
                <div class="layui-card-body" id="begindate"></div>
                <div class="layui-card-body" id="returndate"></div>
                <div class="layui-card-body" id="opername"></div>
            </div>
        </div>
        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">客户信息</div>
                <div class="layui-card-body" id="identity"></div>
                <div class="layui-card-body" id="custname"></div>
                <div class="layui-card-body" id="sex"></div>
                <div class="layui-card-body" id="address"></div>
                <div class="layui-card-body" id="career"></div>
                <div class="layui-card-body" id="phone"></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','layer','laydate'],function () {
        var $=layui.jquery;
        var form=layui.form;
        var layer=layui.layer;
        var laydate=layui.laydate;
        laydate.render({
            elem: '#checkdate',
            type: 'datetime'
        });
        //判断出租单是否存在
        $('#doSearch').click(function () {
            var rentid = $('#search_rentid').val();
            $.post("${ctx}/check/checkRentExist",{rentid:rentid},function (res) {
                if(res!==''){
                    if(res.rentflag==0){
                        layer.msg("该出租单的车已归还，请重新输入");
                        // $("#dataForm")[0].reset();
                        $('#checkCarDiv').hide();
                        $('#infoDiv').hide();
                    }else{
                        initInfo(res.rentid);
                        $('#checkCarDiv').show();
                        $('#infoDiv').show();
                    }
                }else{
                    layer.msg("出租单号不存在，请重新输入");
                    // $("#dataForm")[0].reset();
                    $('#checkCarDiv').hide();
                    $('#infoDiv').hide();
                }
            })
        });
        //监听提交
        form.on("submit(doSubmit)",function (data) {
            var identity=$("#identity").val();
            $("#add_identity").val(identity);
            $.post("${ctx}/check/addCheckCar",data.field,function (res) {
                if(res.code==200){
                    $("#checkCarDiv").hide();
                    $('#infoDiv').hide();
                }
                layer.msg(res.msg);
            });
        });
        function initInfo(rentid) {
            $.post("${ctx}/check/loadAllInfoByRentId",{rentid:rentid},function(obj){
                var car=obj.car;
                var check=obj.check;
                var rent=obj.rent;
                var customer=obj.customer;
                //检查单赋值
                $("#jc_checkid").val(check.checkid);
                $("#jc_rentid").val(check.rentid);
                $("#checkdate").val(check.checkdate);
                $("#jc_opername").val(check.opername);
                //出租单信息赋值
                $("#rentid").html("出租单号："+rent.rentid);
                $("#begindate").html("开始时间："+rent.begindate);
                $("#returndate").html("归还时间："+rent.returndate);
                $("#opername").html("操作员："+rent.opername);
                //客户信息赋值
                $("#identity").html("身份证号："+customer.identity);
                $("#sex").html("性别："+(customer.sex==1?"男":"女"));
                $("#custname").html("客户姓名："+customer.custname);
                $("#phone").html("电话号码："+customer.phone);
                $("#address").html("客户地址："+customer.address);
                $("#career").html("客户职称："+customer.career);
                //汽车信息赋值
                $('#carnumber').html("汽车号牌："+car.carnumber);
                $('#cartype').html("汽车类型："+car.cartype);
                $('#price').html("购买价格："+car.price);
                $('#rentprice').html("出租价格："+car.rentprice);
                $('#color').html("汽车颜色："+car.color);
                $('#description').html("汽车描述："+car.description);
                $('#isrenting').html("是否出租："+(car.isrenting==0?'已出租':"未出租"));
                $('#carimg').attr("src","${ctx}/file/showImageByPath?path="+car.carimg)
                $('#deposit').html("出租押金："+car.cartype);
            });

        }
    })
</script>
</body>
</html>