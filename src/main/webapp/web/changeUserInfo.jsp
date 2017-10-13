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
    <link rel="stylesheet" href="css/media.css">
    <link rel="stylesheet" href="css/color.css">
     <!-- <link rel="stylesheet" href="css/footer.css"> -->
     <!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
<div class="container-fluid">
		<div class="row-fluid">
			<h4>资料修改:</h4>
			<form id="changeUserInfo" action="#" class="form-horizontal"
				role="form" method="post" onsubmit="return postData1()">
				<!-- 原密码输入 -->
				<div class="form-group">
					<label for="oldPwd"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">输入原密码：</label>
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-8 text-left">
						<input type="text" class="form-control" id="oldPwd"
							placeholder="请输入原密码">
					</div>
				</div>
				<!-- 新密码输入 -->
				<div class="form-group">
					<label for="newPwd"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">输入新密码：</label>
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-8 text-left">
						<input type="text" class="form-control" id="newPwd"
							placeholder="请输入新密码">
					</div>
				</div>
				<!-- 再次新密码输入 -->
				<div class="form-group">
					<label for="newPwd1"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">输入原密码：</label>
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-8 text-left">
						<input type="text" class="form-control" id="newPwd1"
							placeholder="请再次输入新密码">
					</div>
				</div>
			
				<!-- 提交按钮 -->
				<div class="form-group">
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
						<input type="submit" class="btn btn-info" value="添加" /> <input
							type="reset" class="btn btn-danger reset" />
					</div>
				</div>
			</form>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>