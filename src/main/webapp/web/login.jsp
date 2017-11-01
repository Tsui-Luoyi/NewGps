<%@ page language="java" import="java.util.*,javax.servlet.*"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;">
<!-- 编码格式 -->
<meta charset="UTF-8">
<title>GPS导航</title>
<!-- 作者 -->
<meta name="author" content="Tsui">
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
<title>登录页面</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="shortcut icon" href="imgs/5.ico" type="image/x-icon" />
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/color.css">
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/media.css">
<!--[if lt IE 9]>
       		<script src="js/HTML5Shiv.min.js"></script>
       		<script src="js/response.js"></script>
       		<![endif]-->
       		
<!-- 触发JS刷新-->
<%
	String idError = (String)request.getAttribute("idError");
	String Token = (String)request.getAttribute("Token");
	String kong = (String)request.getAttribute("kong");
	%>
<script type="text/javascript">
    function changeImg(){
        var img = document.getElementById("img"); 
        img.src = "<%=request.getContextPath() %>/AuthImage?date=" + new Date();
        var checkNum = document.getElementById("checkNum");
        /* var s=<%=session.getAttribute("checkImg") %>;
        checkNum.text=s;
        */
    }
    
    function login(){
    	return true;
    }
</script>
       		
</head>
<body>
	<!-- 标题 -->
	<div class="login container-fluid">
		<div class="row bg-blue">
			<h2 class="text-center">
				<em>GPS信息登录</em>
			</h2>
		</div>
		<!-- 左边图片 -->
		<div class="row loginBg">
			<div
				class="col-lg-6 col-lg-push-1 col-md-push-1 col-sm-push-1 col-md-6 col-sm-6 col-xs-12">
				<img src="imgs/login-img.png" class="img-responsive bgImg" alt="">
			</div>
			<!-- 右边表单 -->
			<div
				class="col-lg-4 col-lg-push-1 col-md-push-1 col-sm-push-1 col-md-4 col-sm-4 col-xs-12">
				<form id="loginForm" action="/NewRmgps/User/login" class="form-horizontal"
			method="post"		role="form" onsubmit="javascript:return login();">
					<div class="form-group userName">
						<label for="userName"
							class="col-sm-3 col-xs-3 control-label text-right">用户名：</label>
						<div class="col-sm-9 col-xs-9">
							<input type="text" class="form-control" id="userName"
							name="userCode"	placeholder="请输入用户名">
						</div>
					</div>
					<div class="form-group pwd">
						<label for="pwd"
							class="col-sm-3 col-xs-3 control-label text-right">密码：</label>
						<div class="col-sm-9 col-xs-9">
							<input type="password" class="form-control" id="pwd"
								placeholder="请输入密码">
						</div>
					</div>
					<div class="form-group checkNum">
						<label for="check-num"
							class="col-sm-3 col-xs-3 control-label text-right">验证码:</label>
						<div class="col-sm-4 col-xs-4 checkNumDiv">
							<input type="text" class="form-control" id="checkNum" 
								placeholder="请输入验证码">
						</div>
						<div class="col-sm-4 col-xs-4 checkRefreshDiv">
							<div class="row">
								<div class="col-xs-9" id="inputCheckNum"><img id="img"
															src="<%=request.getContextPath() %>/AuthImage"
															onclick="javascript:changeImg()" /></div>
								<div class="col-xs-3" id="refreshBtn">
									<a href="#" onclick="javascript:changeImg()"><span class="glyphicon glyphicon-refresh"></span></a>
								</div>
							</div>
						</div>
					</div>
				<%-- 	<div class="form-group pwd">
						<label for="pwd"
							class="col-sm-3 col-xs-3 control-label text-right">密码：</label>
						<div class="col-sm-9 col-xs-9">
												<% if (idError == null && Token == null && kong == null) {%> <span
												id="logining_info" class='ErrorMsg'></span> <%} else if(Token != null && idError == null && kong == null){ %>
												<span id="logining_info" class='ErrorMsg'><%=Token %></span>
												<%}else if(Token == null && idError == null && kong != null) {%>
												<span id="logining_info" class='ErrorMsg'><%=kong %></span>
												<%}else if(Token == null && idError != null && kong ==null) {%>
												<span id="logining_info" class='ErrorMsg'><%=idError %></span>
												<%}%>
						</div>
					</div>	 --%>				
					<div class="form-group">
						<div
							class="col-md-offset-4 col-sm-offset-3 col-xs-offset-3 col-md-4 col-sm-5 col-xs-3 rememberMe">
							<div class="checkbox">
								<label> <input type="checkbox">请记住我
								</label>
							</div>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-3" id="findPassword">
							<a href="#">忘记密码？</a>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary btn-block" value="登录" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="loginFooter">
		<%-- <jsp:include page="headerFooter/footer.jsp" flush="true" /> --%>
		<footer class="container-fluid">
			<div class="row-fluid text-center">
				<p>&copy;北京金圣达电气信息技术有限公司</p>
				<p class="beginTime hidden-xs">2006-2017</p>
			</div>
		</footer>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/login.js"></script>
</body>
</html>