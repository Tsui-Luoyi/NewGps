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
<link rel="stylesheet" href="css/menagerCenter.css">
<link rel="stylesheet" href="css/color.css">
<link rel="stylesheet" href="css/media.css">
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<div class="container-fluit">
		<div class="row-fluit">
			<div id="mcMenu" class="visible-xs">
				<span class="glyphicon glyphicon-th-large fontMenu"></span>
			</div>
			<div class="col-lg-2 col-md-3 col-sm-3 col-xs-4" id="mB1">
				<div class="panel-group" id="managerParent">
					<!-- 客户管理 -->
					<div class="panel">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#managerParent"
									href="#client"> <span
									class="glyphicon glyphicon-chevron-down right"></span>客户管理
								</a>
							</h4>
						</div>
						<div id="client" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-pills nav-stacked">
									<li class="active"><a
										onClick="changeIframe('#managerInnerIframe','/NewRmgps/Customer/toAddCustomer')"
										href="javascript:void(0);">添加客户</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','/NewRmgps/User/toAddCustomAdmin')"
										href="javascript:void(0);">为客户指定管理员</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','/NewRmgps/Customer/toFindCustomer')"
										href="javascript:void(0);">查询客户</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','stopCustom.jsp')"
										href="javascript:void(0);">重启已停用客户</a></li>
								</ul>
							</div>
						</div>
					</div>
					<!--监控员管理  -->
					<div class="panel ">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#managerParent"
									href="#user"> <span
									class="glyphicon glyphicon-chevron-down right"></span>监控员管理
								</a>
							</h4>
						</div>
						<div id="user" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-pills nav-stacked">
									<li><a
										onClick="changeIframe('#managerInnerIframe','/NewRmgps/User/toAddMonitor')"
										href="javascript:void(0);">添加监控员</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','/NewRmgps/User/toFindMonitor')"
										href="javascript:void(0);">查询监控员</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','stopUser.jsp')"
										href="javascript:void(0);">重启已停用监控员</a></li>
								</ul>
							</div>
						</div>
					</div>
					<!-- 分组管理 -->
					<div class="panel ">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#managerParent"
									href="#group"> <span
									class="glyphicon glyphicon-chevron-down right"></span>分组管理
								</a>
							</h4>
						</div>
						<div id="group" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-pills nav-stacked">
									<li><a
										onClick="changeIframe('#managerInnerIframe','addGroup.jsp')"
										href="javascript:void(0);">添加分组</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','findGroup.jsp')"
										href="javascript:void(0);">查询分组</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','stopGroup.jsp')"
										href="javascript:void(0);">停用分组</a></li>
								</ul>
							</div>
						</div>
					</div>
					<!-- 车辆管理 -->
					<div class="panel ">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#managerParent"
									href="#verhicle"> <span
									class="glyphicon glyphicon-chevron-down right"></span>车辆管理
								</a>
							</h4>
						</div>
						<div id="verhicle" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-pills nav-stacked">
									<li><a
										onClick="changeIframe('#managerInnerIframe','${pagecontext.request.getcontextpath}/Customer/toAddCustomer')"
										href="javascript:void(0);">添加车辆</a></li>
										<li><a
										onClick="changeIframe('#managerInnerIframe','importVerhicle.jsp')"
										href="javascript:void(0);">批量导入车辆</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','findVerhicle.jsp')"
										href="javascript:void(0);">查询车辆</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','moveVerhicle.jsp')"
										href="javascript:void(0);">移动车辆</a></li>
									<li><a
										onClick="changeIframe('#managerInnerIframe','stopVerhicle.jsp')"
										href="javascript:void(0);">停用车辆</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- <div id="midToggleBar"></div> -->
			<div class="col-lg-10 col-md-9 col-sm-9 col-xs-12"
				id="innerIframeContainer1">
				<div id="midToggleBar"></div>
				<iframe id="managerInnerIframe" name="managerInnerIframe" src="addCustom.jsp" frameborder="0"
					scrolling="yes" style="width: 100%; height: 100%">浏览器不支持，请升级或更换浏览器</iframe>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/menagerCenter.js"></script>
</body>
</html>