<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GPS监控</title>
 <!-- 编码格式 -->
    <meta charset="UTF-8">
    <title>GPS导航</title>
    <!-- 作者 -->
    <meta name="author" content="author">
    <!-- 网页描述 -->
    <meta name="description" content="hello">
    <!-- 关键字使用","分隔 -->
    <meta name="keywords" content="a,b,c">
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
    <link rel="stylesheet" href="css/menagerCenter.css">
    <link rel="stylesheet" href="css/media.css">
    <link rel="stylesheet" href="css/color.css">

     <!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
<div class="container-fluit">
	<div class="row-fluit">
	<div id="mcMenu" class="visible-xs clearfix">
		<span class="glyphicon glyphicon-th-large fontMenu"></span>
	</div>
		<div class="col-lg-2 col-md-2 col-sm-3 col-xs-4 clearfix" id="mB1">
		      <div class="panel-group" id="managerParent">
                        <div class="panel">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#managerParent" href="#client">
                                        <span class="glyphicon glyphicon-chevron-down right"></span>客户管理
                                    </a>
                                </h4>
                            </div>
                            <div id="client" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <ul class="nav nav-pills nav-stacked">
                                        <li class="active"><a data-toggle="tab" href="#">添加客户</a></li>
                                        <li><a data-toggle="tab" href="#">查询客户</a></li>
                                        <li><a data-toggle="tab" href="#">停用客户</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="panel ">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#managerParent" 
                                    href="#verhical">
                                    <span class="glyphicon glyphicon-chevron-down right"></span>车辆管理
                                </a>
                            </h4>
                        </div>
                        <div id="verhical" class="panel-collapse collapse">
                            <div class="panel-body">
                             <ul class="nav nav-pills nav-stacked">
                                <li><a data-toggle="tab" href="#">添加车辆</a></li>
                                <li><a data-toggle="tab" href="#">查询车辆</a></li>
                                <li><a data-toggle="tab" href="#">停用车辆</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel ">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#managerParent" 
                            href="#group">
                            <span class="glyphicon glyphicon-chevron-down right"></span>分组管理
                        </a>
                    </h4>
                </div>
                <div id="group" class="panel-collapse collapse">
                    <div class="panel-body">
                     <ul class="nav nav-pills nav-stacked">
                        <li><a data-toggle="tab" href="#">添加分组</a></li>
                        <li><a data-toggle="tab" href="#">查询分组</a></li>
                        <li><a data-toggle="tab" href="#">停用分组</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
		</div>
	</div>
</div>
	<script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/menagerCenter.js"></script>
</body>
</html>