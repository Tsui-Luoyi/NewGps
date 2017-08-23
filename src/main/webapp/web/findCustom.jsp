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
#jump {
	display: inline-block;
}

#jump input {
	width: 30px;
}

.sea {
	margin: 20px 0;
	padding: 10px 20px;
	text-align: center
}

#customTable td, th {
	text-align: center;
}

#customTable .checkAll {
	font-size: 12px;
	padding: 10px;
	padding-right: 0;
	text-align: left;
}

#customTable td.select-checkbox {
	text-align: left;
}

.pagination>li>a:hover {
	
}

.dataTables_wrapper .dataTables_paginate .paginate_button {
	padding: 0;
	margin: 2px 5px;
	border: none;
	background-color: transparent;
}

.dataTables_wrapper .dataTables_paginate .paginate_button:hover {
	padding: 0;
	margin: 2px 5px;
	border: none;
	background-color: transparent;
}

.pagination>li>a:focus {
	background-color: #79acdf;
	color: #fff;
}

.pagination>li>a:hover {
	background-color: #79acdf;
	color: #fff;
}

table.dataTable thead .sorting_asc:after {
	content: "";
}

table.dataTable thead .sorting:after {
	opacity:;
	content: "";
}

table.dataTable thead .sorting_desc:after {
	content: "";
}

table.dataTable thead .sorting {
	background-image: url("images/sort-1.png");
}
/* 跳转多少页 */
#jump {
	float: left;
	margin-right: 10px;
	margin-top: 7px;
}

td a.down {
	margin-right: 5px;
	background-color: #f7d2d2;
}

td a.del {
	margin-right: 5px;
	background-color: #f7d2d2;
}
#customTable_filter{
margin-right:10px;}
</style>
</head>
<body>
	<table class="sea" cellspacing="0" width="100%">
		<tr>
			<td style="display: none"></td>
			<td style="display: none"></td>
			<td style="display: none"></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<table id="customTable" border="1px" class="hover" cellspacing="0"
		width="99%">
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
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.dataTables.js"></script>
	<script src="js/dataTables.bootstrap.js"></script>
	<script src="js/datatable.select.js"></script>
	<script>
		$(document).ready(function(){
			intDataTable()
		});
		//每列添加搜索框
		$(document).ready(function(){
			$('#customTable thead th').each(function(ind,val){
				var title=$('#customTable thead th').eq($(this).index()).text();
				$(".sea tr td").eq(ind).html(title+':&nbsp;<input type="text" placeholder="请输入'+title+'"/>');
			});
			var table=$('#customTable').DataTable();
			table.columns().eq(0).each(function(ind,val){
				$(".sea input").on('keyup change',function(){
					//$('#ceshi').DataTable().column(ind).search(
					table.column(ind).search($('.sea input').eq(ind).val());
					table.draw();
				});
			});
			//搜索事件，当有内容时才搜索
			var flag=true;
			$(".sea input").blur(function(){
				$(".sea input").each(function(ind,val){
					if($(this).val()!=""){
						flag=false;
					}
				})
				if(flag){
					$('#customTable').DataTable();
				}
			})
		});
		//跳转页面
		$(function(){
			$('#customTable').on('draw.dt',function(){
				if($("#jump").size()!=1){
					var dd=$("<div id='jump'>跳转到第<input type='text' value='1'/>页<button>Go！</button></div>");
					dd.prependTo($(".pagination"));
				}
				$("#jump button").click(function(){
					var page=$("#jump input").val();
					$('#customTable').DataTable().page(parseInt(page)-1).draw(false);
					$("#jump input").val(page);
				})
			});
		})
		//datatable默认初始化设置
		$.extend($.fn.dataTable.defaults,{
		"dom":'<"headerTop"lf>rt<"footBottom"rip><"clear">',
		"paging":true,
		/*分页按钮类型*/
		"pagingType":"full",
		"stateSave":false,
		//等待状态
		"processing":true,
		//排序
		"ordering":true,
		//第四列降序asc是升序
		"order":[[3,"desc"]],
		//每页显示多少条数据
		"aLengthMenu":[10,25,50,100],
		//共多少页，当前第几页
		"info":true,
		//中文显示
		"language":{
		"search":"快速搜索:",
		"processing":"正在查询中...",
		"lengthMenu":"每页 _MENU_ 条记录",
		"zeroRecords":"没有找到记录",
		"info":"第_PAGE_页(总共_PAGES_页)",
		"infoEmpty":"无记录",
		"infoFiltered":"(从 _MAX_ 条记录过滤)",
		'paginate':{
		'next':'下页',
		'previous':'上页',
		"sFirst":"首页",
		"sLast":"末页"
		}
		},
		"columns":[{},{
			"data":"clientName"
		},{
			"data":"clientTel"
		},{
			"data":"creatTime"
		},{
			"data":"clientAdminName"
		}],
		//改变第五列
		"columnDefs":[
				{
				//定义操作列,
				"targets":5,
				//添加删除等按钮
				"render":function(data,type,row){
					var html="<a href='javascript:void(0);' onClick='stopThisCustom("+row.id
							+")'  class='down btn btn-default btn-xs'><i class='fa fa-arrow-down'></i>停用</a>"
					html+="<a href='javascript:void(0);' onClick='deleteThisCustom("+row.id
							+")'  class='down btn btn-default btn-xs del'><i class='fa fa-arrow-down'></i> 删除</a>"
					return html;
				}
				},{
				"orderable":false,
				"className":'select-checkbox',
				"targets":0,
				"render":function(data,type,row){
					return "<input type='checkbox' id=d"+row.id+">"
				}
				}]
		});
		 //初始化
		function intDataTable(){
			var table=$('#customTable').DataTable({
				"serverSide":false,
				//请求路径
				"ajax":{
				"url":"data/data1.json",
				"data":{
					"pageNum":"123"
				}
				}
			})
		}
		$(function(){
			$("#customTable tbody").on("click","input[type='checkbox']",function(){
				console.log($(this))
				if($(this).is(':checked')){
					$(this).parents("tr").addClass('selected');
				}else{
					$(this).parents("tr").removeClass('selected');
				}
			});
			$('#deleteSelected').click(function(){
				var table=$('#customTable').DataTable();
				var ln=table.rows('.selected').data().length;
				var a=[];
				for(var i=ln;i>0;i--){
					a.push(table.rows('.selected').data()[0].id)
					//table.row('.selected').remove().draw(false);	
				}
				if(a[0]!=null){
					if(confirm("是否要删除所选客户？")){
						$.ajax({
						url:"data/customlist.json",
						type:"get",
						dataType:"json",
						data:{
						"clientName":"ssss",
						"selectedID":a.join(",")
						},
						success:function(data){
							for(var i=ln;i>0;i--){
								table.row('.selected').remove().draw(false);
							}
							//table.row('.selected').remove().draw(false);
							alert("成功!");
							$("#checkAll").prop("checked",false)
						},
						error:function(error){
							alert("操作失败，请重新操作！");
						},
						async:false
						})
					}
				}else{
					alert("请选择要删除的客户");
					return false;
				}
			});
			//全选
			$("#checkAll").click(function(){
				if($(this).is(':checked')){
					$("#customTable tbody input[type='checkbox']").prop("checked",true);
					$("#customTable tbody tr").addClass('selected');
				}else{
					$("#customTable tbody input[type='checkbox']").prop("checked",false);
					$("#customTable tbody tr").removeClass('selected');
				}
				;
			})
		})
		//删除函数
		function deleteThisCustom(a){
			if(confirm("是否要删除所选客户?")){
				$("#d"+a).parents("tr").addClass("selected");
				$("#d"+a).prop("checked",true);
				$.ajax({
				url:"data/customlist.json",
				type:"get",
				dataType:"json",
				data:{
				"clientName":"ssss",
				"selectedID":a
				},
				success:function(data){
					var table=$('#customTable').DataTable();
					table.row('.selected').remove().draw(false);
				},
				error:function(error){
					alert("操作失败，请重新操作！");
				},
				async:false
				})
			}
		}
		function stopThisCustom(a){
			if(confirm("是否要停用所选客户?")){
				$("#d"+a).parents("tr").addClass("selected");
				$("#d"+a).prop("checked",true);
				$.ajax({
				url:"data/customlist.json",
				type:"get",
				dataType:"json",
				data:{
				"clientName":"ssss",
				"selectedID":a
				},
				success:function(data){
					var table=$('#customTable').DataTable();
					table.row('.selected').remove().draw(false);
				},
				error:function(error){
					alert("操作失败，请重新操作！");
				},
				async:false
				})
			}
		}
	</script>
</body>
</html>