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
<link rel="stylesheet" href="css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
<style>
html, body {
	height: 100%;
	width: 100%;
}

h4 {
	font-weight: bold;
}
#notice{
margin:20px 0 10px 0;}
#notice strong, #noticeOl strong{
	color:red;
	font-weight:bolder;
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
			<h4>批量导入车辆:</h4>
			<div class="row ">
			<div class="col-lg-push-3 col-md-push-3 col-sm-push-3 col-lg-9 col-md-9 col-sm-9 col-xs-12">
				<input type='file' accept=”application/msexcel”/>
			</div>
			<div class="col-lg-push-3 col-md-push-3 col-sm-push-3 col-lg-9 col-md-9 col-sm-9 col-xs-12">
				<div  id="notice"><strong>※※※注意※※※</strong></div>
				<ol id="noticeOl">
					<li>当车辆太多不方便一一添加时，本网站提供了批量导入的功能；</li>
					<li>导入的文件是EXCEL表格文件，后缀名为<strong>.xlsx</strong>，并且里面的数据要遵循一定的格式，否则导入失败；</li>
					<li>可按照提供的模板添加车辆信息，<a class="right" href="data/verhicleModels.xlsx">点击下载模板</a>；</li>
					<li>如果导入失败，请查看失败原因，如果不是文件问题，请重新导入。</li>
				</ol>
			</div>
			
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>