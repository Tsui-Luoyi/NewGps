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
<link rel="stylesheet" href="/NewRmgps/web/css/media.css">
<link rel="stylesheet" href="/NewRmgps/web/css/color.css">
<link rel="stylesheet" href="/NewRmgps/web/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<style>
html, body {
	height: 100%;
	width: 100%;
}

h4 ,h5{
	font-weight: bold;
}
h5{
border-bottom:1px #000 solid;}
/*  客户列表外面包裹的div*/
.vehicleDiv1,.vehicleDiv2{
	border:1px #000 solid;
	max-height: 500px;
	min-height: 300px;
	overflow-y: scroll;
}
/*  数结构样式*/
.ztree li span.button.group_ico_open,.ztree li span.button.group_ico_close {
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/group.png");
}
.ztree li span.button.group_ico_docu{
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/group.png");
}
.ztree li span.button.vehicle_ico_docu {
	background-image: url("/NewRmgps/web/images/vehicle.png");
}
.ztree li span.button.custom_ico_open,.ztree li span.button.custom_ico_close {
	background-image: url("/NewRmgps/web/images/custom.png");
}
.ztree li span.button.custom_ico_docu {
	background-image: url("/NewRmgps/web/images/custom.png");
}
/*  注意*/
#notice{
margin:10px 0;}
#notice strong, #noticeOl strong{
	color:red;
	font-weight:bolder;
}
/* 移动按钮 */
#moveBtnLeft,#moveBtnRight{
margin-top:80px;
display: block;
    margin-left: 20%;}
</style>
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<h4>移动车辆:</h4>
			<!-- <div  id="notice"><strong>※※ — 操作说明 — ※※</strong></div>
				<ol id="noticeOl">
					<li>分组不能移动到分组和车辆下面，客户不能移动，车辆不能移动到车辆下面。</li>
					<li><strong>选择</strong>时，按<strong>Ctrl</strong>键可以多选；<strong>移动</strong>时，按<strong>Ctrl</strong>表示复制。</li>
					<li>多选时，分组和车辆不能混合选择移动，要么都选分组，要么都选车辆。</li>
				</ol> -->
			<div class="col-lg-offset-1 col-md-offset-1 col-lg-4 col-md-4 col-sm-5 col-xs-5 vehicleDiv1">
				<h5>自己所建分组及车辆：</h5>
				<p>选择客户：<select name="leftCustomerSelect"
								id="leftCustomerSelect">
								<option value="">-&nbsp;&nbsp;请选择客户名字&nbsp;&nbsp;-</option>
							</select></p>
						<ul id="leftTree" class="ztree"></ul>
			</div>
			<div class=" col-lg-1 col-md-1 col-sm-2 col-xs-2 text-center"><button id="moveBtnRight"><img src="/NewRmgps/web/images/right.png"/></button>
			<button id="moveBtnLeft"><img src="/NewRmgps/web/images/left.png"/></button></div>
			<div class=" col-lg-4 col-md-4 col-sm-5 col-xs-5 vehicleDiv2">
			<h5>子客户以及所建分组和车辆：</h5>
			<p>选择客户：<select name="rightCustomerSelect"
								id="rightCustomerSelect">
								<option value="">-&nbsp;&nbsp;请选择客户名字&nbsp;&nbsp;-</option>
							</select></p>
			<ul id="rightTree" class="ztree"></ul> </div>
		</div>
	</div>
	<script src="/NewRmgps/web/js/jquery.min.js"></script>
	<script src="/NewRmgps/web/js/bootstrap.min.js"></script>
	<script src="/NewRmgps/web/js/jquery.ztree.all.js"></script>
	<script type="text/javascript">
	$(function(){
		jQuery.support.cors=true;
		//第一次点击下拉框，加载客户数据
		/* $("#leftCustomerSelect").one("click",function(){ */
			 $.ajax({
					url:"/NewRmgps/Vehicle/getCustomers",
					type:"post",
					dataType:"json",
					data:"123",
					success:function(data){
						for(var i=0;i<data.length;i++){
							var opt=$("<option value='"+data[i].id+"'>"+data[i].customername+"</option>");
							$("#leftCustomerSelect").append(opt);
						}
					},error:function(error){
						console.log(error)
					},
					async:false
				}) 	
		/* }) */
	/* 	$("#rightCustomerSelect").one("click",function(){ */
			 $.ajax({
					url:"/NewRmgps/Vehicle/getCustomers",
					type:"post",
					dataType:"json",
					data:"123",
					success:function(data){
						for(var i=0;i<data.length;i++){
							var opt=$("<option value='"+data[i].id+"'>"+data[i].customername+"</option>");
							$("#rightCustomerSelect").append(opt);
						}
					},error:function(error){
						console.log(error)
					},
					async:false
				}) 	
	/* 	}) */
	
	function ajaxUrl(treeId, treeNode){
					    return treeNode ? "/NewRmgps/Vehicle/getVehiclesByGroupId" : "/NewRmgps/Vehicle/getGroups";
		}
		/* 左边的下拉框变化是，左边的树初始化 */
		$("#leftCustomerSelect").on("change",function(){
			$.fn.zTree.init($("#leftTree"),{
				check:{
					enable:true,
					autoCheckTrigger:false,
					chkStyle:"checkbox",
					chkboxType:{
						"Y":"s",
						"N":"ps"
					}
					},
			data:{
			simpleData:{
			enable:true,
			idKey:"id",
			pIdKey:"pId"
			}
			},
			async:{
			autoParam: ["id=groupId"],
			otherParam: { "customerId":$("#leftCustomerSelect").val()},
			enable:true,
			type:"post",
			url:ajaxUrl,
			/* url:"/NewRmgps/Vehicle/getGroups" , */
			dataFilter:ajaxDataFilter1
			},
			callback:{
				/* onCheck:ztreeOnCheck1 */
			}
			});
		})
		/* 右边的下拉框变化是，右边的树初始化 */
		$("#rightCustomerSelect").on("change",function(){
			$.fn.zTree.init($("#rightTree"),{
				check:{
					enable:true,
					autoCheckTrigger:false,
					chkStyle:"checkbox",
					chkboxType:{
						"Y":"s",
						"N":"ps"
					}
					},
			data:{
			simpleData:{
			enable:true,
			idKey:"id",
			pIdKey:"pId"
			}
			},
			async:{
			autoParam: ["id=groupId"],
			 otherParam: { "customerId":$("#rightCustomerSelect").val()}, 
			enable:true,
			type:"post",
			url:ajaxUrl,
			dataFilter:ajaxDataFilter1
			},
			callback:{
			/* 	onCheck:ztreeOnCheck2 */
			}
			});
		})
		/*  第一棵树接收数据处理*/
		function ajaxDataFilter1(treeId,parentNode,responseData){
			if(responseData){
					/* if(responseData[i].type=="group"){ */
						if(!parentNode){
							for(var i=0;i<responseData.length;i++){
						responseData[i].iconSkin="group";
						responseData[i].isParent=true;
							}
						}else{
							for(var i=0;i<responseData.length;i++){
							responseData[i].iconSkin="vehicle";
							responseData[i].isParent=false;
							responseData[i].name=responseData[i].licensePlate
						}
						}
					/* }else{
						responseData[i].iconSkin="vehicle"
					}
					; */
				}
			return responseData;
		}
		
		/* 判断是否选择分组 选择分组是true，选择车辆是false*/
		/*function isHaveGroup (element, index, array) {
			  return !element.pId;
			} */
		function ztreeInit(obj,cid){
			$.fn.zTree.init($(obj),{
				check:{
					enable:true,
					autoCheckTrigger:false,
					chkStyle:"checkbox",
					chkboxType:{
						"Y":"s",
						"N":"ps"
					}
					},
			data:{
			simpleData:{
			enable:true,
			idKey:"id",
			pIdKey:"pId"
			},
			key:{
				
			}
			},
			async:{
			autoParam: ["id=groupId"],
			otherParam: { "customerId":$(cid).val()}, 
			enable:true,
			type:"get",
			url:ajaxUrl,
			dataFilter:ajaxDataFilter1
			},
			callback:{
			/* 	onCheck:ztreeOnCheck2 */
			}
			});
		}
		/* 判断是否选择分组 选择分组是true，选择车辆是false*/
		function isHaveGroup (element, index, array) {
			  return element.isParent==true;
			}
		$("#moveBtnRight").on("click",function(){
			//右边没选客户
			if($("#rightCustomerSelect").val()){
			var leftTreeObj = $.fn.zTree.getZTreeObj("leftTree");
			//左边选中的选择框
			var leftNodes =leftTreeObj.getCheckedNodes();
			/* console.log(leftNodes[0].getCheckStatus().half) */
			var rightTreeObj = $.fn.zTree.getZTreeObj("rightTree");
			//右边选中的选择框
			var rightNodes =rightTreeObj.getCheckedNodes();
			var leftSelectedGroup=[];
			var rightSelectedGroup;
			var leftSelectedVehicle=[];
			var leftGroupFlag=leftNodes.some(isHaveGroup);
			var rightGroupFlag=rightNodes.some(isHaveGroup);
			console.log(leftGroupFlag)
			if(leftGroupFlag){    //如果左边选的是分组
				if(rightNodes.length==0){
				for(var i=0;i<leftNodes.length;i++){
					if(leftNodes[i].isParent==true){
						 leftSelectedGroup.push(leftNodes[i].id);
					}
				}
				$.ajax({
					url:"/NewRmgps/Vehicle/move",
					type:"get",
					data:{
						"type":"group",
						"oPIds":$("#leftCustomerSelect").val(),
						"nPId":$("#rightCustomerSelect").val(),
						"targetIds": leftSelectedGroup.join(",")
					},
					success:function(data){
						if(data){
						alert("分组移动成功")
						ztreeInit("#leftTree","#leftCustomerSelect");
						ztreeInit("#rightTree","#rightCustomerSelect");
						}else{
							alert("未知错误,请重试")
						}
					},error:function(error){
						console.log(error)
					},
					async:true
				}) 
				}else{
					alert("移动分组时，只能移动到客户")
				}
			}else{ //左边选择的是车辆
				if(rightGroupFlag){
				for(var i=0;i<leftNodes.length;i++){
				
						leftSelectedVehicle.push(leftNodes[i].id);
						leftSelectedGroup.push(leftNodes[i].pId);
					
				}
				var arr=[];
				for(var i=0;i<leftSelectedGroup.length;i++){
					if(arr.indexOf(leftSelectedGroup[i])=="-1"){
						arr.push(leftSelectedGroup[i]);
					}
				}
				leftSelectedGroup=arr;
				for(var i=rightNodes.length-1;i>=0;i--){
					if(rightNodes[i].isParent==true){
						rightSelectedGroup=rightNodes[i].id;
					}
				}
				
				//车辆提交
				$.ajax({
					url:"/NewRmgps/Vehicle/move",
					type:"post",
					data:{
						"type":"vehicle",
						"leftCustomer":$("#leftCustomerSelect").val(),
						"rightCustomer":$("#rightCustomerSelect").val(),
						"targetIds": leftSelectedVehicle.join(","),
						"oPIds": leftSelectedGroup.join(","), 
						"nPId":rightSelectedGroup
					},
					success:function(data){
						if(data){
							alert("车辆移动成功")
							ztreeInit("#leftTree","#leftCustomerSelect");
							ztreeInit("#rightTree","#rightCustomerSelect");
							}else{
								alert("未知错误,请重试")
							}
					},error:function(error){
						console.log(error)
					},
					async:true
				})
				
			}else{
				alert("请选择一个分组")
			}
			}
			}else{
				alert("请选择要移入的客户");
			}
			})
			
			$("#moveBtnLeft").on("click",function(){
			//左边没选客户
			if($("#leftCustomerSelect").val()){
			var leftTreeObj = $.fn.zTree.getZTreeObj("leftTree");
			//左边选中的选择框
			var leftNodes =leftTreeObj.getCheckedNodes();
			/* console.log(leftNodes[0].getCheckStatus().half) */
			var rightTreeObj = $.fn.zTree.getZTreeObj("rightTree");
			//右边选中的选择框
			var rightNodes =rightTreeObj.getCheckedNodes();
			var rightSelectedGroup=[];
			var leftSelectedGroup;
			var rightSelectedVehicle=[];
			var rightGroupFlag=rightNodes.some(isHaveGroup);
			var leftGroupFlag=leftNodes.some(isHaveGroup);
			if(rightGroupFlag){    //如果右边选的是分组
				//左边没选分组，就把右边选择的分组id加入数组
				if(leftNodes.length==0){
				for(var i=0;i<rightNodes.length;i++){
					if(rightNodes[i].isParent==true){
						 rightSelectedGroup.push(rightNodes[i].id);
					}
				}
				$.ajax({
					url:"/NewRmgps/Vehicle/move",
					type:"get",
					data:{
						"type":"group",
						"nPId":$("#leftCustomerSelect").val(),
						"oPIds":$("#rightCustomerSelect").val(),
						"targetIds":rightSelectedGroup.join(",")
					},
					success:function(data){
						if(data){
							alert("分组移动成功")
							ztreeInit("#leftTree","#leftCustomerSelect");
							ztreeInit("#rightTree","#rightCustomerSelect");
							}else{
								alert("未知错误,请重试")
							}
					},error:function(error){
						console.log(error)
					},
					async:true
				}) 
				}else{
					alert("移动分组时，只能移动到客户")
				}
			}else{ //右边选择的是车辆
				if(leftGroupFlag){
				for(var i=0;i<rightNodes.length;i++){
						rightSelectedVehicle.push(rightNodes[i].id);
						 rightSelectedGroup.push(rightNodes[i].pId);
				}
				var arr=[];
				for(var i=0;i<rightSelectedGroup.length;i++){
					if(arr.indexOf(rightSelectedGroup[i])=="-1"){
						arr.push(rightSelectedGroup[i]);
					}
				}
				rightSelectedGroup=arr;
				for(var i=leftNodes.length-1;i>=0;i--){
					if(leftNodes[i].isParent==true){
						leftSelectedGroup=leftNodes[i].id;
					}
				}
				
				//车辆提交
				$.ajax({
					url:"/NewRmgps/Vehicle/move",
					type:"post",
					data:{
						"type":"vehicle",
						"leftCustomer":$("#leftCustomerSelect").val(),
						"rightCustomer":$("#rightCustomerSelect").val(),
						"targetIds":rightSelectedVehicle.join(","),
						 "oPIds": rightSelectedGroup.join(","),  
						"nPId":leftSelectedGroup
					},
					success:function(data){
						if(data){
							alert("车辆移动成功")
							ztreeInit("#leftTree","#leftCustomerSelect");
							ztreeInit("#rightTree","#rightCustomerSelect");
							}else{
								alert("未知错误,请重试")
							}
					},error:function(error){
						console.log(error)
					},
					async:true
				})
				
			}else{
				alert("请选择一个分组")
			}
			}
			}else{
				alert("请选择要移入的客户");
			}
			})
	})
	</script>
</body>
</html>