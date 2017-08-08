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
<script type="text/javascript"
	src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
<!-- 几何工具 -->
<script type="text/javascript"
	src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils_min.js"></script>
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

.cel {
	position: absolute;
	background-color: #fff;
	box-shadow: rgba(0, 0, 0, 0.35) 2px 2px 3px;
	color: #000;
	z-index: 20;
	border: 1px #8ba4dc solid;
	padding: 2px 6px;
	font-size: 12px;
	line-height: 1.3em;
	top: 20px;
	right: 153px;
}

#tcBtn {
	box-shadow: rgba(0, 0, 0, 0.35) 2px 2px 3px;
	border: 1px #8ba4dc solid;
}

label.BMapLabel {
	max-width: none
}
/* 蒙版 */
.mengBan {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	background-color: #000;
	opacity: 0.5;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=50);
	z-index: 2;
	display: none;
}
/*标注框  */
#markerWindow {
	background-color: #fff;
	opacity: 0.8;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=80);
	position: absolute;
	z-index: 5;
	color: #000;
	width: 400px;
	height: 300px;
	top: 50%;
	left: 50%;
	margin-left: -200px;
	margin-top: -155px;
	padding: 0 5px;
	display: none;
}

#markerWindow h4: {
	font-weight: bolder;
}

#markerWindow h4 span {
	font-size: 25px;
	display: inline-block;
	width: 20px;
	height: 20px;
	line-height: 20px;
	text-align: center;
	float: right;
	margin-right: 15px;
	border: 1px black solid;
	border-radius: 50%;
}
/* 标注框关闭按钮 */
#markerWindow h4 span:hover {
	cursor: pointer
}

#markerWindow hr {
	margin: 5px 0px;
	border-top: 2px #000 solid;
}

.BMap_bubble_content hr {
	margin: 2px 0px;
	border-top: 2px #000 solid;
}

#markerWindow label {
	line-height: 26px;
	float: left;
	margin-right: 3px;
}
/* 标注错误提示 */
#markerWindow #errorLabel {
	color: red;
	height: 20px;
	float: none;
	font-size: 12px;
	margin: 0 0 0 3px
}

#markerSubmit {
	margin-left: 30%
}

#markerQuit {
	margin-left: 10%
}
/* 围栏框 */
#fenceWindow {
	background-color: #fff;
	opacity: 0.8;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=80);
	position: absolute;
	z-index: 5;
	color: #000;
	width: 400px;
	height: 320px;
	top: 50%;
	left: 50%;
	margin-left: -200px;
	margin-top: -155px;
	padding: 0 5px;
	display: none;
}

#fenceWindow h4: {
	font-weight: bolder;
}

#fenceWindow h4 span {
	font-size: 25px;
	display: inline-block;
	width: 20px;
	height: 20px;
	line-height: 20px;
	text-align: center;
	float: right;
	margin-right: 15px;
	border: 1px black solid;
	border-radius: 50%;
}
/* 围栏框关闭按钮 */
#fenceWindow h4 span:hover {
	cursor: pointer
}

#fenceWindow hr {
	margin: 5px 0px;
	border-top: 2px #000 solid;
}

.BMap_bubble_content hr {
	margin: 2px 0px;
	border-top: 2px #000 solid;
}

#fenceWindow p {
	margin-bottom: 6px;
}

#fenceWindow label {
	line-height: 20px;
	float: left;
	margin-right: 3px;
}

#fenceWindow #errorLabelRound{
	color: red;
	height: 20px;
	float: none;
	font-size: 12px;
	margin: 0 0 0 3px
}
#fenceWindow #errorLabelRect{
	color: red;
	height: 20px;
	float: none;
	font-size: 12px;
	margin: 0 0 0 3px
}
/* 圆形半径、矩形长度和宽度  */
#fenceRadiusRound, #fenceRectLenght, #fenceRectWidth {
	width: 80px;
}

#fenceRoundType {
	margin-bottom: 0;
}

#fenceWindow #errorLabel {
	color: red;
	height: 20px;
	float: none;
	font-size: 12px;
	margin: 0 0 0 3px
}

#fenceSubmit1, #fenceSubmit2, #fenceSubmit3 {
	margin-left: 30%
}

#fenceQuit1, #fenceQuit2, #fenceQuit3 {
	margin-left: 10%
}
</style>
</head>
<body>
	<!-- 蒙版-->
	<div class="mengBan"></div>
	<!-- 标注框 -->
	<div id="markerWindow">
		<h4>
			标注信息：<span title="关闭">&times;</span>
		</h4>
		<hr />
		<form id="markerForm" method="post"
			action="http://127.0.0.1/ceshi.php">
			<p>
				<label>名称：</label><input id="markerName" type="text"><label
					id="errorLabel"></label>
			</p>
			<p>
				<label>经度：</label><input id="markerLng" type="text">
			</p>
			<p>
				<label>纬度：</label><input id="markerLat" type="text">
			</p>
			<div>
				<label>备注：</label>
				<textarea id="markInfo" cols="40" rows="5"></textarea>
			</div>
			<p>
				<input id="markerSubmit" type="button" value="保存"><input
					id="markerQuit" type="button" value="取消">
			</p>
		</form>
	</div>
	<!-- 围栏页面 -->
	<div id="fenceWindow">
		<div class="fenceRound">
			<h4>
				围栏信息：<span id="fenceClose2" title="关闭">&times;</span>
			</h4>
			<hr />
			<form class="fenceForm" method="get"
				action="http://127.0.0.1/ceshi.php">
				<p>
					<label id="fenceRoundType">围栏类型：</label><strong>圆形围栏</strong>
				</p>
				<p>
					<label>围栏名称：</label><input id="fenceNameRound" type="text"><label
						id="errorLabelRound"></label>
				</p>
				<p>
					<label>中心经度：</label><input disabled="disabled" id="fenceLngRound" type="text">
				</p>
				<p>
					<label>中心纬度：</label><input disabled="disabled" id="fenceLatRound" type="text">
				</p>
				<p>
					<label>围栏半径：</label><input disabled="disabled" id="fenceRadiusRound" type="text"><span>千米</span>
				</p>
				<div>
					<label>围栏备注：</label>
					<textarea id="fenceInfoRound" cols="40" rows="3"></textarea>
				</div>
				<p>
					<input id="fenceSubmit2" type="button" value="保存"><input
						id="fenceQuit2" type="button" value="取消">
				</p>
			</form>
		</div>
		<div class="fenceRect">
			<h4>
				围栏信息：<span id="fenceClose1" title="关闭">&times;</span>
			</h4>
			<hr />
			<form class="fenceForm" method="post"
				action="http://127.0.0.1/ceshi.php">
				<p>
					<label>围栏类型：</label><strong>矩形围栏</strong>
				</p>
				<p>
					<label>围栏名称：</label><input id="fenceRectName" type="text"><label
						id="errorLabelRect"></label>
				</p>
				<p>
					<label>围栏长度：</label><input id="fenceRectLenght" type="text"><span>千米</span>
				</p>
				<p>
					<label>围栏宽度：</label><input id="fenceRectWidth" type="text"><span>千米</span>
				</p>
				<div>
					<label>围栏备注：</label>
					<textarea id="fenceRectInfo" cols="40" rows="3"></textarea>
				</div>
				<p>
					<input id="fenceSubmit1" type="button" value="保存"><input
						id="fenceQuit1" type="button" value="取消">
				</p>
			</form>
		</div>
		<div class="fencePlogon">
			<h4>
				围栏信息：<span id="fenceClose3" title="关闭">&times;</span>
			</h4>
			<hr />
			<form class="fenceForm" method="post"
				action="http://127.0.0.1/ceshi.php">
				<p>
					<label>围栏类型：</label><strong>多边形围栏</strong>
				</p>
				<p>
					<label>围栏名称：</label><input id="fenceName" type="text"><label
						id="errorLabel"></label>
				</p>
				<div>
					<label>围栏备注：</label>
					<textarea name="fenceInfo" id="fenceInfo" cols="40" rows="5"></textarea>
				</div>
				<p>
					<input id="fenceSubmit3" type="button" value="保存"><input
						id="fenceQuit3" type="button" value="取消">
				</p>
			</form>
		</div>
	</div>
	<!-- 左边选择的复选框ID -->
	<input id="carId" type="hidden" value="">
	<p id="carId">id</p>
	<div id="map"></div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.form.js"></script>
	<script>
		//跨域提示
		jQuery.support.cors = true;
		window.onload = function() {
			var car = null;
			if (document.attachEvent) {
				document.attachEvent("onstorage", function(e) {
					car = sessionStorage.getItem("selectedCar");
					console.log(car)
					document.getElementById("carId").value = car;
					$("#carId").change();
				})
			} else {
				window.addEventListener("storage", function(e) {
					car = sessionStorage.getItem("selectedCar");
					document.getElementById("carId").value = car;
					$("#carId").change();

				});
			}

			var point = new BMap.Point(116.404, 39.915);
			var map = new BMap.Map("map"); // 创建Map实例
			var cel = $("<div class='cel'>测距</div>");
			cel.prependTo($("#map"));
			map.centerAndZoom(point, 6); // 初始化地图,设置中心点坐标和地图级别
			map.setCurrentCity("北京"); // 仅当设置城市信息时，MapTypeControl的切换功能才能可用
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
			var mapType1 = new BMap.MapTypeControl({
				anchor : BMAP_ANCHOR_TOP_RIGHT
			});
			mapType1.setOffset(new BMap.Size(190, 20));
			map.addControl(mapType1);
			//路况
			var mapType2 = new BMapLib.TrafficControl();
			mapType2.setOffset(new BMap.Size(81, 20));
			map.addControl(mapType2);
			//城市列表
			var cityList = new BMap.CityListControl({
				anchor : BMAP_ANCHOR_TOP_LEFT,
				offset : new BMap.Size(60, 20)
			})
			map.addControl(cityList);

			//右键菜单
			var rightMenu = new BMap.ContextMenu();
			rightMenu.addItem(new BMap.MenuItem("添加标注", function(e) {
				$(".mengBan,#markerWindow").css("display", "block");
				$("#markerName").val("");
				$("#errorLabel").html("");
				$("#markerLng").val(e.lng);
				$("#markerLat").val(e.lat);
			}, {
				width : "130",
				iconUrl : "images/marker.png"
			}));

			rightMenu.addItem(new BMap.MenuItem("添加矩形围栏", function(e) {
				map.disableDoubleClickZoom();
				addRect(e);
			}, {
				width : "130",
				iconUrl : "images/rect.png"
			}));
			rightMenu.addItem(new BMap.MenuItem("添加圆形围栏", function(e) {
				map.disableDoubleClickZoom();
				addRound(e);
			}, {
				width : "130",
				iconUrl : "images/round.png"
			}));
			rightMenu.addItem(new BMap.MenuItem("添加多边形围栏", function(e) {
			}, {
				width : "130",
				iconUrl : "images/ploygon.png"
			}));

			map.addContextMenu(rightMenu);
			//添加maker
			function addMaker(pt) {
				var myIcon = new BMap.Icon("images/carOnline.png",
						new BMap.Size(48, 48), {
							imageOffset : new BMap.Size(0, 5)
						});
				marker = new BMap.Marker(pt, {
					icon : myIcon
				});
				map.addOverlay(marker);
			}
			//车辆图标绑定事件
			function addClickHandler(content, marker, opts) {
				marker.addEventListener("click", function(e) {
					map.panTo(new BMap.Point(e.target.getPosition().lng,
							e.target.getPosition().lat));
					openInfo(content, e, opts)
				});
			}
			//打开信息窗
			function openInfo(content, e, opts) {
				var p = e.target;
				var point = new BMap.Point(p.getPosition().lng,
						p.getPosition().lat);
				var infoWindow = new BMap.InfoWindow(content.join(""), opts); // 创建信息窗口对象 
				map.openInfoWindow(infoWindow, point); //开启信息窗口
			}
			;

			//测距
			var flagCel = false;
			var myDis = new BMapLib.DistanceTool(map);
			//测距操作
			$(".cel").click(function() {
				map.clearOverlays();
				if (flagCel == false) {
					flagCel = true;
					$(this).css({
						"backgroundColor" : "rgb(142, 168, 224)",
						"color" : "white"
					});
					myDis.open();
				} else {
					flagCel = false;
					$(this).css({
						"backgroundColor" : "white",
						"color" : "black"
					});
					myDis.close();
				}
			});
			//测距结束触发
			myDis.addEventListener("drawend", function(e) {
				flagCel = false;
				$(".cel").css({
					"backgroundColor" : "white",
					"color" : "black"
				});
				myDis.close();
			})
			//左边复选框改变触发事件
			$("#carId")
					.change(
							function() {
								$
										.ajax({
											url : "data/latlng.json",
											data : {
												carId : car
											},
											type : "get",
											async : false,
											success : function(data) {
												console.log("成功");
												map.clearOverlays();
												var myIconOnline = new BMap.Icon(
														"images/carOnline.png",
														new BMap.Size(48, 48),
														{
															imageOffset : new BMap.Size(
																	0, 0)
														});
												var myIconOffline = new BMap.Icon(
														"images/carOffline.png",
														new BMap.Size(48, 48),
														{
															imageOffset : new BMap.Size(
																	0, 0)
														});
												var opts = {
													width : 240, // 信息窗口宽度
													height : 210, // 信息窗口高度
													title : "车辆详细信息"
												}
												map.setCenter(new BMap.Point(
														data[0].lng,
														data[0].lat));
												var markers = [];
												if (data.length <= 100) {
													for (var i = 0; i < data.length; i++) {
														var point = new BMap.Point(
																data[i].lng,
																data[i].lat);
														var marker = new BMap.Marker(
																point);
														markers.push(marker);
														var content = [];
														content
																.push("<li><strong>车辆ID：</strong>"
																		+ data[i].id
																		+ "</li>");
														if (data[i].state == [ 0 ]) {
															marker
																	.setIcon(myIconOffline);
															content
																	.push("<li><strong>车辆状态：</strong>离线</li>");
														} else {
															marker
																	.setIcon(myIconOnline);
															content
																	.push("<li><strong>车辆状态：</strong>在线</li>");
														}
														content
																.push("<li><strong>车辆经度：</strong>"
																		+ data[i].lng
																		+ "</li>");
														content
																.push("<li><strong>车辆经度：</strong>"
																		+ data[i].lat
																		+ "</li>");
														content
																.push("<li><strong>GPS时间：</strong>"
																		+ data[i].GPStime
																		+ "</li>");
														content
																.push("<li><strong>车辆地址：</strong>"
																		+ data[i].add
																		+ "</li>");
														map.addOverlay(marker);
														addClickHandler(
																content,
																marker, opts);
													}
													var markerClusterer = new BMapLib.MarkerClusterer(
															map,
															{
																markers : markers
															});
												} else {
													if (document
															.createElement('canvas').getContext) { // 判断当前浏览器是否支持绘制海量点
														var carOnline = [];
														var carOffline = []
														for (var i = 0; i < data.length; i++) {
															if (data[i].state == [ 0 ]) {
																carOffline
																		.push(new BMap.Point(
																				data[i].lng,
																				data[i].lat));
															} else {
																carOnline
																		.push(new BMap.Point(
																				data[i].lng,
																				data[i].lat));
															}
														}
														//在线状态
														var onlineOptions = {
															size : BMAP_POINT_SIZE_BIG,
															shape : BMAP_POINT_SHAPE_CIRCLE,
															color : '#7eff88'
														}
														//离线状态
														var offlineOptions = {
															size : BMAP_POINT_SIZE_BIG,
															shape : BMAP_POINT_SHAPE_RHOMBUS,
															color : '#696d69'
														}
														var pointCollection1 = new BMap.PointCollection(
																carOnline,
																onlineOptions); // 初始化PointCollection
														var pointCollection2 = new BMap.PointCollection(
																carOffline,
																offlineOptions); // 初始化PointCollection
														pointCollection1
																.addEventListener(
																		'click',
																		function(
																				e) {
																			console
																					.log(e)
																			alert(e.point.id
																					+ "  "
																					+ e.point.lng
																					+ ','
																					+ e.point.lat); // 监听点击事件
																		});
														map
																.addOverlay(pointCollection1); // 添加Overlay
														map
																.addOverlay(pointCollection2);
													} else {
														alert('请在chrome、safari、IE8+以上浏览器查看');
													}
												}
											}
										})
							});
			//标志关闭按钮
			$("#markerWindow h4 span").click(function() {
				$(".mengBan,#markerWindow").css("display", "none");
			});
			//取消按钮
			$("#markerQuit").click(function() {
				$(".mengBan,#markerWindow").css("display", "none");
			});
			//标注提交按钮
			$("#markerSubmit")
					.click(
							function() {
								var flag;
								if ($("#markerName").val() == "") {
									$("#errorLabel").html("名字不能为空！")
									return false;
								} else {
									$.ajax({
										url : "http://127.0.0.1/ceshi.php",
										data : {
											"clientName" : $("#markerName")
													.val()
										},
										type : "get",
										success : function(data) {
											if (data == "true") {
												flag = true;
											} else {
												flag = false;
											}
										},
										error : function(e) {
										},
										async : false
									})
								}
								if (!flag) {
									$("#errorLabel").html("名字已存在！")
									return false;
								}
								if ($("#markerLng").val() == "") {
									return false;
								}
								;
								if ($("#markerLat").val() == "") {
									return false;
								}
								;
								$("#markerForm")
										.ajaxSubmit({data:{
											"markerName":$("#markerName").val(),
											"markerLng":$("#markerLng").val(),
											"markerLat":$("#markerLat").val(),
											"markerInfo":$("#markInfo").val()
										},
											
												success:function() {
													alert("提交成功！");
													$(".mengBan,#markerWindow")
															.css("display",
																	"none");
													//标注信息框
													var content = [];
													content.push("<hr/>");
													content
															.push("<li><strong>标记名称：</strong>"
																	+ $(
																			"#markerName")
																			.val()
																	+ "</li>");
													content
															.push("<li><strong>标记经度：</strong>"
																	+ $(
																			"#markerLng")
																			.val()
																	+ "</li>");
													content
															.push("<li><strong>标记经度：</strong>"
																	+ $(
																			"#markerLat")
																			.val()
																	+ "</li>");
													var GeoCode = new BMap.Geocoder();
													GeoCode
															.getLocation(
																	new BMap.Point(
																			$(
																					"#markerLng")
																					.val(),
																			$(
																					"#markerLat")
																					.val()),
																	function(
																			GeocoderResult) {
																		content
																				.push("<li><strong>标记地址：</strong>"
																						+ GeocoderResult.address
																						+ "</li>");
																	})
													content
															.push("<li><strong>备注：</strong>"
																	+ $(
																			"#markInfo")
																			.val()
																	+ "</li>");
													opts = {
														width : 220,
														height : 0,
														title : "标注详细信息"
													};
													var marker = new BMap.Marker(
															new BMap.Point(
																	$(
																			"#markerLng")
																			.val(),
																	$(
																			"#markerLat")
																			.val()),
															{
																icon : new BMap.Icon(
																		"images/marker1.png",
																		new BMap.Size(
																				24,
																				24),
																		{
																			imageOffset : new BMap.Size(
																					0,
																					0)
																		})
															});
													map.addOverlay(marker);
													addClickHandler(content,
															marker, opts);
													var markerRightMenu = new BMap.ContextMenu();
													markerRightMenu
															.addItem(new BMap.MenuItem(
																	"删除标记",
																	deleteBtn
																			.bind(marker),
																	{
																		width : "130",
																		iconUrl : "images/del.png"
																	}));
													marker
															.addContextMenu(markerRightMenu);
												}
							})
							})
			function deleteBtn(e, ev, marker) {
				if (confirm("是否删除给标记？")) {
					$.ajax({
						url : "http://127.0.0.1/ceshi.php",
						data : {
							"clientName" : "123"
						},
						//data:{"markerLng":marker.getPosition().lng,"markerLat":marker.getPosition().lat},
						type : "get",
						async : false,
						success : function() {
							map.removeOverlay(marker);
						}
					});
				}
			}
			function addRound(e) {
				flagRound = true;
				roundPoint = new BMap.Point(e.lng, e.lat);
				circle = new BMap.Circle(roundPoint);
				circle.setStrokeColor("red");
				circle.setFillColor("#000")
				circle.setFillOpacity("0.5");
				circle.setStrokeWeight("2");
				var roundMenu = new BMap.ContextMenu();
				roundMenu.addItem(new BMap.MenuItem("隐藏围栏", hideRound
						.bind(circle), {
					width : "130",
					iconUrl : "images/hide.png"
				}));
				roundMenu.addItem(new BMap.MenuItem("删除围栏", deleteRound
						.bind(circle), {
					width : "130",
					iconUrl : "images/del.png"
				}));
				circle.addContextMenu(roundMenu);
			}
			function deleteRound(e, ev, circle) {
				console.log(circle);
				console.log(circle.getCenter().lat);
				if (confirm("是否删除该围栏？")) {
					$.ajax({
						url : "http://127.0.0.1/ceshi.php",
						data : {
							"clientName" : "123"
						},
						//data:{"circleCenterLng":circle.getCenter().lng,"circleCenterLat":circle.getCenter().lat},
						type : "get",
						async : false,
						success : function() {
							map.removeOverlay(circle);
						}
					});
				}
			}
			function hideRound(e, ev, circle) {
				map.removeOverlay(circle);
			}
			function addRect(e){
				flagRect = true;
				rectStartPoint = new BMap.Point(e.lng, e.lat);
				rect = new BMap.Polygon(
						[
								new BMap.Point(rectStartPoint.lng,
										rectStartPoint.lat),
								new BMap.Point(rectStartPoint.lng,
										rectStartPoint.lat),
								new BMap.Point(rectStartPoint.lng,
										rectStartPoint.lat),
								new BMap.Point(rectStartPoint.lng,
										rectStartPoint.lat) ], {
							strokeColor : "red",
							strokeWeight : 2,
							fillColor : "#000",
							fillOpacity : "0.5"
						});
			}
			 //删除矩形
			function deleteRect(e, ev, rect) {
				 
				 console.log(123)
				 console.log(e);
				 console.log(ev);
				 map.removeOverlay(rect);
			}
			//隐藏矩形
			function hideRect(e, ev, rect) {
				map.removeOverlay(rect);
			} 
			//是否画圆
			var flagRound = false;
			//圆心坐标
			var roundPoint;
			var rectStartPoint;
			var rectEndPoint;
			//矩形开关
			var flagRect = false;
			//是否是绘图后的双击
			var dblFlag = false;
			//多边形开关
			var flagPloy = false;
			//半径
			var roundDis;
			var rectWidth;
			var rectHeight;
			map.addEventListener("mousemove", function(ev) {
				//画圆
				if (flagRound) {
					dblFlag = true;
					//map.clearOverlays(circle);
					roundDis = map.getDistance(roundPoint, new BMap.Point(
							ev.point.lng, ev.point.lat));
					circle.setRadius(roundDis);
					map.addOverlay(circle);
				}
				;
				//画矩形
				if (flagRect) {
					dblFlag = true;
					map.clearOverlays(rect);
					rectEndPoint = new BMap.Point(ev.point.lng, ev.point.lat);
					var rect = new BMap.Polygon(
							[
									new BMap.Point(rectStartPoint.lng,
											rectStartPoint.lat),
									new BMap.Point(rectEndPoint.lng,
											rectStartPoint.lat),
									new BMap.Point(rectEndPoint.lng,
											rectEndPoint.lat),
									new BMap.Point(rectStartPoint.lng,
											rectEndPoint.lat) ], {
								strokeColor : "red",
								strokeWeight : 2,
								fillColor : "#000",
								fillOpacity : "0.5"
							});
					map.addOverlay(rect);
					var rectMenu=new BMap.ContextMenu();
					rectMenu.addItem(new BMap.MenuItem("隐藏围栏", hideRect.bind(rect),{
						width : "130",
						iconUrl : "images/hide.png"
					}));
					rectMenu.addItem(new BMap.MenuItem("删除围栏", deleteRect.bind(rect),
							{
								width : "130",
								iconUrl : "images/del.png"
							}));
					rect.addContextMenu(rectMenu);
				}

			})

			//双击事件
			map.addEventListener("dblclick",
					function(e) {
						if (dblFlag) {
							if (flagRound) {
								flagRound = false;
								$(".mengBan,#fenceWindow").css("display",
										"block");
								$("#fenceWindow>div").css("display", "none");
								$(".fenceRound").css("display", "block");
								$("#fenceLngRound").val(roundPoint.lng);
								$("#fenceLatRound").val(roundPoint.lat);
								$("#fenceRadiusRound").val(
										(roundDis / 1000).toFixed(3));
							} else if (flagRect) {
								flagRect = false;
								$(".mengBan,#fenceWindow").css("display",
										"block");
								$("#fenceWindow>div").css("display", "none");
								$(".fenceRect").css("display", "block");
								var rectHeight = map.getDistance(
										rectStartPoint, new BMap.Point(
												rectEndPoint.lng,
												rectStartPoint.lat));
								var rectWidth = map.getDistance(rectStartPoint,
										new BMap.Point(rectStartPoint.lng,
												rectEndPoint.lat));
								$("#fenceRectLenght").val(
										(rectHeight / 1000).toFixed(3));
								$("#fenceRectWidth").val(
										(rectWidth / 1000).toFixed(3));
							}
							dblFlag = false;
						} else {
							map.enableDoubleClickZoom();
						}
					})
			//圆形围栏提交按钮
			$("#fenceSubmit2").click(function() {
				var flag;
				if ($("#fenceNameRound").val() == "") {
					$("#errorLabelRound").html("名字不能为空！")
					return false;
				} else {
					$.ajax({
						url:"http://127.0.0.1/ceshi.php",
						data:{
							"clientName" : $("#fenceNameRound").val()
						},
						type:"get",
						success:function(data) {
							if(data=="true"){
								flag = true;
							} else {
								flag = false;
							}
						},
						async : false
					})
				}
				if (!flag) {
					$("#errorLabelRound").html("名字已存在！")
					return false;
				}
				if ($("#fenceLngRound").val() == "") {
					return false;
				}
				;
				if ($("#fenceLatRound").val() == "") {
					return false;
				}
				;
				if ($("#fenceRadiusRound").val() <= 0) {
					return false;
				}

				$(".fenceRound .fenceForm").ajaxSubmit({
					type : 'post',
					dataType : "json",
					data : {
						"clientName":$("#fenceNameRound").val(),
						"fenceName":$("#fenceNameRound").val(),
						'centerLng':$("#fenceLngRound").val(),
						'centerLat':$("#fenceLatRound").val(),
						'roundFenceRadius':$("#fenceRadiusRound").val(),
						'fenceInfo':$("#fenceInfoRound").val()
					},
					success:function(){
						alert("提交成功！");
						$(".mengBan,#fenceWindow").css("display", "none");
					}
				})
			})
			//矩形围栏提交按钮
			$("#fenceSubmit1").click(function() {
				var flag;
				if ($("#fenceRectName").val() == "") {
					$("#errorLabelRect").html("名字不能为空！")
					return false;
				} else {
					$.ajax({
						url : "http://127.0.0.1/ceshi.php",
						data : {
							"clientName" : $("#fenceRectName").val()
						},
						type : "get",
						success : function(data) {
							if (data == "true") {
								flag = true;
							} else {
								flag = false;
							}
						},
						async : false
					})
				}
				if (!flag) {
					$("#errorLabelRect").html("名字已存在！")
					return false;
				}
				if ($("#fenceRectLenght").val() <0) {
					return false;
				}
				;
				if ($("#fenceRectWidth").val() <0) {
					return false;
				};
				$(".fenceRect .fenceForm").ajaxSubmit({
					type : 'post',
					dataType : "json",
					data:{
						'clientName':$("#fenceRectName").val(),
						'fenceRectName':$("#fenceRectName").val(),
						'fenceRectLenght':$("#fenceRectLenght").val(),
						'fenceRectWidth':$("#fenceRectWidth").val(),
						'rectStartPointLng':rectStartPoint.lng,
						'rectStartPointLat':rectStartPoint.lat,
						'rectEndPointLng':rectEndPoint.lng,
						'rectEndPointLat':rectEndPoint.lat,
						'fenceRectInfo':$("#fenceRectInfo").val()
					},
					success:function(){
						alert("提交成功！");
						$(".mengBan,#fenceWindow").css("display", "none");
					}
				})
			})

			//圆形围栏关闭按钮
			$("#fenceClose2").click(function() {
				$(".mengBan,#fenceWindow").css("display", "none");
				map.removeOverlay(circle);
			});
			$("#fenceClose1").click(function() {
				$(".mengBan,#fenceWindow").css("display", "none");
				map.removeOverlay(rect);
			});
			//取消按钮
			$("#fenceQuit2").click(function() {
				$(".mengBan,#fenceWindow").css("display", "none");
				map.removeOverlay(circle);
			});
			$("#fenceQuit1").click(function() {
				$(".mengBan,#fenceWindow").css("display", "none");
				map.clearOverlays(rect);
			});
		}
	</script>
</body>
</html>