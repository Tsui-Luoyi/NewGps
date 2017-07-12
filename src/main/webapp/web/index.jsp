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
<meta name="author" content="Tsui">
<!-- 网页描述 -->
<meta name="description" content="北京金圣达电气有限公司官网">
<!-- 关键字使用","分隔 -->
<meta name="keywords" content="GPS,金圣达,位置,首页">
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
<link rel="shortcut icon" href="imgs/5.ico" type="image/x-icon" />
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/color.css">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/media.css">
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<!--头部  -->
	<!-- 标题 -->
	<header class="container-fluid" style="padding: 0">
		<div class="navbar navbar-default bg-blue navPos" role="navigation">
			<div class="navbar-header">
				<!-- 小屏幕三个横线 -->
				<button type="button" id="navButton" class="navbar-toggle in"
					data-toggle="collapse" data-target="#navMenu"
					data-collapsing="false">
					<span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<!-- logo -->
				<a class="navbar-brand logo" href="#"><img src="imgs/jsd_50.png"
					class="img-responsive" alt="logo"></a>
			</div>
			<div class="pull-left" id="comName">
				<h1 class="hidden-sm hidden-xs ">金圣达电气信息技术有限公司</h1>
			</div>
			<!-- 登录用户管理 -->
			<div class="btn-group loginOut">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"><strong
						class="hidden-sm hidden-xs">登录用户:</strong></i> <span>
						admin24242424242</span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="#">修改资料</a></li>
					<li class="divider"></li>
					<li><a href="login.jsp">退出</a></li>
				</ul>
			</div>
			<!-- <div class=" pull-right hidden-xs" id="time">时间：2017.6.20 15:59:05</div> -->
			<!-- 导航内容 -->
			<div class="collapse navbar-collapse pull-right" id="navMenu">
				<ul class="nav nav-pills">
					<li class="active"><a
						onClick="changeIframe('#mainIframe','menagerCenter.jsp')"
						href="javascript:void(0);">管理中心</a></li>
					<li><a
						onClick="changeIframe('#mainIframe','positionCenter.jsp')"
						href="javascript:void(0);">位置监测</a></li>
					<li><a
						onClick="changeIframe('#mainIframe','statisticalTable.jsp')"
						href="javascript:void(0);">统计报表</a></li>
					<li><a
						onClick="changeIframe('#mainIframe','systemCenter.jsp')"
						href="javascript:void(0);">系统管理</a></li>
				</ul>
			</div>
		</div>
	</header> 
	<!--中間部分  -->
	<div class="outerIframeContainer">
		<iframe id="mainIframe" src="menagerCenter.jsp" frameborder="0"
			scrolling="yes" style="width: 100%; height: 100%">浏览器不支持，请升级或更换浏览器</iframe>
	</div>
	<!--底部  -->
	<footer class="container-fluid" id="indexFooter">
		<div class="row-fluid text-center">
			<p>&copy;北京金圣达电气信息技术有限公司</p>
			<p class="beginTime hidden-xs">2006-2017</p>
		</div>
	</footer>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- <script src="js/header.js"></script> -->
	<!--写在index.js了-->
	<script src="js/index.js"></script>
</body>
</html>