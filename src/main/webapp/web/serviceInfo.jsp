<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<!-- 编码格式 -->
<meta charset="UTF-8">
<title>服务器实时信息</title>
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
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
<style>
body, html {
	width: 100%;
	height: 100%;
}

body {
	background-color: #eee;
}

th, td, h3 {
	text-align: center
}

tr {
	height: 40px
}
/* select框 */
	#selectedTime{    position: absolute;
    left: 100px;
    top: 61px;
    z-index:10;}
#serviceInfo th {
	background-color: #d2cece;;
}
/* 下面24小时展示 */
.hourDisplay {
	margin-top: 20px;
}
/* 时间 */
#time {
	position: absolute;
	margin: 0;
	width: 250px;
	top: 10px;
	left: 100%;
	color: #000;
	font-weight: bolder;
	font-size: 25px;
}
/* 24小时图表 */
#hourUpload {
	width: 100%;
	position: absolute;
	bottom: 0;
	top: 0
}
/* 图标外面的div */
.hourDisplay {
	width: 100%;
	position: absolute;
	top: 350px;
	bottom: 0;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-3 col-md-4 col-sm-4">
				<h3>服务器基本信息</h3>
				<h3 id="time">
					<span class="time"></span>
				</h3>
				<table id="serviceInfo" width="100%" border="1">
					<tr>
						<th>类型</th>
						<th>信息</th>
					</tr>
					<tbody>
						<tr class="cpu">
							<td>CPU使用率</td>
							<td></td>
						</tr>
						<tr class="totalMemory">
							<td>总内存</td>
							<td></td>
						</tr>
						<tr class="memory">
							<td>内存使用率</td>
							<td></td>
						</tr>
						<tr class="uploadNow">
							<td>正在上传</td>
							<td></td>
						</tr>
						<tr class="uploadToday">
							<td>今日已上传</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-lg-8 col-md-8 col-sm-8">
				<h3 class="dayTitle">近七天上传量</h3>
				<select name="selectedTime" id="selectedTime">
					<option value="week" selected="selected">近七天上传量</option>
					<option value="month">近一个月上传量</option>
				</select>
				<div id="sevenDayUpload" style="width: 100%; height: 240px"></div>
			</div>
		</div>
		<div class="row hourDisplay">
			<h3>24小时上传量（每30分更新一次）</h3>
			<div id="hourUpload"></div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/echarts.min.js"></script>
	<script>
		$(function(){
			//显示数据
			getInfo("data/serviceInfo.json");
			sevenDayUploadDisplay("week");
			hourUploadDisplay();
			//小于10加0
			function addZero(num){
				return num>=10?num:"0"+num
			}
			//时间更新
			setInterval(function(){
				var date=new Date();
				var year=date.getFullYear();
				var month=date.getMonth()+1;
				var dat=date.getDate();
				var day=date.getDay();
				var hour=addZero(date.getHours());
				var min=addZero(date.getMinutes());
				var sec=addZero(date.getSeconds())
				$(".time").html(year+"/"+month+"/"+dat+"     "+hour+":"+min+":"+sec);
				if((min=="00"||min=="30")&&(sec=="00")){
					hourUploadDisplay();
				}
			},1000)
			//填充表格
			$("#selectedTime").change(function(){
				//标题内容改变
				$(".dayTitle").html($('#selectedTime option:selected').text())
				//更新表
				sevenDayUploadDisplay($(this).val())
			})
			setInterval(function(){
				getInfo("data/serviceInfo.json");
				hourUploadDisplay();
			},5000);
		})
		function sevenDayUploadDisplay(days){
			var myChart=echarts.init(document.getElementById('sevenDayUpload'));
			$.get('data/sevenDayUpload.json',{
				time:days
			},function(data){
				myChart.setOption({
				title:{
				text:'上传量',
				position:"center"
				},
				tooltip:{
				trigger:'axis',
				axisPointer:{ // 坐标轴指示器，坐标轴触发有效
					type:'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
				},
				legend:{
					data:['上传量']
				},
				grid:{
				left:'10%',
				right:'5%',
				bottom:'5%',
				containLabel:true
				},
				tooltip:{
				show:true,
				trigger:'axis'
				},
				xAxis:[{
				type:'category',
				//刻度从0开始
				boundaryGap:false,
				axisPointer:{
				"show":true,
				type:'line',
				},
				data:data.date
				}],
				yAxis:[{
				type:'value',
				name:'上传量',
				axisLabel:{
					formatter:'{value}次'
				},
				}],
				series:[{
				name:'上传量',//提示框内容
				// 折线
				type:'line',
				//平滑
				smooth:true,
				//折线颜色 
				itemStyle:{
					normal:{
					color:'blue',
					borderWidth:2,
					lineStyle:{
						color:'rgb(255, 70, 131)'
					}
					}
				},
				//区域填充颜色
				areaStyle:{
					normal:{
						//color:"rgb(255, 70, 131)",
						color:new echarts.graphic.LinearGradient(0,0,0,1,[{
						offset:0,
						color:'rgb(255, 158, 68)'
						},{
						offset:1,
						color:'rgb(255, 70, 131)'
						}])
					}
				},
				data:data.uploadToday
				}]
				});
			});
		}
		function getInfo(url){
			$.ajax({
			url:url,
			type:"GET",
			dataType:"json",
			async:true,
			success:function(data){
				$(".cpu td:eq(1)").html(data.cpu);
				$(".totalMemory td:eq(1)").html(data.totalMemory);
				$(".memory td:eq(1)").html(data.memory);
				$(".uploadNow td:eq(1)").html(data.uploadNow);
				$(".uploadToday td:eq(1)").html(data.uploadToday);
			},
			error:function(e){
				alert("未知错误");
			}
			})
		}
		function hourUploadDisplay(){
			var myChart=echarts.init(document.getElementById('hourUpload'));
			$.get('data/hourUpload.json',{},function(data){
				myChart.setOption({
				title:{
				text:'上传量',
				position:"center"
				},
				tooltip:{
				trigger:'axis',
				axisPointer:{ // 坐标轴指示器，坐标轴触发有效
					type:'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
				},
				legend:{
					data:['上传量']
				},
				grid:{
				left:'10%',
				right:'5%',
				bottom:'5%',
				containLabel:true
				},
				tooltip:{
				show:true,
				trigger:'axis'
				},
				xAxis:[{
				type:'category',
				//刻度从0开始
				boundaryGap:false,
				axisPointer:{
				"show":true,
				type:'line',
				},
				data:data.date
				}],
				yAxis:[{
				type:'value',
				name:'上传量',
				axisLabel:{
					formatter:'{value}次'
				},
				}],
				series:[{
				name:'上传量',//提示框内容
				// 折线
				type:'line',
				//平滑
				smooth:true,
				//折线颜色 
				itemStyle:{
					normal:{
					color:'blue',
					borderWidth:2,
					lineStyle:{
						color:'rgb(255, 70, 131)'
					}
					}
				},
				//区域填充颜色
				areaStyle:{
					normal:{
						//color:"rgb(255, 70, 131)",
						color:new echarts.graphic.LinearGradient(0,0,0,1,[{
						offset:0,
						color:'rgb(255, 158, 68)'
						},{
						offset:1,
						color:'rgb(255, 70, 131)'
						}])
					}
				},
				data:data.uploadNunber
				}]
				});
			});
		}
	</script>
</body>
</html>