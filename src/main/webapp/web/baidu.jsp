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

/* #map {
	height: 700px\9;
	width: 1000px\9;
}

#map {
	*height: 700px;
	*width: 1000px;
}

#map {
	_height: 100%;
	_width: 100%;
} */
</style>
</head>
<body>
	<p>百度地圖</p>
	<p id="carId">id</p>
	<div id="map"></div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
 window.onload=function(){
	//获取选中的车辆
	var car=null;
	console.log(window.attachEvent)
	if(document.attachEvent){
		document.attachEvent("onstorage", function (e) {
	        document.getElementById("carId").innerHTML=sessionStorage.getItem("selectedCar")
	    })
	}else{
			window.addEventListener("storage", function (e) {
				
        	car=sessionStorage.getItem("selectedCar").split(",");
				document.getElementById("carId").innerHTML=car;
        	
    });
	}
	var point=new BMap.Point(116.404, 39.915)
	var map = new BMap.Map("map"); 	// 创建Map实例
	map.centerAndZoom(point, 10); 	// 初始化地图,设置中心点坐标和地图级别
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
	map.addControl(overViewOpen);
	var stCtrl = new BMap.PanoramaControl(); //构造全景控件
	stCtrl.setOffset(new BMap.Size(15, 40));
	var maker;
	map.addControl(stCtrl);
}  
 
	</script>
	
		
</body>
</html>