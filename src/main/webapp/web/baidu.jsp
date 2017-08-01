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
<link rel="stylesheet" href="css/baidu.css">
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=4d479f21ba6b7061741fab5a5a8bd6ba"></script>
<link
	href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="http://api.map.baidu.com/library/DistanceTool/1.2/src/DistanceTool_min.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js"></script>
	<!-- 富标注 -->
	<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
       <style>
#map {
	width: 100%;
	height: 100%;
	margin-top: 0px;
	margin-left: 0px
}
.cel{
	position:absolute;
	background-color:#fff;
	box-shadow: rgba(0, 0, 0, 0.35) 2px 2px 3px;
	color:#000;
	z-index:20;
	border:1px #8ba4dc solid;
	padding: 2px 6px;
	font-size:12px;
	line-height:1.3em;
	top:20px;
	right:153px;
}
#tcBtn{
	box-shadow: rgba(0, 0, 0, 0.35) 2px 2px 3px;
	border:1px #8ba4dc solid;
}
label.BMapLabel{
	max-width:none
	}
/* 标注框蒙版 */	
.mengBan{
	position:absolute;
	top:0;
	right:0;
	bottom:0;
	left:0;
	background-color:#000;
	opacity:0.5;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=50);
	z-index:2;
	display:none;
	}
	/*标注框  */
#markerWindow{
	background-color:#fff;
	opacity:0.8;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=80);
	position:absolute;
	z-index:5;
	color:#000;
	width:400px;
	height:300px;
	top:50%;
	left:50%; 
	margin-left:-200px;
	margin-top:-155px;
	padding:0 5px;
	display:none; 
}
#markerWindow h4:{
	font-weight:bolder;
}
#markerWindow h4 span{
font-size:25px;
display:inline-block;
width:20px;
height:20px;
line-height:20px;
text-align:center;
float:right;
margin-right:15px;
border:1px black solid;
border-radius:50%;}
#markerWindow h4 span:hover{
	cursor:pointer
}
#markerWindow hr{
	margin:5px 0px;
	border-top:2px #000 solid;
}

#markerWindow label {
	line-height:26px;
	float:left;
 	margin-right:3px;
 }
 #markerSubmit{
 	margin-left:30%
 }
  #markerQuit{
 	margin-left:10%
 }
</style>
</head>
<body>
<!-- 蒙版-->
<div class="mengBan">
</div>
<!-- 标注框 -->
<div id="markerWindow">
		<h4>标注信息：<span title="关闭">&times;</span></h4>
		<hr/>
		<p><label>名称：</label><input id="markerName" type="text"></p>
		<p><label>经度：</label><input id="markerLng" type="text"></p>
		<p><label>纬度：</label><input id="markerLat" type="text"></p>
		<div><label>备注：</label><textarea name="markInfo" id="markInfo" cols="40" rows="5"></textarea></div>
		<p><input id="markerSubmit" type="submit" ><input id="markerQuit" type="button" value="取消"></p>
	</div>
	<!-- 左边选择的复选框ID -->
<input id="carId" type="hidden">
	<p id="carId">id</p>
	<div id="map">
</div>
		
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
 window.onload=function(){
	 var car=null;
	if(document.attachEvent){
		document.attachEvent("onstorage", function (e) {
			car=sessionStorage.getItem("selectedCar");
        	//console.log(car)
				document.getElementById("carId").value=car;	
				$("#carId").change();
	    })
	}else{
			window.addEventListener("storage", function (e) {
        	car=sessionStorage.getItem("selectedCar");
				document.getElementById("carId").value=car;	
				$("#carId").change();
        	
    });
	}
	
	var point=new BMap.Point(116.404, 39.915)
	var map = new BMap.Map("map"); 	// 创建Map实例
	var cel=$("<div class='cel'>测距</div>");
	cel.prependTo($("#map"));
	map.centerAndZoom(point, 6); 	// 初始化地图,设置中心点坐标和地图级别
	map.setCurrentCity("北京"); 	// 仅当设置城市信息时，MapTypeControl的切换功能才能可用
	map.enableScrollWheelZoom(true);
	//缩放平移控件
	var top_left_navigation = new BMap.NavigationControl();
	map.addControl(top_left_navigation);
	
	//添加比例尺
	var top_left_control = new BMap.ScaleControl();
	map.addControl(top_left_control);
	//右下缩略图
	var overViewOpen = new BMap.OverviewMapControl({
		isOpen : true,
		anchor : BMAP_ANCHOR_BOTTOM_RIGHT
	});
	overViewOpen.setSize(new BMap.Size(180, 160))
	map.addControl(overViewOpen);
	//构造全景控件
	//var stCtrl = new BMap.PanoramaControl(); 
	//stCtrl.setOffset(new BMap.Size(15, 40));
	//map.addControl(stCtrl);
	//地图类型
	var mapType1 = new BMap.MapTypeControl({anchor: BMAP_ANCHOR_TOP_RIGHT});
	mapType1.setOffset(new BMap.Size(190, 20));
	map.addControl(mapType1);
	//路况
	var mapType2=new BMapLib.TrafficControl();
	mapType2.setOffset(new BMap.Size(81, 20));
	map.addControl(mapType2);
	//城市列表
	var cityList=new BMap.CityListControl({
	    anchor: BMAP_ANCHOR_TOP_LEFT,
	    offset: new BMap.Size(60, 20)
	})
	map.addControl(cityList);
	
	
	//右键菜单
	var rightMenu=new BMap.ContextMenu(); 
	rightMenu.addItem(new BMap.MenuItem("添加标注",function(e){
		$(".mengBan,#markerWindow").css("display","block");
		$("#markerLng").val(e.lng);
		$("#markerLat").val(e.lat);
		},{width:"100",iconUrl:"images/marker.png"}));
	map.addContextMenu(rightMenu);
	//添加maker
	 function addMaker(pt){
		 var myIcon = new BMap.Icon("images/car.png", new BMap.Size(48, 48), {   
				imageOffset: new BMap.Size(0, 5)
			  });
			marker= new BMap.Marker(pt,{icon:myIcon});
			map.addOverlay(marker);
		}
	//测距
	var flagCel=false;
	var myDis= new BMapLib.DistanceTool(map);
	//测距操作
	$(".cel").click(function(){
		map.clearOverlays();
		if(flagCel==false){
			flagCel=true;
		$(this).css({"backgroundColor":"rgb(142, 168, 224)","color":"white"});
		myDis.open();
		}else{
			flagCel=false;
			$(this).css({"backgroundColor":"white","color":"black"});
			myDis.close();
		}
	});
	//测距结束触发
	myDis.addEventListener("drawend", function(e) { 
		flagCel=false;
		$(".cel").css({"backgroundColor":"white","color":"black"});
		myDis.close();
	})
	//左边复选框改变触发事件
$("#carId").change(function() {
	$.ajax({
		url:"data/latlng.json",
		data:{carId:car},
		type:"get",
		async:false,
		success:function(data){
			map.clearOverlays();
				 var myIcon = new BMap.Icon("images/car.png", new BMap.Size(48, 48), {   
						imageOffset: new BMap.Size(0, 0)
					  });
				 var opts = {
						  width : 240,     // 信息窗口宽度
						  height: 210,     // 信息窗口高度
						  title : "详细信息" , // 信息窗口标题
						  enableMessage:true//设置允许信息窗发送短息
						}
			map.setCenter(new BMap.Point(data[0].lng, data[0].lat));
				 var markers=[];
			for(var i=0;i<data.length;i++){
				var point=new BMap.Point(data[i].lng, data[i].lat);
				var content = [];
				content.push("<li><strong>车辆ID：</strong>"+data[i].id+"</li>");
			    content.push("<li><strong>车辆经度：</strong>"+data[i].lng+"</li>");
			    content.push("<li><strong>车辆经度：</strong>"+data[i].lat+"</li>");
			    content.push("<li><strong>GPS时间：</strong>"+data[i].GPStime+"</li>");
			    content.push("<li><strong>车辆地址：</strong>"+data[i].add+"</li>");
			    var marker= new BMap.Marker(point);
			    markers.push(marker);
			    marker.setIcon(myIcon)
				map.addOverlay(marker);
				addClickHandler(content,marker);
			    //var infoWindow = new BMap.InfoWindow(content.join(""), opts); 
			    function addClickHandler(content,marker){
    				marker.addEventListener("click",function(e){
    					map.panTo(new BMap.Point(e.target.getPosition().lng,e.target.getPosition().lat));
    					openInfo(content,e)}
    				);
    			}
    			function openInfo(content,e){
    				var p = e.target;
    				var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
    				var infoWindow = new BMap.InfoWindow(content.join(""),opts);  // 创建信息窗口对象 
    				map.openInfoWindow(infoWindow,point); //开启信息窗口
    			}
			}
			var markerClusterer = new BMapLib.MarkerClusterer(map, {markers:markers});
		}
		})
 });
	$("#markerWindow h4 span").click(function(){
		$(".mengBan,#markerWindow").css("display","none");
	});
	$("#markerQuit").click(function(){
		$(".mengBan,#markerWindow").css("display","none");
	});
 }
	</script>
	
		
</body>
</html>