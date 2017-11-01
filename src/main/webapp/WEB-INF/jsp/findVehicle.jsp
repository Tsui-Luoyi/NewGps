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
<link href="/NewRmgps/web/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="/NewRmgps/web/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link rel="stylesheet" href="/NewRmgps/web/css/media.css">
<link rel="stylesheet" href="/NewRmgps/web/css/color.css">
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
  <![endif]-->
<style>
html, body {
	width: 100%;
	height: 100%;
	position: relative;
}

h4 {
	font-weight: bold;
	margin-top: 0px;
	padding: 10px 0 0 5px;
}
.sea {
	margin: 20px 0;
	padding: 10px 20px;
	text-align: center
}
#findBtn {
	margin-left: 5px;
	float:left;
}
th, td {
	text-align: center;
}
thead, tfoot {
	border: 2px #9e9797 solid;
	background-color: #a6d3ec;
}
thead tr {
	height: 35px;
}

tfoot tr {
	height: 35px;
}

tr {
	height: 28px;
}
/* 表格样式 */
#vehicleTable {
	background-color: #c4e0e0;
}

#vehicleTable tbody td a {
	margin-left: 5px;
	background-color: #f7d2d2;
}

#vehicleTable tbody td a:hover {
	background-color: #fff;
}

#pageSizeDiv, #sortDiv {
	font-size: 16px;
	font-weight: bolder;
	float: left;
	height: 20px;
	line-height: 20px;
}

#pageSetting select {
	font-size: 14px;
	font-weight: 400
}

#pageSetting {
	overflow: hidden;
	margin-bottom: 10px;
}

#sortDiv {
	margin-left: 50px;
}

#pageList {
	float: right;
	margin-right: 50px;
}

#pageList li {
	list-style: none;
	display: inline-block;
	padding: 3px 5px;
	background-color: #99CCFF;
	font-weight: bold;
	color: #000;
	border: 1px #000 solid;
	border-radius: 5px;
	color: #000;
}

#pageList li:hover {
	cursor: pointer;
	background-color: #000;
	color: #fff;
	background-color: #000;
}

#pageFoot {
	margin-top: 10px;
}

#totalRecordDiv {
	float: left;
}

#totalRecord, #totalPage {
	font-weight: bolder;
}

#jump {
	float: left;
	margin-left: 50px;
}

#currentPage {
	width: 30px;
}
/*  上面搜索框*/
#searchlicense_plate, #searchTerminalNum, #searchVehicleGroup {
	width: 120px;
}
/* 禁用样式 */
#vehicleTable tbody td .a-disable {
	margin-left: 5px;
	background-color: #fff;
	color: #5a5959;
}
/* 已停用的车辆查看绑定终端按钮 */
#vehicleTable tbody td .a-disable-one{
background-color: inherit;
color:#9e9696;
}
#vehicleTable tbody td .a-disable-one:hover{
cursor: not-allowed;
}
#vehicleTable tbody td .a-disable:hover {
	cursor: not-allowed;
}
/* 查看终端的ul li */
td ul {
	list-style: none;
	padding: 0;
	margin: 0;
	margin-top: 2px;
}

td ul li {
	border-top: 1px #000 dashed;
	margin: 0 20px;
	padding-left: 5px;
	text-indent: 5px;
}

.terminalClose {
	text-align: left;
}

#vehicleTable tbody .terminalClose {
	background-color: inherit;
}

#vehicleTable tbody .terminalClose:hover {
	background-color: inherit;
	cursor: pointer;
	text-decoration: none;
}

.terminalClose img {
	margin: 0 2%;
}

/* 绑定车辆的蒙版 */
#mengBan {
	position: absolute;
	z-index: 20;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #000;
	opacity: 0.7;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=70);
	display:none;
}
/* 绑定的div */
#bindDiv{
position: absolute;
	z-index: 21;
	display: none;
	top: 50%;
	left: 50%;
	margin-left: -300px;
	margin-top: -250px;
	background-color: #dedede;
	border: 1px #000 solid;
	width: 600px;
	height: 500px;
	opacity: 1.85;
}
/* 关闭按钮 */
#bindDiv h4 span{
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
#terminalWrap{
	max-height: 350px;
	min-height: 200px;
	overflow-y: scroll;
}
.ztree li span.button.all_ico_open {
	background-image: url("/NewRmgps/web/images/all-2.png")
}

.ztree li span.button.all_ico_close {
	background-image: url("/NewRmgps/web/images/all-1.png")
}

.ztree li span.button.terminal_ico_docu {
	background-image: url("/NewRmgps/web/images/GPS.png")
}
</style>
</head>
<body>
	<div id='mengBan'></div>
	<div id="bindDiv">
		<div class="container-fluid">
			<div class="row-fluid">
				<h4>
					选择终端:<span title="关闭">&times;</span>
				</h4>
				<hr/>
			</div>
			<div  class="row-fluid" id="terminalWrap"> 
			<div class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center">
			<ul id="terminalTree" class="ztree"></ul>
			</div>
			</div>
			<div class='row'><div class="col-lg-push-1 col-md-push-1 col-sm-push-1 col-lg-7 col-md-7 col-sm-7 col-xs-10 text-center"><button class="btn btn-info" id="terminalSubmit">提交</button> </div></div>
		</div>
	</div>
	<h4>查询车辆:</h4>
	<table class="sea" cellspacing="0" width="100%">
		<tr>
			<td width="10%"></td>
			<td width="25%">搜索车牌号：<input type="text" id="searchlicense_plate" /></td>
			
			<td width="30%">
				<button id="findBtn">查询</button></td>
			<td width="10%"></td>
		</tr>
	</table>
	<div id="pageSetting">
		<div id="pageSizeDiv">
			每页显示<select name="pageSize" id="pageSize">
				<option value="10" selected="selected">10</option>
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
			</select>条数据
		</div>
		<div id="sortDiv">
		查看<select name="type" id="type">
				<option value="" selected="selected">所有</option>
				<option value=0>未停用</option>
				<option value=1>已停用</option>
			</select>
			车辆，
			按<select name="sortBy" id="sortBy">
				<option value="createtime" selected="selected">添加时间</option>
				<option value="LICENSE_PLATE">车牌号码</option>
				<!-- <option value="terminalNum">终端号码</option>
				<option value="vehicleGroup">车辆分组</option> -->
			</select> <select name="sortType" id="sortType">
				<option value="asc">升序</option>
				<option value="desc" selected="selected">降序</option>
			</select>排列
		</div>
	</div>
	<table id="vehicleTable" border="1px" class="hover" cellspacing="0"
		width="99.5%">
		<thead>
			<tr>
				<th width='10%' class="checkAll"><input class="select-checkbox"
					id="checkAll" type="checkbox" />全选</th>
				<th width='20%'>车牌号码</th>
				<th width='30%'>绑定终端</th>
				<th width='20%'>添加时间</th>
				<!-- <th width='15%'>车辆分组</th> -->
				<th width='20%'>操作</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<th width='10%' class="checkAll"><button id="deleteSelected">删除选中</button></th>
				<th width='20%'>车牌号码</th>
				<th width='30%'>绑定终端</th>
				<th width='20%' class="">添加时间</th>
				<!-- <th width='15%'>车辆分组</th> -->
				<th width='20%'>操作</th>
			</tr>
		</tfoot>
	</table>
	<div id="pageFoot">
		<div id="totalRecordDiv">
			共<span id="totalRecord"></span>条数据
		</div>
		<div id="jump">
			第<input id="currentPage" type="text" value="1" />页/共<span
				id="totalPage"></span>页
			<button id="jumpBtn">跳转</button>
		</div>
		<ul id="pageList">
			<li id="first">首页</li>
			<li id="prev">上一页</li>
			<li id="next">下一页</li>
			<li id="last">尾页</li>
		</ul>
	</div>
	<script src="/NewRmgps/web/js/jquery.min.js"></script>
	<script src="/NewRmgps/web/js/bootstrap.min.js"></script>
		<script src="/NewRmgps/web/js/jquery.ztree.all.js"></script>
	<script>
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
		$(function() {
			ajaxPaging();
			//查询时
			$("#findBtn").click(function() {
				$("#currentPage").val("1");
				ajaxPaging();
			});
			//每页条数改变时
			$("#pageSize,#sortBy,#sortType,#type").change(function() {
				$("#currentPage").val("1");
				ajaxPaging();
			})
			//跳转时
			$("#jumpBtn").click(
					function() {
						if ($("#currentPage").val() > $("#totalPage").html()) {
							$("#currentPage").val($("#totalPage").html());
							ajaxPaging();
						} else if ($("#currentPage").val() == ''
								|| $("#currentPage").val() <= 0) {
							$("#currentPage").val("1");
							ajaxPaging();
						} else {
							ajaxPaging();
						}
					});
			//首页
			$("#pageList #first").click(function() {
				if ($("#currentPage").val() > 1) {
					$("#currentPage").val("1");
					ajaxPaging();
				} else {
					return false;
				}
			})
			//下一页
			$("#pageList #next").click(
					function() {
						if (($("#currentPage").val() - 0) < ($("#totalPage")
								.html() - 0)) {
							$("#currentPage").val(
									$("#currentPage").val() - 0 + 1);
							ajaxPaging();
						} else {
							return false;
						}
					})
			//上一页
			$("#pageList #prev").click(function() {
				if ($("#currentPage").val() > 1) {
					$("#currentPage").val($("#currentPage").val() - 0 - 1);
					ajaxPaging();
				} else {
					return false;
				}
			})
			//尾页
			$("#pageList #last").click(
					function() {
						if (($("#currentPage").val() - 0) < ($("#totalPage")
								.html() - 0)) {
							$("#currentPage").val($("#totalPage").html());
							ajaxPaging();
						} else {
							return false;
						}
					})
			//全选licensePlate
			$("#checkAll").click(
					function() {
						if ($(this).is(':checked')) {
							$("#vehicleTable tbody input[type='checkbox']")
									.prop("checked", true);
						} else {
							$("#vehicleTable tbody input[type='checkbox']")
									.prop("checked", false);

						}
						;
					})
		})
		function ajaxPaging() {
			$.ajax({
						url : "/NewRmgps/Vehicle/getVehicles",
						type : "post",
						dataType : "json",
						contextType : "application/json;charset=utf-8",
						data : {
							data : JSON.stringify({
								"pageSize" : $("#pageSize").val(),
								"pageNo" : $("#currentPage").val(),
								"licensePlate" : $("#searchlicense_plate").val(),
								"terminalNum" : $("#terminalTel").val(),
								"vehicleGroup" : $("#vehicleGroup").val(),
								"orderBy" : $("#sortBy").val(),
								"del":$("#type").val(),
								"order" : $("#sortType").val()
							})
						},
						success : function(data) {
							$("#vehicleTable tbody").empty();
							$("#totalPage").html(data.totalPage);
							$("#totalRecord").html(data.totalRecord)
							if (data.results.length == "0") {
								var tr = $("<tr></tr>");
								var td = $("<td colspan='5'>没有记录</td>")
								$("#vehicleTable tbody").append(tr);
								tr.append(td);
							} else {
								for (var i = 0; i < data.results.length; i++) {
									if (!data.results[i].del) {
										var tr = $("<tr></tr>");
										var td1 = $("<td><input type='checkbox' data-id='"+data.results[i].id+"'/></td>");
										var td2 = $("<td>"
												+ data.results[i].licensePlate
												+ "</td>");
										var td3 = $("<td class='changeTeminal'><a class='terminalClose' onClick='checkTerminal(this)' title='查看车辆绑定终端'  data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "'><img src='/NewRmgps/web/images/plus.png'/>查看绑定终端</a></td>");
										var td4 = $("<td>"
												+ getDateTime(data.results[i].createtime)
												+ "</td>");
										/* var td5 = $("<td>"
												+ data.results[i].vehiclegroup
												+ "</td>"); */
										var td6 = $("<td><a href='/NewRmgps/Vehicle/toChangeVehicle?license_plate="+data.results[i].licensePlate+"' target='_self' title='修改车辆信息' onClick='' data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs'>修改</a>"
												+ "<a href='javascript:void(0);' onClick='stopThisVehicle(this)' data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs'>停用</a>"
												+ "<a href='javascript:void(0);' onClick='bindThisVehicle(this)' data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs'>绑定</a>"
												+ "<a href='javascript:void(0);' onClick='stopThisVehicle(this)' data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs del'> 删除</a></td>");
										$("#vehicleTable tbody").append(tr);
										tr.append(td1);
										tr.append(td2);
										tr.append(td3);
										tr.append(td4);
										/* tr.append(td5); */
										tr.append(td6);
									} else {
										var tr = $("<tr class='tr-disable'></tr>");
										var td1 = $("<td><input type='checkbox' data-id='"+data.results[i].id+"'/></td>");
										var td2 = $("<td>"
												+ data.results[i].licensePlate
												+ "</td>");
										var td3 = $("<td class='changeTeminal'><a class='terminalClose a-disable-one' onClick='' title='查看车辆绑定终端'  data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "'><img src='/NewRmgps/web/images/plus.png'/>查看绑定终端</a></td>");
										var td4 = $("<td>"
												+ getDateTime((data.results[i].createtime))
												+ "</td>");
										/* var td5 = $("<td>"
												+ data.results[i].vehiclegroup
												+ "</td>"); */
										var td6 = $("<td><a href='javascript:void(0);' title='修改车辆信息' data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs a-disable'>修改</a>"
												+ "<a href='javascript:void(0);'data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs' onClick='restartThisVehicle(this)'>重启</a>"
												+ "<a href='javascript:void(0);' data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs a-disable'>绑定</a>"
												+ "<a href='javascript:void(0);' data-name='"
												+ data.results[i].licensePlate
												+ "' data-id='"
												+ data.results[i].id
												+ "' class='down btn btn-default btn-xs a-disable'> 删除</a></td>");
										$("#vehicleTable tbody").append(tr);
										tr.append(td1);
										tr.append(td2);
										tr.append(td3);
										tr.append(td4);
										/* tr.append(td5); */
										tr.append(td6);
									}
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

		//删除函数
		function deleteThisVehicle(obj) {
			if (confirm("是否要删除所选车辆\r\r" + obj.getAttribute('data-name') + "?")) {
				$.ajax({
					url : "/NewRmgps/Vehicle/deleteVehicle",
					type : "post",
					dataType : "json",
					data : {
						"id" : obj.getAttribute("data-id")
					},
					success : function(data) {
						$(obj).parents("tr").remove();
						ajaxPaging();
					},
					error : function(error) {
						alert("操作失败，请重新操作！");
					},
					async : false
				})
			}
		}
		/*  停用*/
		function stopThisVehicle(obj) {
			if (confirm("是否要停用车辆：\r\r" + obj.getAttribute('data-name') + "?")) {
				$.ajax({
					url : "/NewRmgps/Vehicle/stopVehicle",
					type : "post",
					dataType : "json",
					data : {
						"id" : obj.getAttribute("data-id")
					},
					success : function(data) {
						$(obj).parents("tr").remove();
						ajaxPaging();
					},
					error : function(error) {
						alert("操作失败，请重新操作！");
					},
					async : false
				})
			}
		}
		//重启按钮，重启单个车辆
		function restartThisVehicle(obj) {
			if (confirm("是否要重新启用所选车辆\r\r" + obj.getAttribute('data-name') + "?")) {
				$.ajax({
					url : "/NewRmgps/Vehicle/restartVehicle",
					type : "get",
					dataType : "json",
					data : {
						"id" : obj.getAttribute("data-id")
					},
					success : function(data) {
						$(obj).parents("tr").remove();
						ajaxPaging();
					},
					error : function(error) {
						alert("操作失败，请重新操作！");
					},
					async : false
				})
			}
		}
		/*  修改车辆信息*/
		function changeThisVehicle(obj) {
			obj.getAttribute("data-id")
		}
		//查看绑定终端
		function checkTerminal(obj) {
			console.log($(obj).parents("td").find("ul"))
			$
					.ajax({
						url : "/NewRmgps/Terminal/getVTerminals",
						type : "post",
						data : {
							"vehicleId" : obj.getAttribute("data-id")
						},
						success : function(data) {
							if (!$(obj).parents("td").find("ul").size()) {
								$(obj).find("img")
										.attr("src", "/NewRmgps/web/images/min.png");
								var ul = $("<ul></ul>");
								$(obj).parents("td").append(ul);
								if (data.length) {
									for (var i = 0; i < data.length; i++) {
										var li = $("<li>"+ data[i].tcode+"<a href='javascript:void(0); ' class='down btn btn-default btn-xs' onClick='unBindTerminal(this)' data-terminal='"+ data[i].tcode
										+ "' data-id='"+ obj.getAttribute("data-id")+ "'>解绑</a><a href='/NewRmgps/Terminal/toCommandPage?code="+ data[i].tcode+" ' target='_self' class='down btn btn-default btn-xs' onClick='' data-terminal='"
										+ data[i].tcode+ "' data-id='"+ obj.getAttribute("data-id")+"'>设置命令</a></li>");
										$(obj).parents("td").find("ul").append(
												li);
									}
								} else {
									var li = $("<li style='color:red'>没有绑定终端</li>");
									$(obj).parents("td").find("ul").append(li);
								}
							} else {
								$(obj).find("img").attr("src","/NewRmgps/web/images/plus.png");
								$(obj).parents("td").find("ul").remove();
							}
						},
						error : function(error) {
							alert("操作失败，请重新操作！");
						},
						async : true
					})
		}
		var selectedTerminal=[];
		/*终端树设置  */
		var terminalSetting={
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
				key:{"name":"code"},
				keep:{
					parent:true
				}
				},
				async:{
				enable:true,
				dataType:"json",
				type:"post",
				url:"/NewRmgps/Terminal/getUTerminals",
				dataFilter:function(treeId,parentNode,responseData){
					if(responseData){
						for(var i=0;i<responseData.length;i++){
							if(responseData[i].id=="0"){
								responseData[i].iconSkin="all";
								responseData[i].open="true"
							}else{
								responseData[i].iconSkin="terminal"
							}
							;
						}
					}
					return responseData;
				}
				},
				callback:{
				onClick:function(event,treeId,treeNode){
					if((treeNode.pId!=null)&(treeNode.pId!=0)){}
				},
				onCheck:function(event,treeId,treeNode){
					selectedTerminal=[];
					var treeObj=$.fn.zTree.getZTreeObj("terminalTree");
					var nodes=treeObj.getCheckedNodes();
					for(var i=0;i<nodes.length;i++){
							selectedTerminal.push(nodes[i].code);
					}
				}
				}
				};
		//绑定操作
		function bindThisVehicle(obj){
			$("#mengBan").show();
			$("#bindDiv").show();
			//初始化
			$.fn.zTree.init($("#terminalTree"),terminalSetting);
			//提交
			$("#terminalSubmit").unbind("click").bind("click",function(){
				if (confirm("是否要绑定所选终端?")) {
					$.ajax({
						url : "/NewRmgps/Terminal/AddTvband",
						type : "post",
						data : {
							"codes" : selectedTerminal.join(","),
							"vehicleId" : obj.getAttribute("data-id")
						},
						success : function(data) {
							$("#mengBan").hide();
							$("#bindDiv").hide();
							ajaxPaging();
						},
						error : function(error) {
							alert("操作失败，请重新操作！");
						},
						async : false
					})
				}
			})
		}
		//终端绑定关闭按钮
		$("#bindDiv span").click(function(){
			$("#mengBan").hide();
			$("#bindDiv").hide();
			selectedTerminal=null;
		})
		//解绑终端
		function unBindTerminal(obj) {
			if (confirm("是否要解绑所选终端\r\r" + obj.getAttribute('data-terminal')
					+ "?")) {
				$.ajax({
					url : "/NewRmgps/Terminal/deleteTvband",
					type : "post",
					data : {
						"vehicleId" : obj.getAttribute("data-id"),
						"code" : obj.getAttribute("data-terminal")
					},
					success : function(data) {
						$(obj).parents("li").remove();
						ajaxPaging();
					},
					error : function(error) {
						alert("操作失败，请重新操作！");
					},
					async : false
				})
			}
		}
		$("#deleteSelected").click(function() {
			var selectId = [];
			var aa = $("#vehicleTable tbody input[type='checkbox']");
			for (var i = 0; i < aa.length; i++) {
				if ($(aa[i]).prop("checked")) {
					selectId.push($(aa[i]).attr("data-id"))
				}
			}
			if (selectId.length == 0) {
				alert("请选择要删除的车辆")
			} else {
				if (confirm("是否要停用所选车辆?")) {
					$.ajax({
						url:"/NewRmgps/Vehicle/deleteVehicles",
						type:"post",
						dataType:"json",
						data:{
						"selectId":selectId.join(",")
						},
						success:function(data){
							ajaxPaging();
							$("#checkAll").prop("checked",false);
						},
						error:function(error){
							alert("操作失败，请重新操作！");
						},
						async:false
						})
				}
			}
		})
	</script>
</body>
</html>