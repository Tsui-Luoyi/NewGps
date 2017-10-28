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
<link rel="stylesheet" href="/NewRmgps/web/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet" href="/NewRmgps/web/css/media.css">
<link rel="stylesheet" href="/NewRmgps/web/css/color.css">
<style>
html, body {
	height: 100%;
	width: 100%;
}
/*  标题tab*/
.verhicleTab {
	list-style: none;
	float: left;
	padding: 0 20px;
	margin-left: 10px;
	border-bottom: 1px #000 solid
}

.verhicleTab>li {
	display: inline-block;
	padding: 5px 10px;
	background-color: #79acdf;
	border: 1px #000 solid;
	border-radius: 5px 5px 0 0;
	border-bottom: 0;
	color: #fff;
	font-weight: 700
}

.verhicleTab li.active {
	background-color: #fff;
	color: #000;
}

.row-fluid h4 {
	font-weight: bold;
	margin-top: 10px;
	margin-bottom: 10px;
	font-size: 18px;
}

.form-group .control-label {
	height: 34px;
	line-height: 34px;
	padding: 0;
}

input.reset {
	margin-left: 30px;
}
/* 错误提示 */
.error {
	color: red;
	font-size: 12px;
	width: 50%;
}

.form-control {
	display: inline-block;
	width: 50%;
}

.ztree li span.button.all_ico_open {
	background-image: url("/NewRmgps/web/images/all-2.png")
}

.ztree li span.button.all_ico_close {
	background-image: url("/NewRmgps/web/images/all-1.png")
}

.ztree li span.button.group_ico_docu {
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/group.png")
}
/* 分组外面div */
.groupDiv {
	max-height: 400px;
	min-height: 100px;
	overflow-y: scroll;
}
/* 添加分组 */
#addGroup {
	position: absolute;
	font-weight: bold;
	margin-left: 50%;
	z-index: 10;
	top: 125px;
}
/* 蒙版 */
.mengban {
	position: absolute;
	z-index: 20;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #000;
	opacity: 0.7;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=70);
	display: none;
}
/*  添加分组表单*/
#addGup {
	position: absolute;
	z-index: 21;
	display: none;
	top: 50%;
	left: 50%;
	margin-left: -300px;
	margin-top: -200px;
	background-color: #dedede;
	border: 1px #000 solid;
	width: 600px;
	height: 400px;
	opacity: 1.85;
}

#addGroupForm .form-control {
	display: inline-block;
	width: 50%;
}

.ztree li span.button.all_ico_open {
	background-image: url("/NewRmgps/web/images/all-2.png")
}

.ztree li span.button.all_ico_close {
	background-image: url("/NewRmgps/web/images/all-1.png")
}

.ztree li span.button.group_ico_docu {
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/group.png")
}
/* 分组外面div */
#addGup .groupDiv {
	max-height: 200px;
	min-height: 100px;
	overflow-y: scroll;
}
/*  关闭按钮*/
h4 span {
	cursor: pointer;
	display: block;
	height: 20px;
	line-height: 20px;
	width: 20px;
	text-align: center;
	border: 1px #000 solid;
	border-radius: 50%;
	float: right;
	margin-right: 20px;
}

hr {
	margin: 5px 0;
	border: 1px #000 solid;
}
/*  外面包括层*/
#tabWrap {
	margin: 0;
}

#tabWrap form {
	margin-top: 10px;
}
/*  车辆详细信息*/
#verhicleDetail {
	position: relative;
	/* display: none; */
}

#verhicleDetail .form-control {
	display: inline-block;
	width: 100%;
}
/*  车辆颜色复选框*/
#verhicleColorContainer, #verhicleType2Container {
	width: 100%;
	height: 34px;
}

#verhicleColor, #verhicleType2 {
	width: 100%;
	height: 34px;
}
/* 车辆图片上传 */
#imgUpload, #imgUpload1 {
	position: absolute;
	left: 67%;
	width: 200px;
	height: 350px;
	top: 20px;
	z-index: 999;
}
/* 车主信息 */
#verhicleOwener {
	position: relative;
	display: none;
}
/* 添加车辆基本信息 */
#verhicleInfo {
	/* display: none;  */
	
}
/*  上传处理*/
.layui-btn {
	display: inline-block;
	height: 30px;
	line-height: 30px;
	padding: 0 12px;
	background-color: #589fdc;
	color: #fff;
	white-space: nowrap;
	text-align: center;
	font-size: 14px;
	border: none;
	border-radius: 2px;
	cursor: pointer;
	outline: 0;
	-webkit-appearance: none;
	transition: all .3s;
	-webkit-transition: all .3s;
	box-sizing: border-box;
	verhical-align: middle;
}

.layui-upload-file {
	display: none !important;
	opacity: .01;
}

#verhicleImg, #verhicleUserImg {
	width: 150px;
	height: 150px;
}

.layui-layer-dialog {
	position: absolute;
	background-color: #eeeeee;
	color: red;
	top: 50%
}
/*  图片上传重试*/
#alertText, #alertText1 {
	margin-top: 5px;
	margin-bottom: 10px;
}
/*  车主信息设置*/
#verhicleOwener .form-control {
	display: inline-block;
	width: 100%;
}
</style>
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<!-- 添加分组时的蒙版 -->
	<!-- <div class="mengban"></div>
	<div id="addGup">
		<div class="container-fluid">
			<div class="row-fluid">
				<h4>
					添加分组:<span title="关闭">&times;</span>
				</h4>
				<hr />
				<form id="addGroupForm" action="/NewRmgps/Group/addGroup"
					class="form-horizontal" role="form" method="post">
					分组名字
					<div class="form-group">
						<label for="groupName"
							class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">分组名称：</label>
						<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
							<input type="text" class="form-control" name="name"
								id="groupName" placeholder="请输入分组名称(2~10位)">
						</div>
					</div>
					选择监控员
					<div class="form-group">
						<label for="customAdd"
							class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">选择监控员：</label>
						<div
							class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left groupDiv">
							<ul id="userTree" class="ztree"></ul>
						</div>
					</div>
					提交按钮
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
	</div> -->

	<div class="container-fluid">
		<div class="row-fluid">
			<h4>修改车辆:</h4>
			<div class="row">
				<ul class="verhicleTab">
					<!-- <li class="active">基本信息</li> -->
					<li>车辆详细信息</li>
					<!-- <li>车主信息</li> -->
				</ul>
			</div>
			<!-- 3个tab的包裹层 -->
			<div class="row" id="tabWrap">
				<!-- <div id="verhicleInfo">
					<p id="addGroup">
						没合适的分组？
						<button>添加分组</button>
					</p>
					<form id="addVerhicleForm" action="/NewRmgps/Vehicle/addVehicle"
						class="form-horizontal" role="form" method="post">
						车牌号
						<div class="form-group">
							<label for="verhicleNum"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">车牌号：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<input type="text" class="form-control" name="licensePlate"
									id="verhicleNum" placeholder="请输入车牌号(2~10位)">
							</div>
						</div>
						分组
						<div class="form-group">
							<label for="customAdd"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">选择分组：</label>
							<div
								class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left groupDiv">
								<ul id="groupTree" class="ztree"></ul>
							</div>
						</div>
						提交按钮
						<div class="form-group">
							<div
								class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
								<input type="submit" class="btn btn-info" value="添加" /> <input
									type="reset" class="btn btn-danger reset" />
							</div>
						</div>
					</form>
				</div> -->
				<!--  车辆详细信息-->
				<div id="verhicleDetail">
					<form id="addVerhicleDetailForm"
						action="/NewRmgps/Vehicle/UpdateVehicleDetail" class="form-horizontal"
						role="form" method="post">
						<!-- 车牌号 -->
						<div class="form-group">
							<label for="verhicleNum2"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车牌号：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="licensePlate"
									id="verhicleNum2" disabled="disabled" />
							</div>
						</div>
						<!-- 车辆名称 -->
						<div class="form-group">
							<label for="verhicleName"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车辆名称（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="name"
									id="verhicleName" placeholder="请输入车辆名称" />
							</div>
						</div>
						<!-- 车辆型号 -->
						<!-- <div class="form-group">
							<label for="verhicleType"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车辆型号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="verhicleType"
									id="verhicleType" placeholder="请输入车辆型号" />
							</div>
						</div> --> 
						<!-- 厂牌号码 -->
						<div class="form-group">
							<label for="verhicleBrand"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">厂牌号码（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="vehbrand"
									id="verhicleType" placeholder="请输入厂牌号码" />
							</div>
						</div>
						<!-- 生产厂家 -->
						<div class="form-group">
							<label for="verhicleProducter"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">生产厂家（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="producter"
									id="verhicleProducter" placeholder="请输入生产厂家" />
							</div>
						</div>
						<!-- 车辆颜色 -->
						<div class="form-group">
							<label for="verhicleColor"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车辆颜色（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<div id="verhicleColorContainer">
									<select name="color" id="verhicleColor">
										<option value="" selected="selected">请选择车辆颜色</option>
										<option value="white">白色</option>
										<option value="black">黑色</option>
										<option value="yellow">黄色</option>
										<option value="red">红色</option>
										<option value="blue">蓝色</option>
										<option value="green">绿色</option>
										<option value="orange">橙色</option>
										<option value="pink">粉色</option>
										<option value="purple">紫色</option>
										<option value="silveryWhite">银白色</option>
										<option value="else">其它</option>
									</select>
								</div>
							</div>
						</div>
						<!-- 车辆类型 -->
					<!-- 	<div class="form-group">
							<label for="verhicleType2"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车辆颜色（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<div id="verhicleType2Container">
									<select name="verhicleType2" id="verhicleType2">
										<option value="" selected="selected">请选择车辆类型</option>
										<option value="white">轿车</option>
										<option value="pink">出租车</option>
										<option value="black">越野车</option>
										<option value="yellow">大型客车</option>
										<option value="red">中型客车</option>
										<option value="blue">小型客车</option>
										<option value="green">工程机械</option>
										<option value="orange">摩托车</option>
										<option value="pink">搅拌车</option>
										<option value="purple">罐装车</option>
										<option value="silveryWhite">运钞车</option>
										<option value="else">其它</option>
									</select>
								</div>
							</div>
						</div> -->
						<!-- 发动机号 -->
						<div class="form-group">
							<label for="verhicleEngineCode"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">发动机号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control"
									name="enginecode" id="verhicleEngineCode"
									placeholder="请输入发动机号" />
							</div>
						</div>
						<!-- 车辆详细信息提交 -->
						<div class="form-group">
							<div
								class="col-lg-push-3 col-md-push-3 col-sm-push-3 col-xs-push-2 col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
								<input type="button" class="btn btn-info" value="提交" />
							</div>
						</div>
						<!-- 上传车辆图片 -->
						<!-- <div id="imgUpload">
							<div class="layui-upload">
								<div class="layui-upload-list verhicleImg">
									<img class="layui-upload-img" id="verhicleImg"
										src="/NewRmgps/web/images/verhicleImg.png">
									<p id="alertText"></p>
								</div>
								<button type="button" class="layui-btn" id="imgUp">上传车辆图片</button>
								<div class="layui-upload-list verhicleImg">
									<img class="layui-upload-img" id="verhicleImg">
									<p id="demoText"></p>
								</div>
							</div>
						</div> -->
						<!-- 提交按钮 -->
					</form>
				</div>
				<!-- 车主详细信息 -->
				<!-- <div id="verhicleOwener">
					<form id="addVerhicleUserForm" action="/NewRmgps/Vehicle/addDriver"
						class="form-horizontal" role="form" method="post">
						车主姓名
						<div class="form-group">
							<label for="verhicleUserName"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主姓名（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="name"
									id="verhicleUserName" placeholder="请输入车主姓名" />
							</div>
						</div>
						车主手机
						<div class="form-group">
							<label for="verhicleUserPhone"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主手机号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="phone"
									id="verhicleUserPhone" placeholder="请输入车主手机号" />
							</div>
						</div>
						车主座机
						<div class="form-group">
							<label for="verhicleUserTel"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主座机号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="tel"
									id="verhicleUserTel" placeholder="请输入车主座机号" />
							</div>
						</div>
						车主身份证号
						<div class="form-group">
							<label for="verhicleUserID"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主身份证号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="idcard"
									id="verhicleUserID" placeholder="车主身份证号" />
							</div>
						</div>
						驾驶证日期
						<div class="form-group">
							<label for="driveLicenseDate"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">领证日期（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="certifdate"
									id="driveLicenseDate" />
							</div>
						</div>
						驾驶证号
						<div class="form-group">
							<label for="driveLicenseNum"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">驾驶证号：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="yDriveNum"
									id="driveLicenseNum" />
							</div>
						</div>

						准驾类型
						<div class="form-group">
							<label for="driveType"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">准驾类型：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<div id="verhicleType2Container">
									<select name="yDriveType" id="verhicleType2">
										<option value="" selected="selected">请选择准驾类型</option>
										<option value="white">A1</option>
										<option value="pink">A2</option>
										<option value="black">A3</option>
										<option value="yellow">B1</option>
										<option value="red">B2</option>
										<option value="blue">C1</option>
										<option value="green">C2</option>
										<option value="orange">C3</option>
										<option value="pink">C4</option>
										<option value="purple">D</option>
										<option value="silveryWhite">E</option>
										<option value="purple">F</option>
										<option value="silveryWhite">M</option>
										<option value="purple">N</option>
										<option value="silveryWhite">P</option>
									</select>
								</div>
							</div>
						</div>
						上传车主图片
						<div id="imgUpload1">
							<div class="layui-upload">
								<div class="layui-upload-list verhicleUserImg">
									<img class="layui-upload-img" id="verhicleUserImg"
										src="/NewRmgps/web/images/verhicleOwener.png">
									<p id="alertText1"></p>
								</div>
								<button type="button" class="layui-btn" id="imgUserUp">上传车主图片</button>
							</div>
						</div>
						车主信息提交按钮
							<div class="form-group">
							<div
								class="col-lg-push-3 col-md-push-3 col-sm-push-3 col-xs-push-2 col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
								<input type="button" class="btn btn-info" value="提交" />
							</div>
						</div>
					</form>
				</div> -->
			</div>
		</div>
	</div>
	<script src="/NewRmgps/web/js/jquery.min.js"></script>
	<script src="/NewRmgps/web/js/bootstrap.min.js"></script>
	<!-- <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/jquery.validate.js"></script> -->
	<script src="/NewRmgps/web/js/jquery.validate.js"></script>
	<script src="/NewRmgps/web/js/jquery.ztree.all.js"></script>
	<script src="/NewRmgps/web/js/messages_zh.js"></script>
	<script src="/NewRmgps/web/js/jquery.form.js"></script>
	<script src="/NewRmgps/web/js/uploader.js"></script>
	<script src="/NewRmgps/web/js/jedate/jedate.min.js"></script>
	<script>
		$(function(){
			jQuery.support.cors=true;
			function getQueryString(name) { 
				var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
				var r = window.location.search.substr(1).match(reg); 
				if (r != null) return decodeURI(r[2]); 
				return null; 
				}
					var license_plate=getQueryString("license_plate");
					console.log(license_plate)
			/*  车辆详细信息操作*/
				$("#verhicleNum2").val(license_plate);
				$("#addVerhicleDetailForm input:button").unbind("click").bind("click",function(){
					$("#addVerhicleDetailForm").ajaxSubmit({
					type:'post',
					data:{
						"licensePlate":$("#verhicleNum2").val()
					},
					success:function(){
						alert("修改车辆信息成功！");
					},
					error:function(e){
						console.log(e)
					}
					})
				})
		})
	</script>
</body>
</html>