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
<link rel="stylesheet" href="/NewRmgps/web/css/positionCenter.css">
<link rel="stylesheet" href="/NewRmgps/web/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet" href="/NewRmgps/web/css/media.css">
<link rel="stylesheet" href="/NewRmgps/web/css/color.css">
<link rel="stylesheet" href="/NewRmgps/web/css/jedate.css">
<style>
html, body {
	width: 100%;
	height: 100%
}

body {
	position: relative;
}
/* 命令的蒙版 */
#mengBan {
	position: absolute;
	z-index: 20;
	top: 0;
	right: 0;
	bottom: 0;
	background:url("/NewRmgps/web/images/black.png")  no-repeat 0 0;
	display: none;
}
/* 绑定的div */
#commandDiv {
	position: absolute;
	z-index: 21;
	display: none;
	top:50%;
	right:50%;
	margin-top: -200px;
	margin-right:-200px;
	background-color: #dedede;
	border: 1px #000 solid;
	width: 400px;
	height: 400px;
}
/* 关闭按钮 */
#commandDiv h4 .close {
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

#commandDiv h4 .code {
	color: red;
	font-size: 14px
}

hr {
	margin: 5px 0;
	border: 1px #000 solid;
}

#commandWrap {
	max-height: 350px;
	min-height: 200px;
	overflow-y: scroll;
}
/* 所有的src公用类，开始隐藏 */
.command {
	display: none;
}
/* 命令窗口 */
#logWindow{
display:none;
    width: 600px;
    height: 120px;
    overflow:scroll;
    position: absolute;
    bottom: 5px;
    right: 182px;
    border: 2px red solid;
    background-color:#c4e0e0;
    z-index: 50;}
    #logWindow th{
    background-color:#6699cc;
    }
    #logWindow h5{
    font-weight:bolder;
    margin:0;
    padding:2px 0 10px 5px;
    background-color:#9ac6ea;
    }
    #windowmin,#windowmax{
    margin-right:5px;
    float:right;}
/* aa 模式选择 */
#time,#times,#uploadtime{
display:none;
}
#rMenu{
float:right;
	border:1px #000 solid;
	margin-left:3px;
	background-color:#fff;
	position:relative;
	z-index:10;
	color:red
}
#rMenu ul li{
	border-bottom:1px #000 dashed;
	font-size:12px;
}
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
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/group.png")
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

.ztree li span.button.offLine_ico_open, .ztree li span.button.offLine_ico_close
	{
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/offline.png");
}

.ztree li span.button.offLine_ico_docu {
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/offline.png");
}

.ztree li span.button.onLine_ico_docu {
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/online.png");
}

.ztree li span.button.onLine_ico_open, .ztree li span.button.onLine_ico_close
	{
	background-image: url("/NewRmgps/web/css/zTreeStyle/img/diy/online.png");
}

.ztree li span.button.terminal_ico_docu {
	background-image: url("/NewRmgps/web/images/GPS.png")
}
/* 矩形围栏图标 */
.ztree li span.button.rect_ico_docu {
	background-image: url("/NewRmgps/web/images/rect.png")
}

.ztree li span.button.round_ico_docu {
	background-image: url("/NewRmgps/web/images/round.png")
}

.ztree li span.button.polygon_ico_docu {
	background-image: url("/NewRmgps/web/images/polygon.png")
}

.ztree li span.button.marker_ico_docu {
	background-image: url("/NewRmgps/web/images/marker.png");
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
/* 点击中间按钮时，隐藏左边部分 */
.barClick {
	width: 100% !important;
}
</style>
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
<div id="logWindow">
	<h5>命令日志 
	<span id="windowmax"><img title="最大化" src="/NewRmgps/web/images/windowmax.png"/></span>
	<span id="windowmin"><img  title="最小化" src="/NewRmgps/web/images/windowmin.png"/></span>
	</h5>
		<table id="commandTable" border="1px" class="hover" cellspacing="0"
				width="99.5%">
				<thead>
					<tr>
						<th width='30%'>命令id</th>
						<th width='35%'>设置时间</th>
						<th width='35%'>命令状态</th>
						<!-- <th width='35%'>操作</th> -->
					</tr>
				</thead>
				<tbody></tbody>
				</table>
	</div>
<!-- 日志窗口 -->
	<div id='mengBan'>
	
	<div id="commandDiv">
		<div class="container-fluid">
			<div class="row-fluid">
				<h4>
					<span class="type"></span><span class="code"></span><span
						class='close' title="关闭">&times;</span>
				</h4>
				<hr />
			</div>
			<div class="row-fluid" id="commandWrap">
				<div
					class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10">
					<input type="hidden" id="commandId" value=""/>
					<!-- src="aa" -->
					<div class="command" id="aa">
					<p>模式选择: <select name="emergencyState" id="emergencyState">
							<option  value="safe" selected="selected">安全模式</option>
							<option  value="plan">计划模式</option>
							<option  value="emergency">紧急模式</option>
							<option  value="attention">关注模式</option>
						</select></p>
						<p id="time"> 时间: <input type="text" style="width: 50px;" name="hour0" id="hour0"/></p>
						<p id="uploadtime"> 间隔: <select name="upinterval" id="upinterval">
								<option id="upinterval_10" value="10">10分钟</option>
								<option id="upinterval_30" value="30">30分钟</option>
								<option id="upinterval_60" value="60">60分钟</option>
						</select></p>
						<p id="times"> 次数:<input name="residue"
							onkeyup="this.value=this.value.replace(/[^\d]/g,'') "
							value="${requestScope.vo.residue }" id="residue" type="text"
							size="3"> (范围(0~255),0为永久)</p>
						
					</div>
					<!-- src=“bb” -->
					<div class="command" id="bb">
						<p>
							上传周期设置： <select name="cycday" id="cycday">
								<option value="1" selected="selected">1天</option>
								<option value="2">2天</option>
								<option value="3">3天</option>
								<option  value="4">4天</option>
								<option  value="5">5天</option>
								<option  value="6">6天</option>
								<option  value="7">7天</option>
							</select>
						</p>
						<p>上传次数设置：<select name="everydayUpNum" id="everydayUpNum">
							<option id="everydayUpNum_1" value="1">1次</option>
							<option id="everydayUpNum_2" value="2">2次</option>
							<option id="everydayUpNum_3" value="3">3次</option>
							<option id="everydayUpNum_4" value="4">4次</option>
						</select></p>
						<p>预定上传时间： <input type="text" style="width: 50px;" name="hour"
							id="hour1" /></p>
					</div>
				</div>
			</div>
			<div class='row'>
				<div class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
				<!-- 保存命令ID，终端号在标题 -->
				<input type="hidden" value="">
					<button class="btn btn-info" id="commandSubmit">设置</button>
				</div>
			</div>
		</div>
	</div>
	</div>
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
								placeholder="">
						</div>
						<p id="notice">
							<strong>※注意：</strong>每次请不要选取太多车辆
						</p>
						<ul id="groupTree" class="ztree"></ul>
						<!-- 右键菜单 -->
						<!-- <div id="rMenu">
							<ul>

							</ul>
						</div>  -->
					</div>
					<div class="tab-pane fade" id="marker">
						<div id="searchMarker">
							<label>搜索标注:</label><input id="keywordMarker" type="text"
								placeholder="">
						</div>
						<ul id="markerTree" class="ztree"></ul>
					</div>
					<div class="tab-pane fade" id="fence">
						<div id="searchFence">
							<label>搜索围栏:</label><input id="keywordFence" type="text"
								placeholder="">
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
				<strong>切换地图：</strong><select name="changeMapSelect"
					id="changeMapSelect">
					<option selected="selected" value="BD">百度地图</option>
					<option value="GD">高德地图</option>
					<option value="GG">谷歌地图</option>
				</select>
			</div>
			<div class="col-lg-10 col-md-9 col-sm-9 col-xs-12"
				id="positionInnerIframeContainer">
				<div id="midToggleBar"></div>
				<iframe id="positionInnerIframe" name="positionInnerIframe"
					src="/NewRmgps/Terminal/tobaidu" frameborder="0" scrolling="yes"
					style="width: 100%; height: 100%">浏览器不支持，请升级或更换浏览器</iframe>
			</div>
		</div>
	</div>


	<script src="/NewRmgps/web/js/jquery.min.js"></script>
	<script type="text/javascript" src="/NewRmgps/web/js/jquery.ztree.all.js"></script>
<!-- 	<script type="text/javascript" src="/NewRmgps/web/js/jquery.ztree.exhide.js"></script> -->
	<script src="/NewRmgps/web/js/bootstrap.min.js"></script>
	<script src="/NewRmgps/web/js/positionCenter.js"></script>
	<script src="/NewRmgps/web/js/jedate.js"></script>
	<script>
		/* 参数设置菜单 */
		function getDateTime(date) {
		var date=new Date(date);
		if(date==null){
			return "";
		}
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1;
	    var day = date.getDate();
	    var hh = date.getHours();
	    var mm = date.getMinutes();
	    var ss = date.getSeconds();
	    return year + "-" + month + "-" + day + " " + hh + ":" + mm + ":" + ss;
	}
		function commandWindow(obj) {
			/* var _iframe = document.getElementById('positionInnerIframe').contentWindow;
	        var _div =_iframe.document.getElementById('mengban1');
	        _div.style.display = 'block'; */
	        console.log($(obj).attr("data-commandId"));
	        $("#commandDiv #commandId").val($(obj).attr("data-commandId"));
			$("#commandDiv .type").html($(obj).attr("data-command"));
			$("#commandDiv .code").html($(obj).attr("data-code"));
			$("#mengBan").width($("#positionInnerIframe").width());
			$("#mengBan").show();
			$("#commandDiv").show();
			$(".command").hide();
			var commandSrc=$(obj).attr("data-src");
			switch(commandSrc){
				case "00101.jsp":
					$("#aa").show();
					/* 初始化 */
					$("#emergencyState").val("safe");
					$("#time,#times,#uploadtime").hide();
					$("#hour0").val("00:00");
					$("#upinterval").val("10");
					$("#residue").val("0");
					$("#hour0").jeDate({
			            format:"hh:mm"
			        })
					break;
				case "bb":
					$("#bb").show();
					$("#cycday").val("1");
					$("#everydayUpNum").val("1");
					$("#hour1").val("00:00")
					$("#hour1").jeDate({
			            format:"hh:mm"
			        })
					break;
				default:
					return false;
			}
		}
		
		//aa当模式选择框变化时
$("#emergencyState").on("change",function(){
	if(($(this).val()=="safe")||($(this).val()=="attention")){
		$("#time,#times,#uploadtime").hide();
	}else if($(this).val()=="plan"){
		$("#time,#times,#uploadtime").show();
	}else{
		$("#time").hide();
		$("#times,#uploadtime").show();
	}
})
/* 设置命令关闭按钮 */
	$("#commandDiv .close").on("click",function(){
		/* 蒙版和命令窗口隐藏 */
		$("#mengBan,#commandDiv").hide();
		$("#rMenu").remove();
	});
	/* 取消默认浏览器菜单 */
	$("#mB2").bind("contextmenu", function(){
	    return false;
	})
	$("#mB2").mousedown(function(e) {
    console.log(e.which);
    //右键为3
    if (3 == e.which) {
       if($("#rMenu").size()>0){
    	   $("#rMenu").remove()
       }
    }
})
	/* 命令提交按钮 */
	$("#commandSubmit").on("click",function(){
		$.ajax({
			url:"/NewRmgps/Terminal/addCommandhistory",
			data:{
				"tcode":$("#commandDiv h4 span.code").html(),
				"commandName":$("#commandDiv h4 span.type").html(),
				"commandId":$("#commandDiv #commandId").val()
				/* 还有标题的终端code和隐藏域的命令id */
			},
			type:"post",
			success:function(data) {
				if(data){
					alert("命令提交成功！");
					$("#mengBan,#commandDiv").hide();
					$("#logWindow").show();
					$("#rMenu").remove();
					ajaxPaging() ;
				}else{
					alert("命令未设置成功，请重试！")
				}
}
	})
	})
	//命令窗口信息
	/* ajaxPaging(); */
	function ajaxPaging() {
			$.ajax({
						url : "/NewRmgps/Terminal/showComandhistories",
						type : "post",
						dataType : "json",
				/* 		contextType : "application/json;charset=utf-8", */
					data:{
					"tcode":$("#commandDiv h4 span.code").html(),
				},
						success : function(data) {
							$("#commandTable tbody").empty();
							$("#totalPage").html(data.totalPage);
							$("#totalRecord").html(data.totalRecord)
							if (data.length == "0") {
								var tr = $("<tr></tr>");
								var td = $("<td colspan='3'>没有记录</td>")
								$("#commandTable tbody").append(tr);
								tr.append(td);
							} else {
								console.log("else")
								for (var i = 0; i < data.length; i++) {
									console.log(i);
									var tr = $("<tr></tr>");
									var td1 = $("<td>"
											+ data[i].commandName
											+ "</td>");
									var td2 = $("<td>"
											+ getDateTime(data[i].sendTime.time)
											+ "</td>");
									var td3=$("<td>待处理</td>");
									/* var td4=$("<td><a href='changeGroup.jsp?id="
											+ data.results[i].id
											+ "&groupName="
											+ data.results[i].groupName
											+ "' target='_self' onClick='changeThisGroup(this)' data-id='"
											+ data.results[i].id
											+ "' class='down btn btn-default btn-xs'>修改</a><a href='javascript:void(0);' onClick='stopThisGroup(this)' data-id='"
											+ data.results[i].id
											+ "' class='down btn btn-default btn-xs'>停用</a>"
											+ "<a href='javascript:void(0);' onClick='deleteThisGroup(this)' data-id='"
											+ data.results[i].id
											+ "' class='down btn btn-default btn-xs del'> 删除</a>"); */
									$("#commandTable tbody").append(tr);
									tr.append(td1);
									tr.append(td2);
									tr.append(td3);
									/* tr.append(td4); */
								}
							}
						},
						error : function(error) {
							alert("未知错误，请重试")
							console.log(error);
						},
						async : true
					})
		}
		$(document).ready(
				function() {
					/*  中间按钮点击*/
					$("#midToggleBar").click(function() {
						if($("#mB2").css("display")=="block"){
							$("#mB2").css("display","none");
							/*  改变iframe的宽度*/
							$("#positionInnerIframeContainer").addClass("barClick");
							$(this).css({
								"left":"0",
								"border-right":"8px transparent solid",
								"border-left":"8px red solid"
							})
						}else{
							$("#positionInnerIframeContainer").removeClass("barClick");
							$("#mB2").css("display","block");
							$(this).css({
								"left":"-10px",
								"border-left":"8px transparent solid",
								"border-right":"8px red solid"
							})
						}
					})
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
							type:"post",
							url:"/NewRmgps/Terminal/showGVT",
							dataFilter:ajaxDataFilter
						},
						callback:{
							onRightClick:function (event,treeId,treeNode) {
								if(treeNode.type=="terminal"){//是终端
									console.log(treeNode.id)
									$.ajax({
										url:"/NewRmgps/Terminal/toCommandPage",
										data:{
											"code":treeNode.id
										},
										type:"post",
										timeout:3000,
										success:function(data) {
											console.log(data.commandList)
											$("#rMenu").remove();
											var aid=treeNode.tId+"_span";
											var div=$("<div id='rMenu'></div>");
											ul=$("<ul></ul>");
											ul.css("padding","0");
											$("#"+aid+"").after(div);
											div.append(ul);
											for(var i=0;i<data.commandList.length;i++){
												ul.append(
														$("<li onClick='commandWindow(this)' data-commandId='"+data.commandList[i].id+"' data-command='"+data.commandList[i].commandName+"' data-src='"
																+data.commandList[i].src+"' data-code='"+treeNode.id
																+"'>"+data.commandList[i].commandName+"</li>"));
											}
										},
										error:function(e) {
											alert("未知错误，请重试")
										},
										async:false
									});
								}
							},
							onClick:function(event,treeId,treeNode) {
									if(treeNode.type=="vehicle"){//是终端
										sessionStorage.setItem("clickCarId",treeNode.id);
								}
							},
							onCheck:zTreeOnCheck,
						
						}
					};
					$.fn.zTree.init($("#groupTree"),setting);
					function ajaxDataFilter(treeId,parentNode,responseData) {
						if(responseData){
							for(var i=0;i<responseData.length;i++){
								if(!responseData[i].pId){
									responseData[i].iconSkin="all"
								}else if(responseData[i].pId=="0"){
									responseData[i].iconSkin="group";
									responseData[i].isParent==true;
								}else{
									if(responseData[i].type=="vehicle"){
										responseData[i].iconSkin="vehicle";
										responseData[i].isParent==true;
									}else{
										responseData[i].iconSkin="terminal";
										responseData[i].nocheck=true;
									}
								}
							}
						}
						return responseData;
					};
					function zTreeOnCheck(event,treeId,treeNode) {
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

							//sessionStorage.setItem("selectedMarkerId","");
							//sessionStorage.setItem("selectedFenceId","");
						}
					}
					//标注展示
					$("#positionTab li:eq(1)").click(function() {
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
								dataFilter:function(treeId,parentNode,responseData) {
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
								onClick:function(event,treeId,treeNode) {
									if(treeNode.id!=0){
										sessionStorage.setItem("clickMarkerId",treeNode.id);
									}
								},
								onCheck:zTreeOnCheck1
							}
						};
						$.fn.zTree.init($("#markerTree"),setting1);
						function zTreeOnCheck1(event,treeId,treeNode) {
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
					$("#positionTab li:eq(2)").click(function() {
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
								dataFilter:function(treeId,parentNode,responseData) {
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
								onCheck:function(event,treeId,treeNode) {
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
					$('#keywordCar').bind('input propertychange',function() {
						var treeObj=$.fn.zTree.getZTreeObj("groupTree");
						var keywords=$("#keywordCar").val();
						if(keywords!=""){
							var nodes=treeObj.getNodesByParamFuzzy("name",keywords);
							if(nodes.length>0){
								/* console.log(treeObj.getNodes())
								treeObj.hideNodes( treeObj.getNodes().children.children);
								console.log(nodes)
								treeObj.showNodes(nodes); */
								for(var i=0;i<nodes.length;i++){
									treeObj.selectNode(nodes[i],true);
								}
								
							}
						}else{
							treeObj.cancelSelectedNode();
						}
					});
					//标注搜索
					$('#keywordMarker').bind('input propertychange',function() {
						var treeObj=$.fn.zTree.getZTreeObj("markerTree");
						var keywords=$("#keywordMarker").val();
						var nodes=treeObj.getNodesByParamFuzzy("name",keywords);
						if(nodes.length>0){
							treeObj.selectNode(nodes[0]);
						}
					});
					//围栏搜索
					$('#keywordFence').bind('input propertychange',function() {
						var treeObj=$.fn.zTree.getZTreeObj("fenceTree");
						var keywords=$("#keywordFence").val();
						var nodes=treeObj.getNodesByParamFuzzy("fenceName",keywords);
						console.log(nodes)
						if(nodes.length>0){
							treeObj.selectNode(nodes[0]);
						}
					});
					//刷新时清空storage
					window.onbeforeunload=function() {
						sessionStorage.removeItem("selectedCar");
						sessionStorage.removeItem("clickCarId");
						sessionStorage.removeItem("clickMarkerId");
						sessionStorage.removeItem("selectedMarkerId");
						sessionStorage.removeItem("selectedFenceId");
					}
					/*  地图改变事件*/
					$("#changeMapSelect").on("change",function() {
						var mapType=$(this).val();
						switch(mapType){
							case "GD":
								$("#positionInnerIframe").attr("src","GD.jsp");
								break;
							case "BD":
								$("#positionInnerIframe").attr("src","baidu.jsp")
								break;
							case "GG":
								alert("谷歌地图");
								break;
							default:
								return false;
						}
						/* 转换地图后分组处于显示状态 */
						$("#positionTab li a").eq(0).trigger("click");
						/*  清空存储*/
						sessionStorage.removeItem("selectedCar");
						sessionStorage.removeItem("clickCarId");
						sessionStorage.removeItem("clickMarkerId");
						sessionStorage.removeItem("selectedMarkerId");
						sessionStorage.removeItem("selectedFenceId");
						$.fn.zTree.init($("#groupTree"),setting);
						
					})
				});
	</script>
</body>
</html>