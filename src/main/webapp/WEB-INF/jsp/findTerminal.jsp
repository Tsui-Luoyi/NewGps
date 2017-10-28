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
<link rel="stylesheet" href="/NewRmgps/web/css/media.css">
<link rel="stylesheet" href="/NewRmgps/web/css/color.css">
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
  <![endif]-->
<style>
body {
	padding: 0 5px;
	width:100%;
	height:100%;
}
h4{
	font-weight:bold;
	margin-bottom:-30px;
}
.sea {
	margin: 30px 0 20px 0;
	padding: 10px 20px;
	text-align: center
}
#findBtn{
	margin-left:5px;
}
th, td {
	text-align: center;
}
thead,tfoot{
border:2px #9e9797 solid;
background-color:#a6d3ec;
}
thead tr{
height:35px;}
tfoot tr{
height:35px;}
tr{
height:28px;}
/* 表格样式 */
#terminalTable{
	background-color:#c4e0e0;
}
#terminalTable tbody td a{
	margin-left:5px;
	background-color:#f7d2d2;
	}
	#terminalTable tbody td a:hover{
		background-color:#fff;
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
	font-weight: bold; color : #000;
	border: 1px #000 solid;
	border-radius: 5px;
	color: #000;
}

#pageList li:hover {
	cursor: pointer; background-color : #000;
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
/* 禁用样式 */
#terminalTable tbody td .a-disable {
	margin-left: 5px;
	background-color: #fff;
	color: #5a5959;
}

#terminalTable tbody td .a-disable:hover {
	cursor: not-allowed;
}
.btn-disabled:hover{
	cursor: not-allowed;
}
</style>
</head>
<body>
<h4>查询终端:</h4>
	<table class="sea" cellspacing="0" width="100%">
		<tr>
			<td width="30%">搜索终端编号：<input type="text" id="searchCode" /></td>
			<td width="30%">搜索终端名字：<input type="text" id="searchName" /></td>
			<td width="40%">过期时间限制：<input type="text" id="searchInvailedtime" /><button id="findBtn">查询</button></td>
			<!-- <td width="40%"><button id="findBtn">查询</button></td> -->
			
			<!-- <td width="20%"><button>导出EXCEL</button></td> -->
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
		查看<select name="terminalStatus" id="terminalStatus">
				<option value="" selected="selected">所有</option>
				<option value=0>正常</option>
				<option value=1>新调拨</option>
				<option value=2>待退货</option>
				<option value=3>已退货</option>
			</select> 的
			<select name="terminalType" id="terminalType">
				<option value="" selected="selected">所有</option>
				<option value=1>LYBV5终端-1</option>
				<option value=2>LYBV5终端-2</option>
				<option value=3>BL百灵V1终端</option>
				<option value=4>YX有线V1终端</option>
			</select>终端，
			按<select name="sortBy" id="sortBy">
				<option value="code" selected="selected">终端编号</option>
				<option value="name">终端名称</option>
				<option value="status">终端状态</option>
				<option value="invailedtime">过期时间</option>
			</select> <select name="sortType" id="sortType">
				<option value="asc">升序</option>
				<option value="desc" selected="selected">降序</option>
			</select>排列
		</div>
	</div>
	<table id="terminalTable" border="1px" class="hover" cellspacing="0"
		width="99.5%">
		<thead>
			<tr>
				<th width='10%' class="checkAll"><input class="select-checkbox"
					id="checkAll" type="checkbox" />全选</th>
				<th width='25%'>终端编号</th>
				<th width='20%'>终端名字</th>
				<th width='15%'>终端状态</th>
				<th width='20%'>过期时间</th>
				<th width='10%'>操作</th>
			</tr>
		</thead>
		<tbody></tbody>
		<tfoot>
			<tr>
				<th width='10%' class="checkAll" id="bottomCheckbox"><input type='button' class='btn-disabled' id='deleteSelected' disabled='disabled' value='删除选中'/></th>
					<th width='25%'>终端编号</th>
				<th width='20%'>终端名字</th>
				<th width='15%'>终端状态</th>
				<th width='20%'>过期时间</th>
				<th width='10%'>操作</th>
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
	<script src="/NewRmgps/web/js/jedate/jedate.min.js"></script>
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
		$(function(){
			jeDate({
				dateCell:"#searchInvailedtime",
				format:"YYYY-MM-DD hh:mm:ss",
				//isinitVal:true,
				isTime:true, //isClear:false,
				minDate:"2000-01-01 00:00:00",
				//okfun:function(val){alert(val)}
			});
			$("#terminalStatus").change(function(){
				if($(this).val()=="2"){
					$("#bottomCheckbox").empty().append($("<input type='button' id='cancelSelected' value='取消退货'/>"))
				}else if($(this).val()=="3"){
					$("#bottomCheckbox").empty().append($("<input type='button' id='deleteSelected' value='删除选中'/>"))
				}else if($(this).val()=="0"){
					$("#bottomCheckbox").empty().append($("<input type='button' id='deleteSelected' value='删除选中'/>"))
				}else{
					$("#bottomCheckbox").empty().append($("<input type='button' id='deleteSelected' disabled='disabled' class='btn-disabled' value='删除选中'/>"))
				}
			})
			ajaxPaging();
			//查询时
			$("#findBtn").click(function(){
				$("#currentPage").val("1");
				ajaxPaging();
			});
			//每页条数改变时
			$("#pageSize,#sortBy,#sortType,#terminalStatus,#terminalType").change(function(){
				$("#currentPage").val("1");
				ajaxPaging();
			})
			//跳转时
			$("#jumpBtn").click(function(){
				if($("#currentPage").val()>$("#totalPage").html()){
					$("#currentPage").val($("#totalPage").html());
					ajaxPaging();
				}else if($("#currentPage").val()==''||$("#currentPage").val()<=0){
					$("#currentPage").val("1");
					ajaxPaging();
				}else{
					ajaxPaging();
				}
			});
			//首页
			$("#pageList #first").click(function(){
				if($("#currentPage").val()>1){
					$("#currentPage").val("1");
					ajaxPaging();
				}else{
					return false;
				}
			})
			//下一页
			$("#pageList #next").click(function(){
				if(($("#currentPage").val()-0)<($("#totalPage").html()-0)){
					$("#currentPage").val($("#currentPage").val()-0+1);
					ajaxPaging();
				}else{
					return false;
				}
			})
			//上一页
			$("#pageList #prev").click(function(){
				if($("#currentPage").val()>1){
					$("#currentPage").val($("#currentPage").val()-0-1);
					ajaxPaging();
				}else{
					return false;
				}
			})
			//尾页
			$("#pageList #last").click(function(){
				if(($("#currentPage").val()-0)<($("#totalPage").html()-0)){
					$("#currentPage").val($("#totalPage").html());
					ajaxPaging();
				}else{
					return false;
				}
			})
			//全选
			$("#checkAll").click(function(){
				if($(this).is(':checked')){
					$("#terminalTable tbody input[type='checkbox']").prop("checked",true);
				}else{
					$("#terminalTable tbody input[type='checkbox']").prop("checked",false);
					
				}
				;
			})
		})
		function ajaxPaging(){
			$.ajax({
			url:"/NewRmgps/Terminal/getTerminals",
			type:"post",
			dataType:"json",
			contextType:"application/json;charset=utf-8",
			data:{data:JSON.stringify({
			"pageSize":$("#pageSize").val(),
			"pageNo":$("#currentPage").val(),
			"code":$("#searchCode").val(),
			"name":$("#searchName").val(),
			"typeid":$("#terminalType").val(),
			"status":$("#terminalStatus").val(),
			"invailedtime":$("#searchInvailedtime").val(),
			/* "contact_phone":$("#searchTel").val(), */
			/* "user_name":$("#searchAdmin").val(), */
			"orderBy":$("#sortBy").val(),
			"order":$("#sortType").val()
			})},
			success:function(data){
				$("#terminalTable tbody").empty();
				$("#totalPage").html(data.totalPage);
				$("#totalRecord").html(data.totalRecord)
				if(data.results.length=="0"){
					var tr=$("<tr></tr>");
					var td=$("<td colspan='6'>没有记录</td>")
					$("#terminalTable tbody").append(tr);
					tr.append(td);
				}else{
				for(var i=0;i<data.results.length;i++){
					var tr=$("<tr></tr>");
					var td1=$("<td><input type='checkbox' data-id='"+data.results[i].code+"'/></td>");
					var td2=$("<td>"+data.results[i].code+"</td>");
					var td3=$("<td>"+data.results[i].name+"</td>");
					var td4,td6;
					if(data.results[i].status=="0"){
						td4=$("<td><span class='label label-primary'>正常</span></td>");
						td6=$("<td><a href='javascript:void(0);' onClick='' data-id='"
								+data.results[i].code+"' class='down btn btn-default btn-xs del a-disable'> 删除</a><a href='javascript:void(0);' onClick='returnTerminal(this)' data-id='"
								+data.results[i].code+"' class='down btn btn-default btn-xs del '> 退货</a></td>");
					}else if(data.results[i].status=="1"){
						td4=$("<td><span class='label label-danger'>新调</span></td>");
						td6=$("<td><a href='javascript:void(0);' onClick='' data-id='"
								+data.results[i].code+"' class='down btn btn-default btn-xs del a-disable'> 删除</a></td>");
					}else if(data.results[i].status=="2"){
						td4=$("<td><span class='label label-warning'>待退</span></td>");
						td6=$("<td><a href='javascript:void(0);' onClick='cancelThisTerminal(this)' data-id='"
								+data.results[i].code+"' class='down btn btn-default btn-xs del'> 取消退货</a></td>");
					}else{
						td4=$("<td><span class='label label-default'>已退</span></td>");
						td6=$("<td><a href='javascript:void(0);' onClick='deleteThisTerminal(this)' data-id='"
								+data.results[i].code+"' class='down btn btn-default btn-xs'> 删除</a></td>");
					}
					var td5=$("<td>"+getDateTime((data.results[i].invailedtime))+"</td>");
					$("#terminalTable tbody").append(tr);
					tr.append(td1);
					tr.append(td2);
					tr.append(td3);
					tr.append(td4);
					tr.append(td5);
					tr.append(td6);
				}
				}
			},
			error:function(error){
				alert("未知错误，请重试")
				console.log(error);
			},
			async:true
			})
		}
		//取消退货函数
		function cancelThisTerminal(obj){
			if(confirm("是否要取消该终端退货?")){
				$.ajax({
				url:"/NewRmgps/Terminal/returnsOffails",
				type:"get",
				dataType:"json",
				data:{
					"codes":obj.getAttribute("data-id")
				},
				success:function(data){
					$(obj).parents("tr").remove();
					ajaxPaging();
				},
				error:function(error){
					alert("操作失败，请重新操作！");
				},
				async:false
				})
			}
		}
		//删除函数
		function deleteThisTerminal(obj){
			if(confirm("是否要删该该终端?")){
				$.ajax({
				url:"/NewRmgps/Terminal/deleteTerminals",
				type:"post",
				dataType:"json",
				data:{
					"codes":obj.getAttribute("data-id")
				},
				success:function(data){
					$(obj).parents("tr").remove();
					ajaxPaging();
				},
				error:function(error){
					alert("操作失败，请重新操作！");
				},
				async:false
				})
			}
		}
		//退货函数
		function returnTerminal(obj){
			if(confirm("是否要退回该终端?")){
				$.ajax({
				url:"/NewRmgps/Terminal/returns",
				type:"post",
				dataType:"json",
				data:{
					"codes":obj.getAttribute("data-id")
				},
				success:function(data){
					$(obj).parents("tr").remove();
					ajaxPaging();
				},
				error:function(error){
					alert("操作失败，请重新操作！");
				},
				async:false
				})
			}
		}
	/* 删除选中*/
		$("#bottomCheckbox").on("click","#deleteSelected",function(){
			var selectId=[];
			var aa=$("#terminalTable tbody input[type='checkbox']");
			for(var i=0;i<aa.length;i++){
				if($(aa[i]).prop("checked")){
					selectId.push($(aa[i]).attr("data-id"))
				}
			}
			if(selectId.length==0){
				alert("请选择要删除所选终端")
			}else{
				if(confirm("是否要删除所选终端?")){
					$.ajax({
						url:"/NewRmgps/Terminal/deleteTerminals",
						type:"post",
						dataType:"json",
						data:{
						"codes":selectId.join(",")
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
		/* 取消退货状态 */
		$("#bottomCheckbox").on("click","#cancelSelected",function(){
			var selectId=[];
			var aa=$("#terminalTable tbody input[type='checkbox']");
			for(var i=0;i<aa.length;i++){
				if($(aa[i]).prop("checked")){
					selectId.push($(aa[i]).attr("data-id"))
				}
			}
			if(selectId.length==0){
				alert("请选择要取消退货的终端")
			}else{
				if(confirm("是否要取消所选终端的退货状态?")){
					$.ajax({
						url:"/NewRmgps/Terminal/returnsOffails",
						type:"post",
						dataType:"json",
						data:{
						"codes":selectId.join(",")
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