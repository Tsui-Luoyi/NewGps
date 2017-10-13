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
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<style>
html,body{
	height:100%;
	width:100%;
	background-color:#dedede;
}
h4{
	font-weight:bold;
}

.form-group .control-label{
	height:34px;
	line-height:34px;
	padding:0;
}
input.reset{
	margin-left:30px;
}
/* 错误提示 */
.error{
	color:red;
	font-size:12px;
	width:50%;
}
#changeGroupForm .form-control{
	display:inline-block;
	width:50%;
}
</style>
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<h4>修改分组:</h4>
			<form id="changeGroupForm" action="http://127.0.0.1/ceshi.php" class="form-horizontal"
				role="form" method="post">
				<!-- 分组名字 -->
				<div class="form-group">
					<label for="groupName"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">分组名称：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" name="groupName"
							id="groupName" placeholder="请输入分组名称(2~10位)">
					</div>
				</div>
				<!-- 客户地址 -->
				<!-- <div class="form-group">
					<label for="customAdd"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户地址(选填)：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" id="customAdd"
							name="customAdd" placeholder="请输入客户地址">
					</div>
				</div> -->
				<!-- 提交按钮 -->
				<div class="form-group">
					<div class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
						<input type="submit" class="btn btn-info" value="修改" /> 
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
			jQuery.support.cors=true;
			$("#changeGroupForm").validate({
				errorClass:"error",
				onkeyup:false,
				errorElement:"label",
				rules:{
					groupName:{
						required:true,
						rangelength:[2,10],
						//远程验证
						remote:{
							url :"http://127.0.0.1/ceshi.php",
							type:"post",
							dataType:"json",
							cache:false,
							data:{
								clientName:function() {
									return $("#groupName").val();
								}
							}
						}
					}
				},
				messages:{
					groupName:{
						remote:"分组名已存在"
					}
				},
				submitHandler:function(){
					$("#changeGroupForm").ajaxSubmit(function(){
						alert("修改分组成功!");
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