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
	display: none;
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
	<div class="mengban"></div>
	<div id="addGup">
		<div class="container-fluid">
			<div class="row-fluid">
				<h4>
					添加分组:<span title="关闭">&times;</span>
				</h4>
				<hr />
				<form id="addGroupForm" action="/NewRmgps/Group/addGroup"
					class="form-horizontal" role="form" method="post">
					<!-- 分组名字 -->
					<div class="form-group">
						<label for="groupName"
							class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">分组名称：</label>
						<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
							<input type="text" class="form-control" name="name"
								id="groupName" placeholder="请输入分组名称(2~10位)">
						</div>
					</div>
					<!--选择监控员 -->
					<div class="form-group">
						<label for="customAdd"
							class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">选择监控员：</label>
						<div
							class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left groupDiv">
							<ul id="userTree" class="ztree"></ul>
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
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<h4>添加车辆:</h4>
			<div class="row">
				<ul class="verhicleTab">
					<li class="active">基本信息</li>
					<li>车辆详细信息</li>
					<li>车主信息</li>
				</ul>
			</div>
			<!-- 3个tab的包裹层 -->
			<div class="row" id="tabWrap">
				<div id="verhicleInfo">
					<p id="addGroup">
						没合适的分组？
						<button>添加分组</button>
					</p>
					<form id="addVerhicleForm" action="/NewRmgps/Vehicle/addVehicle"
						class="form-horizontal" role="form" method="post">
						<!-- 车牌号 -->
						<div class="form-group">
							<label for="verhicleNum"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">车牌号：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<input type="text" class="form-control" name="licensePlate"
									id="verhicleNum" placeholder="请输入车牌号(2~10位)">
							</div>
						</div>
						<!-- 分组 -->
						<div class="form-group">
							<label for="customAdd"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">选择分组：</label>
							<div
								class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left groupDiv">
								<ul id="groupTree" class="ztree"></ul>
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
				<!--  车辆详细信息-->
				<div id="verhicleDetail">
					<form id="addVerhicleDetailForm"
						action="/NewRmgps/Vehicle/addVehicleDetail" class="form-horizontal"
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
				<div id="verhicleOwener">
					<form id="addVerhicleUserForm" action="/NewRmgps/Vehicle/addDriver"
						class="form-horizontal" role="form" method="post">
						<!-- 车主姓名 -->
						<div class="form-group">
							<label for="verhicleUserName"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主姓名（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="name"
									id="verhicleUserName" placeholder="请输入车主姓名" />
							</div>
						</div>
						<!-- 车主手机 -->
						<div class="form-group">
							<label for="verhicleUserPhone"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主手机号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="phone"
									id="verhicleUserPhone" placeholder="请输入车主手机号" />
							</div>
						</div>
						<!-- 车主座机 -->
						<div class="form-group">
							<label for="verhicleUserTel"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主座机号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="tel"
									id="verhicleUserTel" placeholder="请输入车主座机号" />
							</div>
						</div>
						<!-- 车主身份证号-->
						<div class="form-group">
							<label for="verhicleUserID"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">车主身份证号（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="idcard"
									id="verhicleUserID" placeholder="车主身份证号" />
							</div>
						</div>
						<!-- 驾驶证日期 -->
				<!-- 		<div class="form-group">
							<label for="driveLicenseDate"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">领证日期（选填）：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="certifdate"
									id="driveLicenseDate" />
							</div>
						</div> -->
						<!-- 驾驶证号 -->
						<div class="form-group">
							<label for="driveLicenseNum"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label text-right">驾驶证号：</label>
							<div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 text-left">
								<input type="text" class="form-control" name="yDriveNum"
									id="driveLicenseNum" />
							</div>
						</div>

						<!-- 准驾类型 -->
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
						<!-- 上传车主图片 -->
						<!-- <div id="imgUpload1">
							<div class="layui-upload">
								<div class="layui-upload-list verhicleUserImg">
									<img class="layui-upload-img" id="verhicleUserImg"
										src="/NewRmgps/web/images/verhicleOwener.png">
									<p id="alertText1"></p>
								</div>
								<button type="button" class="layui-btn" id="imgUserUp">上传车主图片</button>
							</div>
						</div> -->
						<!-- 车主信息提交按钮 -->
							<div class="form-group">
							<div
								class="col-lg-push-3 col-md-push-3 col-sm-push-3 col-xs-push-2 col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
								<input type="button" class="btn btn-info" value="提交" />
							</div>
						</div>
					</form>
				</div>
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
	<!-- <script src="/NewRmgps/web/js/uploader.js"></script> -->
	<script src="/NewRmgps/web/js/jedate/jedate.min.js"></script>
	<script>
		$(function(){
			jQuery.support.cors=true;
			function formAlert(){
				alert("请先完成车辆基本信息的注册！");
				return false;
			}
			/* 基本信息没提交成功，不能显示后面的车主信息和车辆详细信息 */
			$(".verhicleTab li:gt(0)").bind("click",formAlert);
			//分组
			var selectedGroup=[];
			var vehicleId=null;
			var setting={
			check:{
			enable:true,
			autoCheckTrigger:false,
			chkStyle:"checkbox",
			chkboxType:{
			"Y":"s",
			"N":"s"
			}
			},
			data:{
			simpleData:{
			enable:true,
			idKey:"id",
			pIdKey:"createrUserid"
			},
			keep:{
				parent:true
			}
			},
			async:{
			enable:true,
			dataType:"json",
			type:"get",
			url:"/NewRmgps/Group/showGV",
			dataFilter:ajaxDataFilter
			},
			callback:{
			onClick:function(event,treeId,treeNode){
				if((treeNode.pId!=null)&(treeNode.pId!=0)){}
			},
			onCheck:function(event,treeId,treeNode){
				selectedGroup=[];
				var treeObj=$.fn.zTree.getZTreeObj("groupTree");
				var nodes=treeObj.getCheckedNodes();
				for(var i=0;i<nodes.length;i++){
					if(nodes[i].createrUserid!=null){
						selectedGroup.push(nodes[i].id);
					}
				}
			}
			}
			};
			//初始化
			$.fn.zTree.init($("#groupTree"),setting);
			function ajaxDataFilter(treeId,parentNode,responseData){
				if(responseData){
					for(var i=0;i<responseData.length;i++){
						if(responseData[i].id=="0"){
							responseData[i].iconSkin="all";
							responseData[i].open="true"
						}else{
							responseData[i].iconSkin="group"
						}
						;
					}
				}
				return responseData;
			}
			//车牌号表单验证
			$("#addVerhicleForm").validate({
			errorClass:"error",
			onkeyup:false,
			errorElement:"label",
			rules:{
				licensePlate:{
				required:true,
				rangelength:[2,10],
				//远程验证
				remote:{
				url:"/NewRmgps/Vehicle/checkLicesenPlate",
				type:"post",
				cache:false,
				data:{
					//verhicleNum:function(){
					licensePlate:function(){
						return $("#verhicleNum").val();
					}
				}
				}
				}
			},
			messages:{
				licensePlate:{
					remote:"车牌号已经存在，请修改"
				}
			},
			submitHandler:function(){
				$("#addVerhicleForm").ajaxSubmit({
				type:'post',
				data:{
					"selectedGroup":selectedGroup.join(",")
				},
				success:function(data){
					alert("添加车辆成功！");
					vehicleId=parseInt(data);
					
					/*  车辆基本信息提交后，车辆详细信息出现*/
					$("#verhicleInfo").hide();
					$("#verhicleDetail").show();
					$(".verhicleTab li").eq(0).removeClass("active");
					$(".verhicleTab li").eq(1).addClass("active");
					/*  解绑车辆详细信息和车主信息*/
					$(".verhicleTab li:gt(0)").unbind("click",formAlert);
					$(".verhicleTab li").click(function(){
						var ind=$(this).index();
						$(".verhicleTab li").eq(ind).siblings().removeClass("active");
						$(".verhicleTab li").eq(ind).addClass("active");
						$("#tabWrap>div").eq(ind).siblings().hide();
						$("#tabWrap>div").eq(ind).show();
					})
					/*  车辆详细信息操作*/
					verhicleDetail();
				},
				error:function(e){
					console.log(e)
				}
				});
				return false;
			},
			success:function(label){
				label.html("<span style='color:green;font-size:12px;'>验证通过</span>");
			}
			});
			/* 点击添加分组处理 */
			$("#addGroup button").click(function(){
				$("#groupName").val("");
				console.log("添加分组！");
				jQuery.support.cors=true;
				$(".mengban").show();
				$("#addGup").show();
				//监控员
				var selectedUser=[];
				var setting={
				check:{
				enable:true,
				autoCheckTrigger:false,
				chkStyle:"checkbox",
				chkboxType:{
				"Y":"s",
				"N":"s"
				}
				},
				data:{
				simpleData:{
				enable:true,
				idKey:"id",
				pIdKey:"createrUserid"
				},
				key:{
					name:"userName"
				},
				keep:{
					parent:true
				}
				},
				async:{
				enable:true,
				dataType:"json",
				type:"get",
				url:"/NewRmgps/User/showMonitorsForPage",
				dataFilter:ajaxDataFilter
				},
				callback:{
				onClick:function(event,treeId,treeNode){
					if((treeNode.pId!=null)&(treeNode.pId!=0)){}
				},
				onCheck:function(event,treeId,treeNode){
					selectedUser=[];
					var treeObj=$.fn.zTree.getZTreeObj("userTree");
					var nodes=treeObj.getCheckedNodes();
					for(var i=0;i<nodes.length;i++){
						if(nodes[i].creatId!=null){
							selectedUser.push(nodes[i].id);
						}
					}
				}
				}
				};
				$.fn.zTree.init($("#userTree"),setting);
				function ajaxDataFilter(treeId,parentNode,responseData){
					if(responseData){
						for(var i=0;i<responseData.length;i++){
							if(responseData[i].id=="0"){
								responseData[i].iconSkin="all";
								responseData[i].open="true"
							}else{
								responseData[i].iconSkin="group"
							}
							;
						}
					}
					return responseData;
				}
				//表单验证
				$("#addGroupForm").validate({
				errorClass:"error",
				onkeyup:false,
				errorElement:"label",
				rules:{
					name:{
					required:true,
					rangelength:[2,10],
					//远程验证
					remote:{
					url:"/NewRmgps/Group/checkGroupName",
					type:"post",
					cache:false,
					data:{
						/* groupName:function(){ */
						name:function(){
							return $("#groupName").val();
						}
					}
					}
					}
				},
				messages:{
					name:{
						remote:"分组名重复"
					}
				},
				submitHandler:function(){
					$("#addGroupForm").ajaxSubmit({
					type:'post',
					data:{
						"selectedUser":selectedUser.join(",")
					},
					success:function(){
						alert("添加分组成功！");
						$(".mengban").hide();
						$("#addGup").hide();
						$.fn.zTree.init($("#groupTree"),setting);
					},
					error:function(e){
						console.log(e)
					}
					});
					return false;
				},
				success:function(label){
					label.html("<span style='color:green;font-size:12px;'>验证通过</span>");
				}
				});
				$(".mengban  input:reset").click(function(){
					$.fn.zTree.init($("#userTree"),setting);
					$("label.error").remove();
				})
			})
			/*  车辆详细信息操作*/
			function verhicleDetail(){
				$("#verhicleNum2").val(($("#verhicleNum").val()));
			
			/* 	var upload=layui.upload;
				//普通图片上传
				var uploadInst=upload
						.render({
						elem:'#imgUp',
						url:'data/data11.json',
						accept:'images',
						exts:'jpg|png|gif|bmp|jpeg',
						method:"get",
						before:function(obj){
							//预读本地文件示例，不支持ie8
							obj.preview(function(index,file,result){
								$('#verhicleImg').attr('src',result); //图片链接（base64）
							});
						},
						done:function(res){
							if(res.code>0){
								return layer.msg('上传失败');
							}
							//上传成功
							alert('车辆图片上传成功');
						},
						error:function(){
							//演示失败状态，并实现重传
							var demoText=$('#alertText');
							demoText
									.html('<span style="color: #FF5722; ">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
							demoText.find('.demo-reload').on('click',function(){
								uploadInst.upload();
							});
						}
						}); */
				/*  提交*/
				$("#addVerhicleDetailForm input:button").unbind("click").bind("click",function(){
					$("#addVerhicleDetailForm").ajaxSubmit({
					type:'post',
					data:{
						"licensePlate":$("#verhicleNum2").val()
					}, 
					success:function(){
						alert("添加车辆信息成功！");
						$("#verhicleDetail").hide();
						$("#verhicleOwener").show();
						$(".verhicleTab li").eq(1).removeClass("active");
						$(".verhicleTab li").eq(2).addClass("active");
						/*  车主信息程序*/
						verhicleOwener();
					},
					error:function(e){
						console.log(e)
					}
					})
				})
			}
			/*  车主信息程序*/
			function verhicleOwener(){
				/*  时间插件*/
			/* 	jeDate({
				dateCell:"#driveLicenseDate",
				format:"YYYY/MM/DD hh:mm:ss",
				//isinitVal:true,
				isTime:true, //isClear:false,
				minDate:"2000-01-01 00:00:00",
				//okfun:function(val){alert(val)}
				}) */
				
				/* 车主信息提交 */
				$("#addVerhicleUserForm input:button").unbind("click").bind("click",function(){
					$("#addVerhicleUserForm").ajaxSubmit({
					type:'post',
					data:{
						"vid":vehicleId+""
					}, 
					success:function(){
						alert("添加车主信息成功！")
					},
					error:function(e){
						console.log(e)
					}
					})
				})
			}
			;
			/*  重置按钮*/
			$("#addVerhicleForm input:reset").click(function(){
				$.fn.zTree.init($("#groupTree"),setting);
				$("label.error").remove();
			})
			/*  添加分组删除按钮*/
			$("#addGup h4 span").click(function(){
				$(".mengban").hide();
				$("#addGup").hide();
			})
		})
	</script>
</body>
</html>