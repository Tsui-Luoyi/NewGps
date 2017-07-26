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
margin:20px 0;
	padding: 10px 20px;
	text-align:center
}
#ceshi td,th{
	text-align:center;
}
#ceshi .checkAll{
	font-size:12px;
	padding:10px;
	padding-right:0;
	text-align:left;
}
#ceshi td.select-checkbox{
text-align:left;
}
</style>
</head>
<body>
	<table class="sea" cellspacing="0" width="100%">
		<tr>
			<td style="display:none"></td>
			<td style="display:none"></td>
			<td style="display:none"></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<button id="button">点击</button>	
	<table id="ceshi" border="1px" class="hover" cellspacing="0" width="100%">
		<thead>
			<tr>
				<th width='10%' class="checkAll"><input class="select-checkbox" type="checkbox" />全选</th>
				<th width='20%'>客户名字</th>
				<th width='15%'>客户电话</th>
				<th width='15%' class="">添加时间</th>
				<th width='15%'>客户管理员</th>
				<th width='25%'>操作</th>
			</tr>
		</thead>
		<tfoot class="hidden-xs">
			<tr>
				<th width='10%' class="checkAll"><input class="select-checkbox" type="checkbox" />删除选中</th>
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
	$(document).ready(function() {
		$('#ceshi').DataTable({
			"dom":'<"headerTop"lf>rt<"footBottom"rip><"clear">',
			"paging":true,
			/*分页按钮类型*/
			"pagingType":"full",
			"stateSave": true,
			//等待状态
			"processing":true,
			//排序
			"ordering":true,
			//第四列降序asc是升序
			"order":[[3, "desc" ]],
			//每页显示多少条数据
			"aLengthMenu": [10, 25, 50, 100], 
			//共多少页，当前第几页
			"info":true,
			//请求路径
			"ajax":"data/data1.json",
			//中文显示
			"language":{
				"search":"快速搜索:",
				"processing": "正在查询中...",
				"lengthMenu":"每页 _MENU_ 条记录",
				"zeroRecords":"没有找到记录",
				"info":"第_PAGE_页(总共_PAGES_页)",
				"infoEmpty": "无记录",
				"infoFiltered": "(从 _MAX_ 条记录过滤)",
				'paginate':{
					'next':'下页',
					'previous':'上页',
					"sFirst": "首页",
					"sLast": "末页"
				} 
			},
			"columns":[
  			{},
			{ "data": "clientName"},
			{ "data": "clientTel" },
			{ "data": "creatTime" },
			{ "data": "clientAdminName" }
			],
	//改变第五列
	"columnDefs":[{
			//定义操作列,
			"targets": 5,
			//添加删除等按钮
			"render" : function(data,type,row) {
							var name ='"'+row.clientName+'"';
							var html="<a href='javascript:void(0); 'class='delete btn btn-default btn-xs'><i class='fa fa-times'></i> 查看</a>"
								html+="<a href='javascript:void(0); 'class='up btn btn-default btn-xs'><i class='fa fa-arrow-up'></i> 编辑</a>"
								html+="<a href='javascript:void(0); 'onClick='deleteThisRow("+ name + ")'  class='down btn btn-default btn-xs'><i class='fa fa-arrow-down'></i> 删除</a>"
							return html;
						}
					},{
    					"orderable": false,
    					"className": 'select-checkbox',
   						"targets":0,
    					"render":function(data,type,full,meta){
        		return '<input type="checkbox" value="'+data+'" title="'+ data+'"id="checkbox" />';
       	 }      
		}],
	});
});
	//每列添加搜索框
	$(document).ready(function() {
			$('#ceshi thead th').each( function (ind,val) {
			var title=$('#ceshi thead th').eq($(this).index()).text();
			$(".sea tr td").eq(ind).html(title+':&nbsp;<input type="text" placeholder="请输入'+title+'"/>');
		});
		var table=$('#ceshi').DataTable();
			table.columns().eq(0).each(function (ind,val) {
				$(".sea input").on('keyup change', function (){
					$('#ceshi').DataTable().column(ind).search(
					$('.sea input').eq(ind).val()
				).draw();
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
			$('#ceshi').DataTable();
		}	
	})
} );
	//跳转页面
	$(function(){
		$('#ceshi').on('draw.dt',function () {
			if($("#jump").size()!=1){
				var dd=$("<div id='jump'>跳转到第<input type='text' value='1'/>页<button>Go！</button></div>");
				dd.prependTo($(".pagination"));
			}
			$("#jump button").click(function(){
				var page=$("#jump input").val();
				$('#ceshi').DataTable().page(parseInt(page)-1).draw(false);
				$("#jump input").val(page); 
			})
		});
	})
	
$(function(){
	$('#ceshi tbody').on('click','td.select-checkbox input',function () {
		$(this).parent().parent().toggleClass('selected');
	});
	var table=$('#ceshi').DataTable();
	$('#button').click(function (){
		console.log(table.rows('.selected').data());
		alert( table.rows('.selected').data().length +' row(s) selected' );
	});
})

//删除函数
function deleteThisRow(nam){
		alert(nam);
}
</script>
</body>
</html>