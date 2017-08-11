jQuery.support.cors = true;
		window.onload = function() {
			var car = null;
			if (document.attachEvent) {
				console.log("atteach")
				document.attachEvent("onstorage", function(e) {
					car = sessionStorage.getItem("selectedCar");
					document.getElementById("carId").value = car;
					$("#carId").change();
				})
			} else {
				window.addEventListener("storage", function(e) {
					console.log("storage改变的键"+e.key);
					console.log(e.oldValue);
					console.log(e.newValue);
					car = sessionStorage.getItem("selectedCar");
					document.getElementById("carId").value = car;
					$("#carId").change();

				});
			}
			//添加bind事件
			if (!Function.prototype.bind) { 
				Function.prototype.bind = function (oThis) { 
				if (typeof this !== "function") { 
				throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable"); 
				} 
				var aArgs = Array.prototype.slice.call(arguments, 1), 
				fToBind = this, 
				fNOP = function () {}, 
				fBound = function () { 
				return fToBind.apply(this instanceof fNOP && oThis 
				? this
				: oThis, 
				aArgs.concat(Array.prototype.slice.call(arguments))); 
				}; 
				fNOP.prototype = this.prototype; 
				fBound.prototype = new fNOP(); 
				return fBound; 
				}; 
				}
			var point = new BMap.Point(116.404, 39.915);
			var map = new BMap.Map("map"); // 创建Map实例
			var cel = $("<div class='cel'>测距</div>");
			var findCar= $("<div class='findCar'>区域查车</div>");
			var topBar= $("<div id='topBar'></div>");
			cel.prependTo($("#map"));
			findCar.prependTo($("#map"));
			topBar.prependTo($("#map"));
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
			mapType1.setOffset(new BMap.Size(253, 20));
			map.addControl(mapType1);
			//路况
			var mapType2 = new BMapLib.TrafficControl();
			mapType2.setOffset(new BMap.Size(82, 20));
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
				map.disableDoubleClickZoom();
				polygonPoint=[];
				polygonLng=[];
				polygonLat=[];
				addPolygon(e);
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
  
			$(".findCar").on("click",function(){
				if($(this).html()=="区域查车"){
					$(this).css({
						"backgroundColor" : "rgb(142, 168, 224)",
						"color" : "white"
					});
					$(this).html("添加围栏")
				}else{
					$(this).html("区域查车");
					$(this).css({
						"backgroundColor" : "white",
						"color" : "black"
					});
				}
			
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
														//canvas离线车辆点击信息框
														pointCollection2.addEventListener('click',
																function(e) {
															$.ajax({
																url : "data/car.json",
																data : {
																	//"clientName" : $("#markerName").val(),
																	"Lng":e.point.lng,
																	"lat":e.point.lat
																},
																type : "get",
																success : function(data) {
																	var opts = {
																			width : 240, // 信息窗口宽度
																			height : 0, // 信息窗口高度
																			title : "车辆详细信息"
																		};
																	var content=[];
																	content.push("<hr/>");
																	content.push("<li><strong>车辆ID：</strong>"+ data.id+ "</li>")
																	content.push("<li><strong>车辆状态：</strong>离线</li>");
																	content.push("<li><strong>车辆位置：</strong>"+ data.add+ "</li>")
																	var infoWindow = new BMap.InfoWindow(content.join(""), opts); // 创建信息窗口对象 
																	map.openInfoWindow(infoWindow, new BMap.Point(e.point.lng,e.point.lat)); //开启信息窗口 
																},
																error : function(e) {
																},
																async : false
															})
																			
														});
														//canvas在线车辆点击信息框
														pointCollection1.addEventListener('click',
																function(e) {
															$.ajax({
																url : "data/car.json",
																data : {
																	//"clientName" : $("#markerName").val(),
																	"Lng":e.point.lng,
																	"lat":e.point.lat
																},
																type : "get",
																success : function(data) {
																	var opts = {
																			width : 240, // 信息窗口宽度
																			height : 0, // 信息窗口高度
																			title : "车辆详细信息"
																		};
																	var content=[];
																	content.push("<hr/>");
																	content.push("<li><strong>车辆ID：</strong>"+ data.id+ "</li>")
																	content.push("<li><strong>车辆状态：</strong>在线</li>");
																	content.push("<li><strong>车辆位置：</strong>"+ data.add+ "</li>")
																	var infoWindow = new BMap.InfoWindow(content.join(""), opts); // 创建信息窗口对象 
																	map.openInfoWindow(infoWindow, new BMap.Point(e.point.lng,e.point.lat)); //开启信息窗口 
																},
																error : function(e) {
																},
																async : false
															})
																			
														});
														map
																.addOverlay(pointCollection1); // 添加Overlay
														map
																.addOverlay(pointCollection2);
													} else {
														alert('IE8及以下每次选择的车辆不要超过500辆；若超过500辆请在chrome、safari、IE8+以上浏览器查看,');
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
										type : "post",
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
			//删除标记
			function deleteBtn(e, ev, marker) {
				if (confirm("是否删除给标记？")) {
					$.ajax({
						url : "http://127.0.0.1/ceshi.php",
						data : {
							"clientName" : "123"
						},
						//data:{"markerLng":marker.getPosition().lng,"markerLat":marker.getPosition().lat},
						type : "post",
						async : false,
						success : function() {
							map.removeOverlay(marker);
						}
					});
				}
			}
			//添加圆形
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
			//删除圆形
			function deleteRound(e, ev, circle) {
				console.log(circle);
				console.log(circle.getCenter().lat);
				if (confirm("是否删除该围栏？")) {
					$.ajax({
						url : "http://127.0.0.1/ceshi.php",
						data : {
							"clientName" : "123",
							'centerLng':circle.getCenter().lng,
							'centerLat':circle.getCenter().lat,
							'roundFenceRadius':(circle.getRadius()/1000).toFixed(3)
						},
						type : "post",
						async : false,
						success : function() {
							map.removeOverlay(circle);
						}
					});
				}
			}
			//隐藏圆形
			function hideRound(e, ev, circle) {
				map.removeOverlay(circle);
			}
			//添加矩形
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
			 //删除矩形
			function deleteRect(e, ev, rect) { 
				 console.log(rect.po[0].lng);
				 if(confirm("是否删除该围栏？")){
						$.ajax({
							url:"http://127.0.0.1/ceshi.php",
							data:{
								'clientName' : "123",
								'fenceType':"rect",
								'rectStartPointLng':rect.po[0].lng,
								'rectStartPointLat':rect.po[0].lat,
								'rectEndPointLng':rect.po[3].lng,
								'rectEndPointLat':rect.po[3].lat
							},
							type:"post",
							async:false,
							success:function(){
							map.removeOverlay(rect);
							}
						});
					}
			}
			//隐藏矩形
			function hideRect(e, ev, rect) {
				map.removeOverlay(rect);
			} 
			function addPolygon(e){
				flagPolygon = true;
				rectStartPoint = new BMap.Point(e.lng, e.lat);
				polygon = new BMap.Polygon();
				polygonPoint.push(new BMap.Point(e.lng, e.lat));
				polygonLng.push(e.lng);
				polygonLat.push(e.lat);
				polygon.setPath(polygonPoint);
				polygon.setStrokeColor("red");
				polygon.setStrokeWeight("2");
				polygon.setFillColor("#000");
				polygon.setFillOpacity("0.5");
				
				var rectMenu=new BMap.ContextMenu();
				rectMenu.addItem(new BMap.MenuItem("隐藏围栏", hidePolygon.bind(polygon),{
					width : "130",
					iconUrl : "images/hide.png"
				}));
				rectMenu.addItem(new BMap.MenuItem("删除围栏", deletePolygon.bind(polygon),
						{
							width : "130",
							iconUrl : "images/del.png"
						}));
				polygon.addContextMenu(rectMenu);
			}
			//隐藏多边形
			function hidePolygon(e,ev,polygon){
				map.removeOverlay(polygon);
			}
			//百度点数组按经度升序
			function lngSort(a,b){
				return a.lng-b.lng;
			}
			//删除多边形
			function deletePolygon(e,ev,polygon){
				var lng=[]
				var lat=[];
				console.log(polygon.getPath());
				 if(confirm("是否删除该围栏？")){
					 for(var i=0;i<polygon.getPath().length;i++){
						 lng.push(polygon.getPath()[i].lng);
						 lat.push(polygon.getPath()[i].lat);
					 }
					 console.log(lng);
						$.ajax({
							url:"http://127.0.0.1/ceshi.php",
							data:{
								'clientName' : "123",
								'fenceType':"polygon",
								'lngString':lng.join(","),
								'latString':lat.join(",")
							},
							type:"post",
							async:false,
							success:function(){
							map.removeOverlay(polygon);
							}
						});
					}
				
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
			var flagPolygon = false;
			//多边形点数组
			var polygonPoint=null;
			//多边形经度数组
			var polygonLng=null;
			//多边形纬度数组
			var polygonLat=null;
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
					//map.clearOverlays(rect);
					rectEndPoint = new BMap.Point(ev.point.lng, ev.point.lat);
					rect.setPositionAt(0,new BMap.Point(rectStartPoint.lng,rectStartPoint.lat));
					rect.setPositionAt(1,new BMap.Point(rectEndPoint.lng,rectStartPoint.lat));
					rect.setPositionAt(2,new BMap.Point(rectEndPoint.lng,rectEndPoint.lat));
					rect.setPositionAt(3,new BMap.Point(rectStartPoint.lng,rectEndPoint.lat))
					map.addOverlay(rect);
				};
				//多边形
				if(flagPolygon){
					dblFlag=true;
					polygonPoint.push(new BMap.Point(ev.point.lng, ev.point.lat));
					polygon.setPath(polygonPoint);
					polygonPoint.pop();
					map.addOverlay(polygon);	
				}

			})
			map.addEventListener("click",function(ev){
				if(dblFlag&&flagPolygon){
					polygonPoint.push(new BMap.Point(ev.point.lng, ev.point.lat));
					polygonLng.push(ev.point.lng);
					polygonLat.push(ev.point.lat);
					polygon.setPath(polygonPoint);
					map.addOverlay(polygon);
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
								$("#fenceRoundName").val("");
								$("#fenceRoundInfo").val("");
								$("#fenceLngRound").val(roundPoint.lng);
								$("#fenceLatRound").val(roundPoint.lat);
								$("#fenceRadiusRound").val((roundDis / 1000).toFixed(3));
							} else if (flagRect) {
								flagRect = false;
								$(".mengBan,#fenceWindow").css("display",
										"block");
								$("#fenceWindow>div").css("display", "none");
								$(".fenceRect").css("display", "block");
								$("#fenceRectName").val("");
								$("#fenceRectInfo").val("");
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
							}else{
								flagPolygon=false;
								//去除最后双击添加的点（有时候加，有时候不加）
								for(var i=polygonLng.length-1;i>0;i--){
									if((polygonLng[polygonLng.length-1]==polygonLng[polygonLng.length-2])|(polygonLat[polygonLng.length-1]==polygonLat[polygonLng.length-2])){
										console.log("一样");
										polygonLng.pop();
										polygonLat.pop();
										polygonPoint.pop();
									}else{
										console.log("不一样");
										break;
									}
								}
								polygon.setPath(polygonPoint);
								map.addOverlay(polygon);
								$(".mengBan,#fenceWindow").css("display",
								"block");
								$("#fenceWindow>div").css("display", "none");
								$(".fencePolygon").css("display", "block");
								$("#fencePolygonName").val("");
								$("#fencePolygonInfo").val("");
							}
							dblFlag = false;
						} else {
							map.enableDoubleClickZoom();
						}
					})
			//圆形围栏提交按钮
			$("#fenceSubmit2").click(function(){
				var flag;
				if ($("#fenceRoundName").val() == "") {
					$("#errorLabelRound").html("名字不能为空！")
					return false;
				} else {
					$.ajax({
						url:"http://127.0.0.1/ceshi.php",
						data:{
							"clientName" : $("#fenceRoundName").val()
							//"fenceName" : $("#fenceRoundName").val()
						},
						type:"post",
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
						"clientName":$("#fenceRoundName").val(),
						'fenceType':"round",
						"fenceName":$("#fenceRoundName").val(),
						'centerLng':$("#fenceLngRound").val(),
						'centerLat':$("#fenceLatRound").val(),
						'roundFenceRadius':$("#fenceRadiusRound").val(),
						'fenceInfo':$("#fenceInfoRound").val()
					},
					success:function(){
						roundPoint=null;
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
							//"fenceName" : $("#fenceRectName").val()
						},
						type : "post",
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
						'fenceType':"rect",
						'fenceName':$("#fenceRectName").val(),
						'fenceRectLenght':$("#fenceRectLenght").val(),
						'fenceRectWidth':$("#fenceRectWidth").val(),
						'rectStartPointLng':rectStartPoint.lng,
						'rectStartPointLat':rectStartPoint.lat,
						'rectEndPointLng':rectEndPoint.lng,
						'rectEndPointLat':rectEndPoint.lat,
						'fenceInfo':$("#fenceRectInfo").val()
					},
					success:function(){
						rectStartPoint=null;
						rectEndPoint=null;
						rectWidth=null;
						rectHeight;
						alert("提交成功！");
						$(".mengBan,#fenceWindow").css("display", "none");
					}
				})
			})

			//多边形围栏提交按钮
			$("#fenceSubmit3").click(function() {
				console.log(polygonLng);
				console.log(polygonLat);
				var flag;
				if ($("#fencePolygonName").val() == "") {
					$("#errorLabelPolygon").html("名字不能为空！")
					return false;
				} else {
					$.ajax({
						url:"http://127.0.0.1/ceshi.php",
						data:{
							"clientName" : $("#fencePolygonName").val()
							//"fenceName":$("#fencePolygonName").val()
						},
						type:"post",
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
				$(".fencePolygon .fenceForm").ajaxSubmit({
					type : 'post',
					dataType : "json",
					data : {
						'clientName':$("#fencePolygonName").val(),
						'fenceType':"polygon",
						'fenceName':$("#fencePolygonName").val(),
						'lngString':polygonLng.join(","),
						'latString':polygonLat.join(","),
						'fenceInfo':$("#fencePolygonInfo").val()
					},
					success:function(){
						polygonPoint=null;
						polygonLng=null;
						polygonLat=null;
						alert("提交成功！");
						$(".mengBan,#fenceWindow").css("display", "none");
					}
				})
			})
			//圆形围栏关闭/取消按钮
			$("#fenceClose2,#fenceQuit2").click(function() {
				$(".mengBan,#fenceWindow").css("display", "none");
				map.removeOverlay(circle);
			});
			//矩形关闭/取消按钮
			$("#fenceClose1,#fenceQuit1").click(function() {
				$(".mengBan,#fenceWindow").css("display", "none");
				map.removeOverlay(rect);
			});
			//多边形关闭/取消按钮
			$("#fenceClose3,#fenceQuit3").click(function() {
				$(".mengBan,#fenceWindow").css("display", "none");
				map.removeOverlay(polygon);
			});
		}