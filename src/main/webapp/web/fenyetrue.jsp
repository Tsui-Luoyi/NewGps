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
<!-- content的参数有all，none，index，noindex，follow，nofollow，默认是all -->
<meta name="robots" content="none">
<!-- 网页不会被缓存 -->
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<!-- 解决部分兼容性问题，如果安装了GCF，则使用GCF来渲染页面，如果未安装GCF，则使用最高版本的IE内核进行渲染。 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- 页面按原比例显示 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
  <![endif]-->
<style>
body {
	padding: 0 5px;
}

.sea {
	margin: 20px 0;
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
border:2px #000 solid;}
thead tr{
height:35px;}
tfoot tr{
height:35px;}
tr{
height:28px;}
#restartCustomTable tbody td a{
	margin-left:5px;
	background-color:#f7d2d2;
	}
	#restartCustomTable tbody td a:hover{
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
</style>
</head>
<body>
	<table class="sea" cellspacing="0" width="100%">
		<tr>
			<td width="10%"></td>
			<td width="25%">搜索客户：<input type="text" id="searchCustom" /></td>
			<td width="25%">搜索电话：<input type="number" id="searchTel" /></td>
			<td width="30%">搜索管理员：<input type="text" id="searchAdmin" />
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
			按<select name="sortBy" id="sortBy">
				<option value="creatTime" selected="selected">添加时间</option>
				<option value="customerName">客户名字</option>
				<option value="AdminName">客户管理员</option>
			</select> <select name="sortType" id="sortType">
				<option value="asc">升序</option>
				<option value="desc" selected="selected">降序</option>
			</select>排列
		</div>
	</div>
	<table id="restartCustomTable" border="1px" class="hover" cellspacing="0"
		width="99.5%">
		<thead>
			<tr>
				<th width='10%' class="checkAll"><input class="select-checkbox"
					id="checkAll" type="checkbox" />全选</th>
				<th width='30%'>客户名字</th>
				<th width='15%'>客户电话</th>
				<th width='15%' class="">添加时间</th>
				<th width='10%'>客户管理员</th>
				<th width='20%'>操作</th>
			</tr>
		</thead>
		<tbody></tbody>
		<tfoot>
			<tr>
				<th width='10%' class="checkAll"><button id="deleteSelected">删除选中</button></th>
				<th width='20%'>客户名字</th>
				<th width='15%'>客户电话</th>
				<th width='15%' class="">添加时间</th>
				<th width='15%'>客户管理员</th>
				<th width='25%'>操作</th>
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
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.dataTables.js"></script>
	<script src="js/dataTables.bootstrap.js"></script>
	<script src="js/datatable.select.js"></script>
	<script>
		$(function(){
			ajaxPaging();
			//查询时
			$("#findBtn").click(function(){
				$("#currentPage").val("1");
				ajaxPaging();
			});
			//每页条数改变时
			$("#pageSize,#sortBy,#sortType").change(function(){
				ajaxPaging();
			})
			//跳转时
			$("#jumpBtn").click(function(){
				if($("#currentPage").val()>$("#totalPage").html()){
					$("#currentPage").val($("#totalPage").html());
					ajaxPaging();
				}else if($("#currentPage").val()==''){
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
					$("#customTable tbody input[type='checkbox']").prop("checked",true);
				}else{
					$("#customTable tbody input[type='checkbox']").prop("checked",false);
					
				}
				;
			})
		})
		function ajaxPaging(){
			$.ajax({
			url:"data/truefenye1.json",
			type:"get",
			dataType:"json",
			contextType:"application/json;charset=utf-8",
			data:{data:JSON.stringify({
			"pageSize":$("#pageSize").val(),
			"pageNo":$("#currentPage").val(),
			"customername":$("#searchCustom").val(),
			"contact_phone":$("#searchTel").val(),
			"user_name":$("#searchAdmin").val(),
			"orderBy":$("#sortBy").val(),
			"order":$("#sortType").val()
			})},
			success:function(data){
				$("#restartCustomTable tbody").empty();
				$("#totalPage").html(data.totalPage);
				$("#totalRecord").html(data.totalRecord)
				for(var i=0;i<data.results.length;i++){
					var tr=$("<tr></tr>");
					var td1=$("<td><input type='checkbox' data-id='"+data.results[i].id+"'/></td>");
					var td2=$("<td>"+data.results[i].customername+"</td>");
					var td3=$("<td>"+data.results[i].contact_phone+"</td>");
					var td4=$("<td>"+data.results[i].creattime+"</td>");
					var td5=$("<td>"+data.results[i].user_name+"</td>");
					var td6=$("<td><a href='javascript:void(0);' onClick='restartThisCustomer(this)' data-id='"
							+data.results[i].id+"' class='down btn btn-default btn-xs'>重新启用</a>");
					$("#restartCustomTable tbody").append(tr);
					tr.append(td1);
					tr.append(td2);
					tr.append(td3);
					tr.append(td4);
					tr.append(td5);
					tr.append(td6);
				}
			},
			error:function(error){
				console.log(error);
			},
			async:true
			})
		}
		//删除函数
		function restartThisCustomer(obj){
			if(confirm("是否要启用所选客户?")){
				$.ajax({
				url:"data/customlist.json",
				type:"get",
				dataType:"json",
				data:{
					"id":obj.getAttribute("data-id")
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
		$("#deleteSelected").click(function(){
			
			var selectId=[];
			var aa=$("#customTable tbody input[type='checkbox']");
			for(var i=0;i<aa.length;i++){
				if($(aa[i]).prop("checked")){
					selectId.push($(aa[i]).attr("data-id"))
				}
			}
			if(selectId.length==0){
				alert("请选择要删除的客户")
			}else{
				if(confirm("是否要停用所选客户?")){
					$.ajax({
						url:"data/customlist.json",
						type:"get",
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