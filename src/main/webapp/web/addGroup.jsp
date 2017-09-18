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
<meta name="author" content="author">
<!-- 关键字使用","分隔 -->
<meta name="keywords" content="GPS,金圣达,位置">
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

#addGroupForm .form-control {
	display: inline-block;
	width: 50%;
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
/* 分组外面div */
.groupDiv {
	max-height: 400px;
	min-height: 100px;
	overflow-y: scroll;
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
			<h4>添加分组:</h4>
			<form id="addGroupForm" action="http://127.0.0.1/ceshi.php"
				class="form-horizontal" role="form" method="post">
				<!-- 分组名字 -->
				<div class="form-group">
					<label for="groupName"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">分组名称：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left">
						<input type="text" class="form-control" name="groupName"
							id="groupName" placeholder="请输入分组名称(2~10位)">
					</div>
				</div>
				<!--选择监控员 -->
				<div class="form-group">
					<label for="customAdd"
						class="col-lg-3 col-md-3 col-sm-3 col-xs-4 control-label text-right">选择监控员：</label>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-8 text-left groupDiv">
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
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- <script src="https://cdn.bootcss.com/jquery-validate/1.17.0/jquery.validate.js"></script> -->
	<script src="js/jquery.validate.js"></script>
	<script src="js/jquery.ztree.all.js"></script>
	<script src="js/messages_zh.js"></script>
	<script src="js/jquery.form.js"></script>
	<script>
		$(function(){
			jQuery.support.cors=true;
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
			url:"data/userGroup.json",
			dataFilter:ajaxDataFilter
			},
			callback:{
			onClick:function(event,treeId,treeNode){
				if((treeNode.pId!=null)&(treeNode.pId!=0)){}
			},
			onCheck:function(event,treeId,treeNode){
				selectedUser=[];
				var treeObj=$.fn.zTree.getZTreeObj("groupTree");
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
				groupName:{
				required:true,
				rangelength:[2,10],
				//远程验证
				remote:{
				url:"http://127.0.0.1/ceshi.php",
				type:"post",
				dataType:"json",
				cache:false,
				data:{
					clientName:function(){
						return $("#groupName").val();
					}
				}
				}
				}
			},
			messages:{
				groupName:{
					remote:"分组名重复"
				}
			},
			submitHandler:function(){
				$("#addGroupForm").ajaxSubmit({
				type:'post',
				data:{
					"selectedUser":selectedUser
				},
				success:function(){
					alert("添加分组成功！");
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
			$("input:reset").click(function(){
				$.fn.zTree.init($("#userTree"),setting);
				$("label.error").remove();
			})
		})
	</script>
</body>
</html>