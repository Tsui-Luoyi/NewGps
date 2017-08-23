<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<!-- 编码格式 -->
<meta charset="UTF-8">
<title>GPS导航</title>
<!-- 作者 -->
<meta name="author" content="author">
<!-- 关键字使用","分隔 -->
<meta name="keywords" content="GPS,金圣达,位置">
<!-- 禁止浏览器从本地机的缓存中调阅页面内容 -->
<meta http-equiv="Pragma" content="no-cache">
<!-- 用来防止别人在框架里调用你的页面 -->
<meta http-equiv="Window-target" content="_top">
<!-- content的参数有all，none，index，noindex，follow，nofollow，默认是all -->
<meta name="robots" content="none">
<!-- 网页不会被缓存 -->
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<!-- 解决部分兼容性问题，如果安装了GCF，则使用GCF来渲染页面，如果未安装GCF，则使用最高版本的IE内核进行渲染。 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- 页面按原比例显示 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/addCustom.css">
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
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
			<form id="addCustomForm" action="http://127.0.0.1/ceshi.php" class="form-horizontal"
				role="form" method="post">
				<!-- 客户名字 -->
				<div class="form-group">
					<label for="customName"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户名称：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" name="customName"
							id="customName" placeholder="请输入客户名称(3~6位)">
					</div>
				</div>
				<!-- 客户电话 -->
				<div class="form-group">
					<label for="customTel"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户电话(选填)：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" name="customTel"
							id="customTel" placeholder="请输入客户电话">
					</div>
				</div>
				<!-- 客户地址 -->
				<div class="form-group">
					<label for="customAdd"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户地址(选填)：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" id="customAdd"
							name="customAdd" placeholder="请输入客户地址">
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
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.js"></script>
	<script src="js/messages_zh.js"></script>
	<script src="js/jquery.form.js"></script>
	<script>
		$(function() {
			//表单验证
			$("#addCustomForm").validate({
				errorClass:"error",
				onkeyup:false,
				errorElement:"label",
				rules:{
					customName:{
						required:true,
						rangelength:[3,6],
						//远程验证
						remote:{
							url :"/logintest/Tclient/save",
							type:"post",
							dataType:"json",
							cache:false,
							data:{
								customName:function() {
									return $("#customName").val();
								}
							}
						}
					}
				},
				messages:{
					customName:{
						remote:"该客户名已被注册"
					}
				},
				submitHandler:function(){
					$("#addCustomForm").ajaxSubmit(function(){
						alert("添加成功!");
					});
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