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
<link href="/NewRmgps/web/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="/NewRmgps/web/css/combo.select.css">
<link rel="stylesheet" href="/NewRmgps/web/css/addCustomAdmin.css">
<link rel="stylesheet" href="/NewRmgps/web/css/media.css">
<link rel="stylesheet" href="/NewRmgps/web/css/color.css">
<style>
label.checked {
	color: green
}
label.error {
	color: red
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
			<h4>添加客户管理员:</h4>
			<form id="addCustomAdminForm" action="/NewRmgps/User/addCustomAdmin"
				class="form-horizontal" role="form" method="post">
				<!-- 客户名字 -->
				<div class="form-group">
					<label for="customSelectName"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">客户名字：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<div id="customSelectContainer">
							<select name="customerid"
								id="customSelectName">
								<option value="">-&nbsp;&nbsp;请选择客户名字&nbsp;&nbsp;-</option>
							</select>
						</div>
					</div>
				</div>
				<!-- 管理员名称 -->
				<div class="form-group">
					<label for="customAdminName"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">管理员昵称：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" id="customAdminName"
							name="userName" placeholder="请输入管理员名称(3~6)位">
					</div>
				</div>
				<!-- 客户管理员登录账号 -->
				<div class="form-group">
					<label for="customAdminLoginName"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">管理员账号：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" id="customAdminLoginName"
							name="userCode" placeholder="请输入登录账号(4-16位英文)">
					</div>
				</div>
				<!-- 客户管理员密码 -->
				<div class="form-group">
					<label for="customAdminLoginPwd"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">管理员密码：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="password" class="form-control" id="customAdminLoginPwd"
							name="userPassword" placeholder="请输入登录密码(6~16位)">
					</div>
				</div>
				<!-- 客户管理员密码确认 -->
				<div class="form-group">
					<label for="customAdminLoginPwd1"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">再次输入密码：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="password" class="form-control" id="customAdminLoginPwd1"
							name="customAdminLoginPwd1" placeholder="请再次输入登录密码">
					</div>
				</div>
				<!-- 提交按钮 -->
				<div class="form-group">
					<div
						class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
						<input type="submit" class="btn btn-info" value="添加" /> <input
							type="reset" class="btn btn-danger reset" />
					</div>
				</div>
			</form>
		</div>
	</div>
	<script src="/NewRmgps/web/js/jquery.min.js"></script>
	<script src="/NewRmgps/web/js/jquery.combo.select.js"></script>
	<script src="/NewRmgps/web/js/bootstrap.min.js"></script>
	<script src="/NewRmgps/web/js/jquery.validate.js"></script>
	<script src="/NewRmgps/web/js/messages_zh.js"></script>
	<script src="/NewRmgps/web/js/jquery.form.js"></script>
	<script>
		$(function(){
			$('#customSelectName').comboSelect();
			 $.ajax({
				url:"/NewRmgps/Customer/selecTcustomersByCAId",
				type:"get",
				cache:'true',
				dateType:"json",
				success:function(data){
					for(var i=0;i<data.length;i++){
						var opt=$("<option value='"+data[i].id+"'>"+data[i].customername+"</option>");
						$("#customSelectName").append(opt);
					}
					$('#customSelectName').comboSelect();
				},error:function(error){
					console.log(error)
				},
				async:false
			}) 
			//表单验证,表单验证的时候有一定的问题.
			$("#addCustomAdminForm").validate({
			errorClass:"error",
			onkeyup:false,
			errorElement:"label",
			rules:{
				id:{
			required:true
			},
			userCode :{
			required:true,
			rangelength:[4,16],
			isEnglish:true,
			remote:{
			url:"/NewRmgps/User/checkUserCode",
			type:"post",
			data:{
				"userCode":function(){
					return $("#customAdminLoginName").val();
				}
			}
			}
			},
			userPassword:{
			required:true,
			rangelength:[6,16],
			isEnglish:true
			},
			customAdminLoginPwd1:{
			required:true,
			rangelength:[6,16],
			equalTo:"#customAdminLoginPwd"
			}
			},
			messages:{
				id:{
				remote:"请选择一个客户"
			},
			userName:{
				remote:"用户名称已被注册"
			},
			userCode:{
				remote:"该登录账号已被注册"
			}
			},
			submitHandler:function(){
				$("#addCustomAdminForm").ajaxSubmit(function(){
					/*获取返回数据进行林场的判断,或者在做一个接口查询出没有管理员的用户前台默认添加用户类型  */
					alert("添加客户管理员成功!");
				});
				return false;
			},
			success:function(label){
				label.html("<span style='color:green;font-size:12px;line-height:25px'>验证通过</span>");
			}
			});
			$("input:reset").click(function(){
				$("label.error").remove();
			})
		})
	</script>
</body>
</html>