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
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
<style>
body {
	width: 100%;
	height: 100%;
	position: absolute;
}

h3 {
	padding-left: 10px;
}

#onLineRateDiv, onLineTimeDiv {
	margin: 0 auto;
}
/* 选择图表 */
ul {
	overflow: hidden;
	margin-top: 5px;
	margin-bottom: 10px;
}

ul li {
	display: inline-block;
	list-style: none;
	padding: 5px 10px;
	float: left;
	border-radius: 5px;
	font-weight: bolder;
	font-size: 16px;
	background-color: #ced2d8;
	color: #000;
}

ul li.active {
	background-color: #6699FF;
	color: #fff;
}

#selectTmLong {
	margin-left: 20%;
	overflow: hidden
}

#verhicleInput, #selectTime {
	float: left;
}

#verhicleInput {
	margin-left: 20px;
	display: none;
}
#onLineTimeDiv{
display:none}
</style>
</head>
<body>
	<ul>
		<li id="onLineRate" class="active">终端上线率</li>
		<li id="onLineTime">终端上线次数</li>
	</ul>
	<div id="selectTmLong">
		<select name="selectTime" id="selectTime">
			<option value="week" selected="selected">近一周</option>
			<option value="month">近一月</option>
			<option value="year">近一年</option>
		</select>
		<div id="verhicleInput">
			请输入车牌号:<input type="text" />
			<button>查看</button>
		</div>
	</div>
	<div id="onLineRateDiv" style="width: 80%; height: 80%;"></div>
	<div id="onLineTimeDiv" style="width: 80%; height: 80%;"></div>
	<script src="js/jquery.min.js"></script>
	<script src="js/echarts.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		$(function(){
			displayOnlineRate($(selectTime).val());
			function displayOnlineRate(selectLong){
				var myChart=echarts.init(document.getElementById('onLineRateDiv'));
				$.get('data/monthOnline.json',{
					dateLone:selectLong
				},function(data){
					myChart.setOption({
					title:{
						text:'终端上线率',
						position:"center"
					},
					dataZoom:[{
					type:'slider',
					xAxisIndex:0,
					start:10,
					end:60
					},{
					type:'inside',
					xAxisIndex:0,
					start:10,
					end:60
					},{
					type:'slider',
					yAxisIndex:0,
					start:30,
					end:80
					},{
					type:'inside',
					yAxisIndex:0,
					start:30,
					end:80
					}],
					tooltip:{
					trigger:'axis',
					axisPointer:{ // 坐标轴指示器，坐标轴触发有效
						type:'shadow' // 默认为直线，可选为：'line' | 'shadow'
					}
					},
					legend:{
						data:['上线率']
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
					name:'上线率',
					axisLabel:{
						formatter:'{value} %'
					},
					}],
					series:[{
					name:'上线率',
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
					data:data.online
					}]
					});
				});
			}
			//上线次数
			function displayOnlineTime(verhicle,selectLong){
				var myChart=echarts.init(document.getElementById('onLineTimeDiv'));
				$.get('data/monthOnlineTime.json',{
				"dateLone":selectLong,
				"verhicle":verhicle
				}).success(function(data){
					myChart.setOption({
					title:{
						text:'终端上线次数'
					},
					dataZoom:[{
					type:'slider',
					xAxisIndex:0,
					start:10,
					end:60
					},{
					type:'inside',
					xAxisIndex:0,
					start:10,
					end:60
					},{
					type:'slider',
					yAxisIndex:0,
					start:0,
					end:100
					},{
					type:'inside',
					yAxisIndex:0,
					start:0,
					end:100
					}],
					tooltip:{
					trigger:'axis',
					axisPointer:{ // 坐标轴指示器，坐标轴触发有效
						type:'shadow' // 默认为直线，可选为：'line' | 'shadow'
					}
					},
					legend:{
						data:['上线次数']
					},
					grid:{
					left:'10%',
					right:'10%',
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
					name:'上线次数'
					}],
					series:[{
					name:'上线次数',
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
					data:data.onlineTime
					}]
					});
				});
			}
			$("#selectTime").on("change",function(){
				displayOnlineRate($(selectTime).val());
			})
			$("#onLineTime").click(function(){
				$("#selectTime").val("week");
				$(this).siblings("li").removeClass("active");
				$(this).addClass("active");
				$("#onLineRateDiv").hide();
				$("#verhicleInput").show();
				$("#onLineTimeDiv").show();
			});
			$("#verhicleInput button").click(function(){
				displayOnlineTime($("#verhicleInput input").val(),$(selectTime).val());
				})
			$("#onLineRate").click(function(){
				$("#selectTime").val("week");
				$(this).siblings("li").removeClass("active");
				$(this).addClass("active");
				$("#verhicleInput").hide();
				$("#onLineTimeDiv").hide();
				$("#onLineRateDiv").show();
				displayOnlineRate("week");
			})
		})
	</script>
</body>
</html>