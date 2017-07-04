<%@ page language="java" import="java.util.*,javax.servlet.*"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
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
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/media.css">
    <link rel="stylesheet" href="css/color.css">
     <!-- <link rel="stylesheet" href="css/footer.css"> -->
     <!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
   </head>
   <body>
    <!-- 导航栏 -->
    <div class="navbar navbar-default bg-blue" role="navigation">
        <div class="navbar-header">
            <!-- 小屏幕三个横线 -->
            <button type="button" class="navbar-toggle" data-toggle="collapse"
            data-target="#example-navbar-collapse">
            <span class="sr-only">切换导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button> 
        <!-- logo -->
        <a class="navbar-brand logo" href="#"><img src="imgs/jsd_50.png" class="img-responsive"  alt="logo"></a> 
    </div> 

    
    <!-- 登录用户管理 -->
    <div class="btn-group navbar-right loginOut">
        <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
            <i class="glyphicon glyphicon-user"><strong class="hidden-sm hidden-xs">登录用户:</strong></i>
            <span> admin24242424242</span>
            <span class="caret"></span>
        </button>
        <ul class="dropdown-menu">
            <li><a href="#">修改资料</a></li>
            <li class="divider"></li>
            <li><a href="login.jsp">退出</a></li>
        </ul>
    </div>

    <div class=" pull-right hidden-xs" id="time">时间：2017.6.20 15:59:05</div>
    <!-- 导航内容 -->
    <div class="collapse navbar-collapse" id="example-navbar-collapse">
        <ul class="nav navbar-nav nav-pills nav-stacked navMainMenu">
            <li class="active"><a data-toggle="tab" href="#home">首页</a></li>
            <li><a data-toggle="tab" href="#agent">代理商查询</a></li>
            <li ><a data-toggle="tab" href="#vehicle">车辆查询</a></li>
        </ul>
    </div>
</div>
<div id="jieguo" style="background-color: lightgreen;"></div>
<!-- tab页面 -->
<div class="tab-content tab-pos">
    <div class="tab-pane fade in active" id="home">
        <p>登录信息：</p>

    </div>
    <div class="tab-pane fade" id="agent">
        <p>代理商</p>
    </div>
    <div class="tab-pane fade" id="vehicle">
        <p>车辆</p>
    </div>
</div>
<div class="footer">
	<!-- 引入底部 -->
<%-- <%@ include file="header-footer/footer.jsp" %> --%>
<jsp:include page="headerFooter/footer.jsp" flush="true" />
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
$(function(){
	/* $.ajax({
		url:"tt.json",
		type:"get",
		dataType:"json",
		success:function(data){
			$("#jieguo").html(JSON.stringify(data));
		},
		error:function(){
			alert("error");
		},
		async:true
		
	}) */
        $('.nav-mainmenu a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            var  tar=e.target.getAttribute("href");
            switch(tar){
            case "#home":
            	
            	break;
            case "#agent":
            	
            	break;
            case "#vehicle":
            	
            	break;
            default:
            	return;
            }
            /* var activeTab = $(e.target).text();
            var previousTab = $(e.relatedTarget).text();
            $("#jieguo").html(activeTab+" "+previousTab); */
        });
    })
</script>
</body>
</html>