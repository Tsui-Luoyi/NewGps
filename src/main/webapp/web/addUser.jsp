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
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
<style type="text/css">
html, body {
	height: 100%;
	width: 100%;
}

h4 {
	font-weight: bold;
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

label.checked {
	color: green
}

label.error {
	color: red
}

.form-control {
	display: inline-block;
	width: 50%;
}

.formDiv {
	margin: 0;
}

.formDiv>div {
	margin: 0;
}

#userSelectName {
	width: 50%;
	height: 34px;
}
/* 分步骤三个表单ul */
.userTab {
	list-style: none;
	float: left;
	padding: 0 20px;
	margin-left: 10px;
	border-bottom: 1px #000 solid
}

.userTab>li {
	display: inline-block;
	padding: 5px 10px;
	background-color: #79acdf;
	border: 1px #000 solid;
	border-radius: 5px 5px 0 0;
	border-bottom: 0;
	color: #fff;
	font-weight: 700
}

.userTab li.active {
	background-color: #fff;
	color: #000;
}
/* 分步骤三个表单外面 */
.userGroupDiv, .userJurisdictionDiv {
	position: absolute;
	width: 95%;
	display: none;
}

#searchGroup {
	margin-top: 5px
}

#searchGroup label {
	font-weight: 400
}

.userJurisdictionDiv {
	/* display: block; */
	
}

#groupCheckTree {
	max-height: 400px;
	min-height: 200px;
	overflow-y: scroll;
}

.ztree li span.button.all_ico_open {
	background-image: url("images/all-2.png")
}

.ztree li span.button.all_ico_close {
	background-image: url("images/all-1.png")
}

.ztree li span.button.group_ico_docu {
	background-image: url("css/zTreeStyle/img/diy/group.png")
}
/* 车辆 */
.ztree li span.button.carSet_ico_open {
	background-image: url("images/carSet.png")
}
/* 车辆 */
.ztree li span.button.carSet_ico_close {
	background-image: url("images/carSet.png")
}
/* 分组 */
.ztree li span.button.groupSet_ico_open {
	background-image: url("images/groupSet.png")
}
/* 分组 */
.ztree li span.button.groupSet_ico_close {
	background-image: url("images/groupSet.png")
}
/* 命令 */
.ztree li span.button.cmdSet_ico_open {
	background-image: url("images/cmdSet.png")
}
/* 命令 */
.ztree li span.button.cmdSet_ico_close {
	background-image: url("images/cmdSet.png")
}
/* 添加 */
.ztree li span.button.add_ico_docu {
	background-image: url("images/add.png")
}
/* 修改 */
.ztree li span.button.change_ico_docu {
	background-image: url("images/change.png")
}
/* 查询 */
.ztree li span.button.find_ico_docu {
	background-image: url("images/find.png")
}
/* 删除 */
.ztree li span.button.delete_ico_docu {
	background-image: url("images/delete.png")
}
/* 停用 */
.ztree li span.button.stop_ico_docu {
	background-image: url("images/stop.png")
}
/* 移动 */
.ztree li span.button.move_ico_docu {
	background-image: url("images/move.png")
}
/* 允许 */
.ztree li span.button.allow_ico_docu {
	background-image: url("images/allow.png")
}
/* 不允许 */
.ztree li span.button.disAllow_ico_docu {
	background-image: url("images/disAllow.png")
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<h4>添加用户:</h4>
			<div class="row">
				<ul class="userTab">
					<li class="active">基本信息</li>
					<li>分组设置</li>
					<li>权限设置</li>
				</ul>
			</div>
			<div class="row formDiv">
				<div class="row userNameDiv">
					<form id="addUserForm" action="http://127.0.0.1/ceshi.php"
						class="form-horizontal" role="form" method="post">
						<!-- 监控员名字 -->
						<div class="form-group">
							<label for="userName"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">监控员名称：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<input type="text" class="form-control" name="userName"
									id="userName" placeholder="请输入监控员名称(3~6位)">
							</div>
						</div>
						<!-- 用户类型 -->
						<!-- <div class="form-group">
							<label for="userType"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">用户类型：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<div id="userSelectContainer">
									<select name="userSelectName" id="userSelectName">
										<option value="1" selected="selected">管理员</option>
										<option value="2">监控员</option>
									</select>
								</div>
							</div>
						</div> -->
						<!-- 用户电话 -->
						<div class="form-group">
							<label for="userTel"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">监控员电话(选填)：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<input type="text" class="form-control" name="userTel"
									id="userTel" placeholder="请输入监控员电话">
							</div>
						</div>
						 <!-- 用户地址 -->
						<!-- <div class="form-group">
							<label for="userAdd"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">用户地址(选填)：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<input type="text" class="form-control" id="userAdd"
									name="userAdd" placeholder="请输入客户地址">
							</div>
						</div> -->
						<!-- 用户登录密码 -->
						<div class="form-group">
							<label for="userLoginPwd"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">登录密码：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<input type="password" class="form-control" id="userLoginPwd"
									name="userLoginPwd" placeholder="请输入登录密码(6~16位)">
							</div>
						</div>
						<!-- 用户密码确认 -->
						<div class="form-group">
							<label for="userLoginPwd1"
								class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">再次输入密码：</label>
							<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
								<input type="password" class="form-control" id="userLoginPwd1"
									name="userLoginPwd1" placeholder="请再次输入登录密码">
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
				<div class="row userGroupDiv">
					<!-- <form id="groupSetForm" action="http://127.0.0.1/ceshi.php"
						class="form-horizontal" role="form" method="post"> -->
					<!-- 分组设置 -->
					<div class="form-group checkBox">
						<label
							class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">请选择分组:</label>
						<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
							<div id="searchGroup">
								<label>搜索分组:</label><input id="keywordGroup" type="text"
									placeholder="请输入分组名称">
							</div>
							<ul id="groupSetTree" class="ztree"></ul>
						</div>
					</div>
					<!-- 提交按钮 -->
					<div
						class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
						<input type="button" class="btn btn-info" value="提交" />
					</div>
					<!-- </form> -->
				</div>
				<div class="row userJurisdictionDiv">
					<form id="addUserForm" action="http://127.0.0.1/ceshi.php"
						class="form-horizontal" role="form" method="post">
						<div class="row">
						<h4 class="text-left">请设置权限</h4>	
						<div class="col-lg-push-3 col-md-push-3 col-sm-push-3 col-xs-push-3 col-lg-6 col-md-6 col-sm-6 col-xs-8 text-center">
								<ul id="jurisdictionSetTree" class="ztree"></ul>
						</div>	
							
						</div>
						<div class="form-group">
							<div class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-xs-push-3 col-lg-7 col-md-7 col-sm-7 col-xs-8 text-center">
								<input type="button" class="btn btn-info" value="提交" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.validate.js"></script>
	<script src="js/jquery.ztree.all.js"></script>
	<script src="js/messages_zh.js"></script>
	<script src="js/jquery.form.js"></script>
	<script>
		$(function(){
			jQuery.support.cors=true;
			var jurisdictionList=[{
			"id":"0",
			"pId":"",
			"name":"全部",
			"iconSkin":"all",
			"open":"true"
			},{
			"id":"111",
			"pId":"0",
			"name":"车辆权限",
			"iconSkin":"carSet"
			},{
			"id":"222",
			"pId":"0",
			"name":"分组权限",
			"iconSkin":"groupSet"
			},{
			"id":"333",
			"pId":"0",
			"name":"车辆命令权限",
			"iconSkin":"cmdSet"
			},{
			"id":"1110",
			"pId":"111",
			"name":"添加车辆",
			"iconSkin":"add",
			 checked:true 
			},{
			"id":"1111",
			"pId":"111",
			"name":"查询车辆",
			"iconSkin":"find"
			},{
			"id":"1112",
			"pId":"111",
			"name":"修改车辆",
			"iconSkin":"change"
			},{
			"id":"1113",
			"pId":"111",
			"name":"移动车辆",
			"iconSkin":"move"
			},{
			"id":"1114",
			"pId":"111",
			"name":"停用车辆",
			"iconSkin":"stop"
			},{
			"id":"1115",
			"pId":"111",
			"name":"删除车辆",
			"iconSkin":"delete"
			},{
			"id":"2220",
			"pId":"222",
			"name":"添加分组",
			"iconSkin":"add"
			},{
			"id":"2221",
			"pId":"222",
			"name":"查询分组",
			"iconSkin":"find"
			},{
			"id":"2222",
			"pId":"222",
			"name":"停用分组",
			"iconSkin":"stop"
			},{
			"id":"2223",
			"pId":"222",
			"name":"删除分组",
			"iconSkin":"delete"
			},{
			"id":"3330",
			"pId":"333",
			"name":"允许设置命令",
			"iconSkin":"allow"
			},{
			"id":"3331",
			"pId":"333",
			"name":"不允许设置命令",
			"iconSkin":"disAllow"
			}];
			function formAlert(){
				alert("请先完成基本信息的注册！");
				return false;
			}
			$(".userTab li:gt(0)").bind("click",formAlert);
			//表单验证
			$("#addUserForm").validate({
			errorClass:"error",
			onkeyup:false,
			errorElement:"label",
			rules:{
			userName:{
			required:true,
			rangelength:[3,6],
			//远程验证
			remote:{
			url:"http://127.0.0.1/ceshi.php",
			type:"post",
			dataType:"json",
			cache:false,
			data:{
				clientName:function(){
					return $("#userName").val();
				}
			}
			}
			},
			userLoginPwd:{
			required:true,
			rangelength:[6,16],
			isEnglish:true
			},
			userLoginPwd1:{
			required:true,
			rangelength:[6,16],
			equalTo:"#userLoginPwd"
			}
			},
			messages:{
				userName:{
					remote:"该名已被注册"
				}
			},
			submitHandler:function(){
				$("#addUserForm").ajaxSubmit(function(){
					alert("添加用户成功!");
					userGroupSet();
				});
				return false;
			},
			success:function(label){
				label.html("<span style='color:green;font-size:12px;'>验证通过</span>");
			}
			});
			$("input:reset").click(function(){
				$("label.error").remove();
			});
			function userGroupSet(){
				// 基本信息显示，分组设置隐藏，li之间转换，并取消alert绑定
				$(".userNameDiv").hide();
				$(".userGroupDiv").show();
				$(".userTab li").eq(0).removeClass("active");
				$(".userTab li").eq(1).addClass("active");
				$(".userTab li:gt(0)").unbind("click",formAlert);
				//基本信息和分组设置之间的切换
				$(".userTab li:lt(3)").click(function(){
					var ind=$(this).index();
					$(".userTab li").eq(ind).siblings().removeClass("active");
					$(".userTab li").eq(ind).addClass("active");
					$(".formDiv>div").eq(ind).siblings().hide();
					$(".formDiv>div").eq(ind).show();
				})
				groupSet();
			}
			function groupSet(){
				var selectedGroup=[];
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
				pIdKey:"creatId"
				},
				keep:{
					parent:true
				}
				},
				async:{
				enable:true,
				dataType:"text",
				type:"get",
				url:"data/group.json",
				dataFilter:ajaxDataFilter
				},
				callback:{
				onClick:function(event,treeId,treeNode){
					if((treeNode.pId!=null)&(treeNode.pId!=0)){}
				},
				onCheck:function(event,treeId,treeNode){
					selectedGroup=[];
					var treeObj=$.fn.zTree.getZTreeObj("groupSetTree");
					var nodes=treeObj.getCheckedNodes();
					for(var i=0;i<nodes.length;i++){
						if(nodes[i].creatId!=null){
							selectedGroup.push(nodes[i].id);
						}
					}
				}
				}
				};
				$.fn.zTree.init($("#groupSetTree"),setting);
				//ajax数据预处理
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
				;
				//分组搜索
				/* $('#keywordGroup').bind('input propertychange',function(){
					var treeObj=$.fn.zTree.getZTreeObj("groupCheckTree");
					var keywords=$("#keywordGroup").val();
					var nodes=treeObj.getNodesByParamFuzzy("name",keywords);
					if(nodes.length>0){
						treeObj.selectNode(nodes[0]);
					}
				}); */
				$('#keywordGroup').bind('keydown',function(e){
					if(e.keyCode=="13"){
						var treeObj=$.fn.zTree.getZTreeObj("groupSetTree");
						var keywords=$("#keywordGroup").val();
						var nodes=treeObj.getNodesByParamFuzzy("name",keywords);
						if(nodes.length>0){
							treeObj.selectNode(nodes[0]);
						}
					}
				});
				$(".userGroupDiv input[type='button']").click(function(){
					$.post("http://127.0.0.1/ceshi.php",{
						"selectedGroup":selectedGroup.join(",")
					},userJurisdictionSet)
				})
				//权限设置
				function userJurisdictionSet(){
					alert("分组设置成功")
					$(".userGroupDiv").hide();
					$(".userJurisdictionDiv").show();
					$(".userTab li").eq(1).removeClass("active");
					$(".userTab li").eq(2).addClass("active");
					jurisdictionSet();
					$(".userTab li:lt(3)").click(function(){
						var ind=$(this).index();
						$(".userTab li").eq(ind).siblings().removeClass("active");
						$(".userTab li").eq(ind).addClass("active");
						$(".formDiv>div").eq(ind).siblings().hide();
						$(".formDiv>div").eq(ind).show();
					})
				}
			}
			function jurisdictionSet(){
				var selectedJurisdiction=[];
				var setting1={
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
				pIdKey:"pId"
				},
				keep:{
					parent:true
				}
				},
				callback:{
					onCheck:function(event,treeId,treeNode){
						selectedJurisdiction=[];
						var treeObj=$.fn.zTree.getZTreeObj("jurisdictionSetTree");
						var nodes=treeObj.getCheckedNodes();
						for(var i=0;i<nodes.length;i++){
							if(nodes[i].pId!=null&&nodes[i].pId!="0"){
								selectedJurisdiction.push(nodes[i].id);
							}
						}
					}
				}
				}
				$.fn.zTree.init($("#jurisdictionSetTree"),setting1,jurisdictionList);
				$(".userJurisdictionDiv input[type='button']").click(function(){
					$.post("http://127.0.0.1/ceshi.php",{
						"selectedJurisdiction":selectedJurisdiction.join(",")
					},function(){alert("添加权限成功！")})
				})
			}
		})
	</script>
</body>
</html>