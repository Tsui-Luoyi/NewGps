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
<link rel="shortcut icon" href="imgs/5.ico" type="image/x-icon" />
<link rel="stylesheet" href="css/media.css" />
<link rel="stylesheet" href="css/color.css" />
<!-- <link rel="stylesheet"
	href="http://cache.amap.com/lbs/static/main1119.css" /> -->
<script
	src="http://webapi.amap.com/maps?v=1.3&key=d3ba5a2d57426deb48072817c2d7c4ce">
	
</script>
<!-- <script type="text/javascript"
	src="http://cache.amap.com/lbs/static/addToolbar.js"></script> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
<style type="text/css">
html{
	font-size:625%;
}
html,body{
width:100%;
height:100%;
background-color: #99CCFF;
position:absolute;
}
/* 上方内容 */
#top>h2 {
	height: 0.4rem;
	padding: 5px 10px;
	margin:0px; 
	width : 100%;
	position: absolute;
	z-index: 5;
	border-bottom: 2px red solid;
	width: 100%;
	font-size:0.25rem;
	font-weight:bolder;
}

#top>h2 span {
	font-size: 16px;
	color:#F00;
}

#top {
	overflow: hidden;
	height:0.8rem;
	width:100%;
}

#top .timeSelect {	
	width: 100%;
	padding: 5px 10px;
	position:relative;
	top:0.4rem;
	z-index:50
}

#top .endTm{
	margin-left: 50px;
}

#container {
	position:absolute;
	top:0.8rem;
	left:0;
	right:0;
	bottom:0;
}
/* 高德定义内容 */
.button-group {
	position: absolute;
	bottom: 20px;
	right: 20px;
	font-size: 12px;
	padding: 10px;
}

.button-group .button {
	height: 28px;
	line-height: 28px;
	background-color: #0D9BF2;
	color: #FFF;
	border: 0;
	outline: none;
	padding-left: 5px;
	padding-right: 5px;
	border-radius: 3px;
	margin-bottom: 4px;
	cursor: pointer;
}
.button-group .inputtext {
	height: 26px;
	line-height: 26px;
	border: 1px;
	outline: none;
	padding-left: 5px;
	padding-right: 5px;
	border-radius: 3px;
	margin-bottom: 4px;
	cursor: pointer;
}
#tip {
	background-color: #fff;
	padding-left: 10px;
	padding-right: 10px;
	position: absolute;
	font-size: 12px;
	right: 10px;
	top: 20px;
	border-radius: 3px;
	border: 1px solid #ccc;
	line-height: 30px;
}

.amap-info-content {
	font-size: 12px;
}

#myPageTop {
	position: absolute;
	top: 5px;
	right: 10px;
	background: #fff none repeat scroll 0 0;
	border: 1px solid #ccc;
	margin: 10px auto;
	padding:6px;
	font-family: "Microsoft Yahei", "微软雅黑", "Pinghei";
	font-size: 14px;
}
#myPageTop label {
	margin: 0 20px 0 0;
	color: #666666;
	font-weight: normal;
}
#myPageTop input {
	width: 170px;
}
#myPageTop .column2{
	padding-left: 25px;
}
</style>
</head>
<body>
	<div id="top">
		<h2>
			轨迹查询<span>(车牌号：<span id="verName">123</span>)
			</span>
		</h2>
		<div class="timeSelect">
			<p>
				<label>开始时间：</label><input type="text" id="startTime" /> <label class="endTm">结束时间：</label>
				<input type="text" id="endTime" />
				<button id="cx">查询</button>
		</div>
	</div>
	<div id="container"></div>
	<div class="button-group">
		<input type="button" class="button" value="开始动画" id="start" /> <input
			type="button" class="button" value="加速" id="pl" /> <input
			type="button" class="button" value="减速" id="mi" /> <input
			type="button" class="button" value="暂停动画" id="pause" /> <input
			type="button" class="button" value="继续动画" id="resume" /> <input
			type="button" class="button" value="停止动画" id="stop" />
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jedate/jedate.min.js"></script>
	<script>
		$(function(){
			jeDate({
				dateCell:"#startTime",
				format:"YYYY/MM/DD hh:mm:ss",
				//isinitVal:true,
				isTime:true, //isClear:false,
				minDate:"2000-01-01 00:00:00",
				//okfun:function(val){alert(val)}
			});
			jeDate({
				dateCell:"#endTime",
				format:"YYYY/MM/DD hh:mm:ss",
				//isinitVal:true,
				isTime:true, //isClear:false,
				minDate:"2000-01-01 00:00:00",
				//okfun:function(val){alert(val)}
			})
			var ii=10;
			var marker,lineArr=[];
			function getQueryString(name){
				var reg=new RegExp("(^|&)"+name+"=([^&]*)(&|$)","i");
				var r=window.location.search.substr(1).match(reg);
				if(r!=null)
					return decodeURI(r[2]);
				return null;
			}
			console.log(getQueryString("verhicalId"));
			$("#top #verName").html(getQueryString("verhicalName"));
			var map=new AMap.Map("container",{
			resizeEnable:true,
			center:[116.404,39.915],
			zoom:4
			});
			$("#cx").click(function(){
				var stTm=$("#startTime").val();
				var endTm=$("#endTime").val();
				//Date.parse(new Date(stTm.replace(/-/g, "/")))
				//console.log(Date.parse(new Date(stTm)))
				if((stTm=="")|(endTm=="")){
					alert("不能为空！")
					return false;
				}else if(Date.parse(new Date(stTm))>Date.parse(new Date(endTm))){
					alert("开始时间应早于结束时间！")
					return false;
				}
				$.ajax({
					url:"data/trail.json",
					data:{
						"verhicalId":getQueryString("verhicalId"),
						"starttime":stTm,
						"endtime":endTm
					// "fenceName" : $("#fenceRoundName").val()
					},
					type:"get",
					success:function(data){
						console.log(data)
						if(data==""){
							alert("该时间段没有数据！")
						}else{
							reTrail(data)
						}
					},
					error:function(error){
						console.log(error)
					},
					async:false
					})
				
			})
			 function reTrail(lineArr){
			marker=new AMap.Marker({
			map:map,
			position:lineArr[0],
			icon:"http://webapi.amap.com/images/car.png",
			offset:new AMap.Pixel(-26,-13),
			autoRotation:true
			});
			console.log(lineArr)
			//lineArr=[[116.398075,39.907359],[116.598075,39.707359],[116.598075,40.107359],[116.798075,39.987359]];
			// 绘制轨迹
			var polyline=new AMap.Polyline({
			map:map,
			path:lineArr,
			strokeColor:"#00A", //线颜色
			// strokeOpacity: 1,     //线透明度
			strokeWeight:3, //线宽
			// strokeStyle: "solid"  //线样式
			});
			var passedPolyline=new AMap.Polyline({
			map:map,
			// path: lineArr,
			strokeColor:"#F00", //线颜色
			// strokeOpacity: 1,     //线透明度
			strokeWeight:3, //线宽
			// strokeStyle: "solid"  //线样式
			});
			marker.on('moving',function(e){
				passedPolyline.setPath(e.passedPath);
			})
			map.setFitView();
			AMap.event.addDomListener(document.getElementById('start'),'click',function(){
				ii=5;
				marker.moveAlong(lineArr,10000*ii);
			},false);
			AMap.event.addDomListener(document.getElementById('pl'),'click',function(){
				if(ii<2500){
				ii*=2;
				}
				marker.moveAlong(lineArr,10000*ii);
			},false);
			AMap.event.addDomListener(document.getElementById('mi'),'click',function(){
				if(ii>0){
					ii/=2;
					marker.moveAlong(lineArr,10000*ii);
				}else{
					return false;
				}
			},false);
			AMap.event.addDomListener(document.getElementById('pause'),'click',function(){
				marker.pauseMove();
			},false);
			AMap.event.addDomListener(document.getElementById('resume'),'click',function(){
				marker.resumeMove();
			},false);
			AMap.event.addDomListener(document.getElementById('stop'),'click',function(){
				ii=null;
				marker.stopMove();
			},false);
			}
		})
	</script>
</body>
</html>