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
h4{
margin-bottom:30px;}
h5{
padding:10px 0;
margin:0 0 10px 0;
background-color:#99ccff;
border-bottom:1px #000 solid;}
/*  客户列表外面包裹的div*/
.vehicleDiv1,.vehicleDiv2{
padding:0;
	border:1px #000 solid;
	max-height: 500px;
	min-height: 300px;
	overflow-y: scroll;
}
/*  数结构样式*/
.ztree li span.button.customer_ico_open,.ztree li span.button.customer_ico_close {
	background-image: url("/NewRmgps/web/images/customer.png");
}
.ztree li span.button.terminal_ico_docu {
	background-image: url("/NewRmgps/web/images/GPS.png");
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
			<h4>移动终端:</h4>
			<!-- <div  id="notice"><strong>※※ — 操作说明 — ※※</strong></div>
				<ol id="noticeOl">
					<li>分组不能移动到分组和车辆下面，客户不能移动，车辆不能移动到车辆下面。</li>
					<li><strong>选择</strong>时，按<strong>Ctrl</strong>键可以多选；<strong>移动</strong>时，按<strong>Ctrl</strong>表示复制。</li>
					<li>多选时，分组和车辆不能混合选择移动，要么都选分组，要么都选车辆。</li>
				</ol> -->
			<div class="col-lg-offset-1 col-md-offset-1 col-lg-4 col-md-4 col-sm-5 col-xs-5 vehicleDiv1">
				<h5>选择要调拨的终端：</h5>
						<ul id="leftTree" class="ztree"></ul>
			</div>
			<div class=" col-lg-1 col-md-1 col-sm-2 col-xs-2 text-center"><button id="moveBtnRight"><img src="/NewRmgps/web/images/right.png"/></button>
			<button id="moveBtnLeft"><img src="/NewRmgps/web/images/left.png"/></button></div>
			<div class=" col-lg-4 col-md-4 col-sm-5 col-xs-5 vehicleDiv2">
			<h5>选择要调拨的终端：</h5>
			<ul id="rightTree" class="ztree"></ul> </div>
		</div>
	</div>
	<script src="/NewRmgps/web/js/jquery.min.js"></script>
	<script src="/NewRmgps/web/js/bootstrap.min.js"></script>
	<script src="/NewRmgps/web/js/jquery.ztree.all.js"></script>
	<script type="text/javascript">
	$(function(){
		jQuery.support.cors=true;
		//请求路径
		function ajaxUrl(treeId, treeNode){
		    return treeNode ? "/NewRmgps/Terminal/getTerminalsByUserId" : "/NewRmgps/Terminal/getUsers";
}
		/*  树接收数据处理*/
		function ajaxDataFilter1(treeId,parentNode,responseData){
			if(responseData){
					/* if(responseData[i].type=="group"){ */
						if(!parentNode){
							for(var i=0;i<responseData.length;i++){
						responseData[i].iconSkin="customer";
						responseData[i].isParent=true;
						responseData[i].name=responseData[i].userName
							}
						}else{
							for(var i=0;i<responseData.length;i++){
							responseData[i].iconSkin="terminal";
							responseData[i].isParent=false;
							/* responseData[i].name=responseData[i].licensePlate */
						}
						}
					/* }else{
						responseData[i].iconSkin="vehicle"
					}
					; */
				}
			return responseData;
		}
		//初始化
		function ztreeInit(obj){
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
			}
			},
			async:{
			autoParam: ["id"],
			enable:true,
			type:"post",
			url:ajaxUrl,
			dataFilter:ajaxDataFilter1
			},
			callback:{
			/* 	onCheck:ztreeOnCheck2 */
			}
			});
		}
		//初始化
		ztreeInit("#leftTree");
		ztreeInit("#rightTree");
		/* 判断是否选择分组 选择分组是true，选择车辆是false*/
		function isHaveCustomer (element, index, array) {
			  return element.isParent==true;
			}
		$("#moveBtnRight").on("click",function(){
			var leftTreeObj = $.fn.zTree.getZTreeObj("leftTree");
			//左边选中的选择框
			var leftNodes =leftTreeObj.getCheckedNodes();
			/* console.log(leftNodes[0].getCheckStatus().half) */
			var rightTreeObj = $.fn.zTree.getZTreeObj("rightTree");
			//右边选中的选择框
			var rightNodes =rightTreeObj.getCheckedNodes();
			var leftSelectedCustomer=[];
			var rightSelectedCustomer;
			var leftSelectedTerminal=[];
			var leftCustomerFlag=leftNodes.some(isHaveCustomer);
			var rightCustomerFlag=rightNodes.some(isHaveCustomer);
			//如果左边没选择

			if( leftNodes.length>0){
			if( rightCustomerFlag){
				for(var i=0;i<leftNodes.length;i++){
					if(leftNodes[i].isParent==false){
						 leftSelectedTerminal.push(leftNodes[i].code);
						 /* leftSelectedCustomer.push(leftNodes[i].pId); */
					}
				}
				for(var i=rightNodes.length-1;i>=0;i--){
					if(rightNodes[i].isParent==true){
						rightSelectedCustomer=rightNodes[i].id;
					}
				}
				$.ajax({
					url:"/NewRmgps/Terminal/moveTerminals",
					type:"post",
					data:{
						"codes": leftSelectedTerminal.join(","),
						"nUserId":rightSelectedCustomer
					},
					success:function(data){
						if(data){
							alert("终端调拨成功")
							ztreeInit("#leftTree");
							ztreeInit("#rightTree");
							}else{
								alert("未知错误,请重试")
							}
					},error:function(error){
						console.log(error)
					},
					async:false
				})
			}else{
				alert("请选择终端要移入的客户");
			}
			}else{
				alert("请选择终端要调拨的终端");
			}
			})
			
			$("#moveBtnLeft").on("click",function(){
			var leftTreeObj = $.fn.zTree.getZTreeObj("leftTree");
			//左边选中的选择框
			var leftNodes =leftTreeObj.getCheckedNodes();
			/* console.log(leftNodes[0].getCheckStatus().half) */
			var rightTreeObj = $.fn.zTree.getZTreeObj("rightTree");
			//右边选中的选择框
			var rightNodes =rightTreeObj.getCheckedNodes();
			var rightSelectedCustomer=[];
			var leftSelectedCustomer;
			var rightSelectedTerminal=[];
			var leftCustomerFlag=leftNodes.some(isHaveCustomer);
			var rightCustomerFlag=rightNodes.some(isHaveCustomer);
			//如果右边没选择
			if( rightNodes.length>0){
			if( leftCustomerFlag){
				for(var i=0;i<rightNodes.length;i++){
					if(rightNodes[i].isParent==false){
						 rightSelectedTerminal.push(rightNodes[i].code);
						 /* leftSelectedCustomer.push(leftNodes[i].pId); */
					}
				}
				for(var i=leftNodes.length-1;i>=0;i--){
					if(leftNodes[i].isParent==true){
						leftSelectedCustomer=leftNodes[i].id;
					}
				}
				$.ajax({
					url:"/NewRmgps/Terminal/moveTerminals",
					type:"post",
					data:{
						"codes": rightSelectedTerminal.join(","),
						"nUserId":leftSelectedCustomer
					},
					success:function(data){
						if(data){
							alert("终端调拨成功")
							ztreeInit("#leftTree");
							ztreeInit("#rightTree");
							}else{
								alert("未知错误,请重试")
							}
					},error:function(error){
						console.log(error)
					},
					async:false
				})
			}else{
				alert("请选择终端要移入的客户");
			}
			}else{
				alert("请选择终端要调拨的终端");
			}
			})
	})
	</script>
</body>
</html>