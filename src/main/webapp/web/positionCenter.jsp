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
<link rel="stylesheet" href="css/positionCenter.css">
<link rel="stylesheet" href="css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
<style>
.ztree * {
	font-size: 18px;
}

.ztree li {
	line-height: 22px;
}

.ztree li span {
	line-height: 20px;
}

.ztree li a {
	height: 20px;
}

.ztree li a.curSelectedNode {
	height: 22px;
}

.ztree li span.button.group_ico_open, .ztree li span.button.group_ico_close
	{
	background-image: url("css/zTreeStyle/img/diy/group.png")
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

.ztree li span.button.offLine_ico_docu {
	background-image: url("css/zTreeStyle/img/diy/offline.png");
}

.ztree li span.button.onLine_ico_docu {
	background-image: url("css/zTreeStyle/img/diy/online.png");
}
/* 矩形围栏图标 */
.ztree li span.button.rect_ico_docu {
	background-image: url("images/rect.png")
}

.ztree li span.button.round_ico_docu {
	background-image: url("images/round.png")
}

.ztree li span.button.polygon_ico_docu {
	background-image: url("images/polygon.png")
}

.ztree li span.button.marker_ico_docu {
	background-image: url("images/marker.png");
}
/* 搜索框 */
#searchCar, #searchMarker, #searchFence {
	margin-top: 5px;
}

#keywordCar, #keywordMarker, #keywordFence {
	width: 130px;
}

#notice {
	color: red;
	margin-bottom: 5px;
}
</style>
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<div class="container-fluit">
		<div class="row-fluit clearfix">
			<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12" id="mB2">
				<ul id="positionTab" class="nav nav-tabs">
					<li class="active"><a href="#group" data-toggle="tab">分组 </a></li>
					<li><a href="#marker" data-toggle="tab">标注</a></li>
					<li><a href="#fence" data-toggle="tab">围栏</a></li>
					<!-- <li><a href="#alarm" data-toggle="tab">报警</a></li> -->
				</ul>
				<div id="myTabContent" class="tab-content clearfix">
					<div class="tab-pane fade in active" id="group">
						<div id="searchCar">
							<label>搜索车辆:</label><input id="keywordCar" type="text"
								placeholder="请输入车辆名称">
						</div>
						<p id="notice">
							<strong>※注意：</strong>每次请不要选取太多车辆
						</p>
						<ul id="groupTree" class="ztree"></ul>
					</div>
					<div class="tab-pane fade" id="marker">
						<div id="searchMarker">
							<label>搜索标注:</label><input id="keywordMarker" type="text"
								placeholder="请输入标注名称">
						</div>
						<ul id="markerTree" class="ztree"></ul>
					</div>
					<div class="tab-pane fade" id="fence">
						<div id="searchFence">
							<label>搜索围栏:</label><input id="keywordFence" type="text"
								placeholder="请输入围栏名称">
						</div>
						<ul id="fenceTree" class="ztree"></ul>
					</div>
					<!-- <div class="tab-pane fade" id="alarm">
						<table id="customTable" border="1" class="hover" cellspacing="0"
		width="99%">
		<thead>
			<tr>
				<th width='10%' class="checkAll"><input class="select-checkbox"
					id="checkAll" type="checkbox" />全选</th>
				<th width='15%'>车辆</th>
				<th width='20%'>分组</th>
				<th width='10%' class="">出/入</th>
				<th width='20%'>围栏名称</th>
				<th width='15%'>时间</th>
				<th width='10%'>操作</th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<th width='10%' class="checkAll"><button id="deleteSelected">删除</button></th>
				<th width='15%'>车辆</th>
				<th width='20%'>分组</th>
				<th width='15%' class="">出/入</th>
				<th width='20%'>围栏名称</th>
				<th width='15%'>时间</th>
				<th width='10%'>操作</th>
			</tr>
		</tfoot>
	</table>
					</div> -->
				</div>
			</div>

			<!-- <div id="midToggleBar"></div> -->
			<div id="changeMap">
				<strong>切换地图：</strong><select name="" id="">
					<option selected="selected" value="BD">百度地图</option>
					<option value="GD">高德地图</option>
					<option value="GG">谷歌地图</option>
				</select>
			</div>
			<div class="col-lg-10 col-md-9 col-sm-9 col-xs-12"
				id="positionInnerIframeContainer">
				<div id="midToggleBar"></div>
				<iframe id="positionInnerIframe" name="positionInnerIframe"
					src="baidu.jsp" frameborder="0" scrolling="yes"
					style="width: 100%; height: 100%">浏览器不支持，请升级或更换浏览器</iframe>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.ztree.all.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/positionCenter.js"></script>
	<script>
		$(document).ready(function(){
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
			pIdKey:"pId",
			rootPId:0
			},
			keep:{
				parent:true
			}
			},
			async:{
			enable:true,
			dataType:"text",
			type:"get",
			url:"data/data2.json",
			dataFilter:ajaxDataFilter
			},
			callback:{
			onClick:function(event,treeId,treeNode){
				if((treeNode.pId!=null)&(treeNode.pId!=0)){
					sessionStorage.setItem("clickCarId",treeNode.id);
				}
			},
			onCheck:zTreeOnCheck
			}
			};
			$.fn.zTree.init($("#groupTree"),setting);
			function ajaxDataFilter(treeId,parentNode,responseData){
				if(responseData){
					for(var i=0;i<responseData.length;i++){
						if(responseData[i].pId==null){
							responseData[i].iconSkin="all"
						}else if(responseData[i].pId=="0"){
							responseData[i].iconSkin="group";
							responseData[i].isParent==true;
						}else{
						if(responseData[i].state=="1"){
							responseData[i].iconSkin="onLine"
						};
						if(responseData[i].state=="0"){
							responseData[i].iconSkin="offLine"
						}
					}
					}
				}
				return responseData;
			}
			;
			function zTreeOnCheck(event,treeId,treeNode){
				var a=[];
				var treeObj=$.fn.zTree.getZTreeObj("groupTree");
				var nodes=treeObj.getCheckedNodes();
				for(var i=0;i<nodes.length;i++){
					if(nodes[i].pId!='0'){
						a.push(nodes[i].id);
					}
				}
				var selectedCar=a.join(",");
				sessionStorage.setItem("selectedCar",selectedCar);
				//兼容IE8
				var browser=navigator.appName
				var b_version=navigator.appVersion
				var version=b_version.split(";");
				var trim_Version=version[1].replace(/[ ]/g,"");
				if(browser=="Microsoft Internet Explorer"&&trim_Version=="MSIE8.0"){
					alert("IE8")
					//sessionStorage.setItem("selectedMarkerId","");
					//sessionStorage.setItem("selectedFenceId","");
				}
			}
			//标注展示
			$("#positionTab li:eq(1)").click(function(){
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
				pIdKey:"pId",
				rootPId:0
				},
				keep:{
					parent:true
				}
				},
				async:{
				autoParam:["id","name","isParent"],
				enable:true,
				dataType:"text",
				type:"get",
				url:"data/biaozhu.json",
				dataFilter:function(treeId,parentNode,responseData){
					if(responseData){
						for(var i=0;i<responseData.length;i++){
							if(responseData[i].id=="0"){
								responseData[i].isParent==true;
								responseData[i].iconSkin="all"
							}
						}
					}
					return responseData;
				}
				},
				callback:{
				onClick:function(event,treeId,treeNode){
					if(treeNode.id!=0){
						sessionStorage.setItem("clickMarkerId",treeNode.id);
					}
				},
				onCheck:zTreeOnCheck1
				}
				};
				$.fn.zTree.init($("#markerTree"),setting1);
				function zTreeOnCheck1(event,treeId,treeNode){
					var b=[];
					var treeObj=$.fn.zTree.getZTreeObj("markerTree");
					var nodes=treeObj.getCheckedNodes();
					for(var i=0;i<nodes.length;i++){
						if(nodes[i].id!='0'){
							b.push(nodes[i].id);
						}
					}
					var selectedMarkerId=b.join(",");
					sessionStorage.setItem("selectedMarkerId",selectedMarkerId);
				}
			})
			//围栏展示
			$("#positionTab li:eq(2)").click(function(){
				var setting2={
				check:{
				enable:true,
				autoCheckTrigger:false,
				chkStyle:"radio",
				},
				data:{
				simpleData:{
				enable:true,
				idKey:"id",
				pIdKey:"pId",
				rootPId:0
				},
				keep:{
					parent:true
				},
				key:{
					name:"fenceName"
				}
				},
				async:{
				autoParam:["id","name","isParent"],
				enable:true,
				dataType:"text",
				type:"get",
				url:"data/fence.json",
				dataFilter:function(treeId,parentNode,responseData){
					if(responseData){
						for(var i=0;i<responseData.length;i++){
							if(responseData[i].fenceType=="rect"){
								responseData[i].iconSkin="rect";
							}else if(responseData[i].fenceType=="round"){
								responseData[i].iconSkin="round";
							}else{
								responseData[i].iconSkin="polygon";
							}
						}
					}
					return responseData;
				}
				},
				callback:{
					onCheck:function(event,treeId,treeNode){
						var treeObj=$.fn.zTree.getZTreeObj("fenceTree");
						var nodes=treeObj.getCheckedNodes();
						if(nodes!=""){
							var a=nodes[0].id;
							sessionStorage.selectedFenceId=a;
							//sessionStorage.setItem("selectedFenceId",nodes[0].id);
						}else{
							sessionStorage.setItem("selectedFenceId","");
						}
					}
				}
				};
				$.fn.zTree.init($("#fenceTree"),setting2);
			})
			//车辆搜索
			$('#keywordCar').bind('input propertychange',function(){
				var treeObj=$.fn.zTree.getZTreeObj("groupTree");
				var keywords=$("#keywordCar").val();
				var nodes=treeObj.getNodesByParamFuzzy("name",keywords);
				if(nodes.length>0){
					treeObj.selectNode(nodes[0]);
				}
			});
			//标注搜索
			$('#keywordMarker').bind('input propertychange',function(){
				var treeObj=$.fn.zTree.getZTreeObj("markerTree");
				var keywords=$("#keywordMarker").val();
				var nodes=treeObj.getNodesByParamFuzzy("name",keywords);
				if(nodes.length>0){
					treeObj.selectNode(nodes[0]);
				}
			});
			//围栏搜索
			$('#keywordFence').bind('input propertychange',function(){
				var treeObj=$.fn.zTree.getZTreeObj("fenceTree");
				var keywords=$("#keywordFence").val();
				var nodes=treeObj.getNodesByParamFuzzy("name",keywords);
				if(nodes.length>0){
					treeObj.selectNode(nodes[0]);
				}
			});
			//刷新时清空storage
			window.onbeforeunload=function(){
				sessionStorage.removeItem("selectedCar");
				sessionStorage.removeItem("clickCarId");
				sessionStorage.removeItem("clickMarkerId");
				sessionStorage.removeItem("selectedMarkerId");
				sessionStorage.removeItem("selectedFenceId");
			}
		});
	</script>
</body>
</html>