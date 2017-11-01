<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<!-- 编码格式 -->
<meta charset="UTF-8">
<title>GPS导航</title>
<!-- 作者 -->
<meta name="author" content="tsui">
<!-- 关键字使用","分隔 -->
<meta name="keywords" content="GPS,金圣达,位置">
<!-- 禁止浏览器从本地机的缓存中调阅页面内容 -->
<meta http-equiv="Pragma" content="no-cache">
<!-- 用来防止别人在框架里调用你的页面 -->
<meta http-equiv="Window-target" content="_top">
<!-- 网页不会被缓存 -->
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<!-- 解决部分兼容性问题，如果安装了GCF，则使用GCF来渲染页面，如果未安装GCF，则使用最高版本的IE内核进行渲染。 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- 页面按原比例显示 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/NewRmgps/web/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="/NewRmgps/web/css/addCustom.css">
<link rel="stylesheet" href="/NewRmgps/web/css/media.css">
<link rel="stylesheet" href="/NewRmgps/web/css/color.css">
<style>
label.checked {
color:green}
label.error{
color:red}
</style>
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<h4>添加客户:</h4>
			<form id="addCustomForm"  class="form-horizontal"
				role="form" method="post">
				<!-- 客户名字 -->
				<div class="form-group">
					<label for="customName"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户名称：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" name="name"
							id="customName" autocomplete="off" placeholder="请输入客户名称(3~6位)">
					</div>
				</div>
				<!-- 客户电话 -->
				<div class="form-group">
					<label for="customTel"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户电话(选填)：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" name="phone"
							id="customTel" placeholder="请输入客户电话">
					</div>
				</div>
				<!-- 客户地址 -->
				<div class="form-group">
					<label for="customAdd"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户地址(选填)：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" id="customAdd"
							name="address" placeholder="请输入客户地址">
					</div>
				</div>
				<!-- 提交按钮 -->
				<div class="form-group">
					<div class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
						<input type="submit" class="btn btn-info" value="添加" /> <input
							type="reset" class="btn btn-danger reset" />
					</div>
				</div>
			</form>
		</div>
	</div>
	<script src="/NewRmgps/web/js/jquery.min.js"></script>
	<script src="/NewRmgps/web/js/bootstrap.min.js"></script>
	<!-- <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/jquery.validate.js"></script> -->
	<script src="/NewRmgps/web/js/jquery.validate.js"></script>
	<script src="/NewRmgps/web/js/messages_zh.js"></script>
	<script src="/NewRmgps/web/js/jquery.form.js"></script>
	<script>
		$(function() {
			console.log("ss")
			//表单验证
			jQuery.support.cors=true;
			$("#addCustomForm").validate({
				errorClass:"error",
				onkeyup:false,
				errorElement:"label",
				rules:{
					name:{
						required:true,
						rangelength:[3,16],
						//远程验证
						remote:{
							url :"/NewRmgps/Customer/checkCustomer", 
							type:"post",
							cache:false,
							dataType:"text",
							data:{
								name:function() {
									return $("#customName").val();
								}
							}
						}
					},
					phone:{
						
						rangelength:[11,11],
						digits:true
					}
				},
				messages:{
					name:{
						remote:"该客户名已被注册"
					},
					phone:{
						
						rangelength:"请输入11位数字",
						digits:"只能输入数字"
					}
				},
				submitHandler:function(){
					if(confirm("是否添加客户\r\r"+$("#customName").val()+"?")){
						$("#addCustomForm").ajaxSubmit({
							url:"/NewRmgps/Customer/addCustomer",
							data:{"aa":"dd"},
							async:"false",
							success:function(data){
								
								//不太合理,添加成功后应该返回当前页面,还应该显示客户的信息,电话号码没有验证
								alert(data);
								$("#addCustomForm .reset").trigger("click");
							},
							error:function(e){
								console.log(e);
							}
						});
					}
					
					return false;
				},
				success: function(label){
				    label.html("<span style='color:green;font-size:12px;'>验证通过</span>");
				}
			});
			$("input:reset").click(function(){
				$("label.error").remove();
			})
		})
	</script>
</body>
</html>