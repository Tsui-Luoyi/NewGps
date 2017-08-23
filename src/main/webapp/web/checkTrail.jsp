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
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=4d479f21ba6b7061741fab5a5a8bd6ba"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
<style type="text/css">
#map {
	width: 100%;
	height: 500px;
}

#result {
	width: 100%
}
</style>
</head>
<body>
	<h1>轨迹查询</h1>
	<div id="result"></div>
	<button id="run">开始</button>
	<button id="stop">停止</button>
	<button id="pause">暂停</button>
	<button id="hide">隐藏信息窗口</button>
	<button id="show">展示信息窗口</button>
	<div id="map"></div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		$(function(){
			function getQueryString(name) { 
				var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
				var r = window.location.search.substr(1).match(reg); 
				if (r != null) return decodeURI(r[2]); 
				return null; 
				}
			console.log(getQueryString("verhicalId"));
			console.log(getQueryString("verhicalName"));
			    var marker;
			    var map = new BMap.Map('map');
			    map.enableScrollWheelZoom();
			    map.centerAndZoom();
			    var lushu;
			    // 实例化一个驾车导航用来生成路线
			  //  var drv = new BMap.DrivingRoute('北京', {
			   //     onSearchComplete: function(res) {
			    //        if (drv.getStatus() == BMAP_STATUS_SUCCESS) {
			              //  var plan = res.getPlan(0);
			               // var arrPois =[];
//			                for(var j=0;j<plan.getNumRoutes();j++){
			                 //   var route = plan.getRoute(j);
			                 //   arrPois= arrPois.concat(route.getPath());
			               // }
			      var arrPois=[new BMap.Point(116.403984,39.914004),new BMap.Point(116.364605,39.913094),new BMap.Point(116.364127,39.913087),new BMap.Point(116.364126,39.913086),new BMap.Point(116.363917,39.913193),new BMap.Point(116.363827,39.913262),new BMap.Point(116.363797,39.913311),new BMap.Point(116.363767,39.913391),new BMap.Point(116.363767,39.913541),new BMap.Point(116.363757,39.913771),new BMap.Point(116.363757,39.913821),new BMap.Point(116.363737,39.91432),new BMap.Point(116.363687,39.914809),new BMap.Point(116.363647,39.915039),new BMap.Point(116.363617,39.915198),new BMap.Point(116.363567,39.915377),new BMap.Point(116.363527,39.915527),new BMap.Point(116.363487,39.915676),new BMap.Point(116.363438,39.915905),new BMap.Point(116.363436,39.915905),new BMap.Point(116.363327,39.916154),new BMap.Point(116.363327,39.916154),new BMap.Point(116.363356,39.916444),new BMap.Point(116.363376,39.916694),new BMap.Point(116.363504,39.917936),new BMap.Point(116.363404,39.918974),new BMap.Point(116.363384,39.919494),new BMap.Point(116.363374,39.919673),new BMap.Point(116.363374,39.919723),new BMap.Point(116.363374,39.919763),new BMap.Point(116.306974,40.057169)];
			            //    map.addOverlay(new BMap.Polyline(arrPois, {strokeColor: '#111'})); //不画线
			                map.setViewport(arrPois);
			                   marker=new BMap.Marker(arrPois[0],{
			                      icon  : new BMap.Icon('http://developer.baidu.com/map/jsdemo/img/car.png', new BMap.Size(52,26),{anchor : new BMap.Size(27, 13)})
			                   });
			      var label = new BMap.Label(getQueryString("verhicalName"),{offset:new BMap.Size(0,-30)});
			      label.setStyle({border:"1px solid rgb(204, 204, 204)",color: "rgb(0, 0, 0)",borderRadius:"10px",padding:"5px",background:"rgb(255, 255, 255)",});
			                marker.setLabel(label);
			                 
			      map.addOverlay(marker);
			     BMapLib.LuShu.prototype._move=function(initPos,targetPos,effect) {
			            var pointsArr=[initPos,targetPos];  //点数组
			            var me = this,
			                //当前的帧数
			                currentCount = 0,
			                //步长，米/秒
			                timer = 10,
			                step = this._opts.speed / (1000 / timer),
			                //初始坐标
			                init_pos = this._projection.lngLatToPoint(initPos),
			                //获取结束点的(x,y)坐标
			                target_pos = this._projection.lngLatToPoint(targetPos),
			                //总的步长
			                count = Math.round(me._getDistance(init_pos, target_pos) / step);
			                 //显示折线 syj201607191107
			            this._map.addOverlay(new BMap.Polyline(pointsArr, { 
			                strokeColor : "#111", 
			                strokeWeight : 5, 
			                strokeOpacity : 0.5 
			            })); // 画线 
			            //如果小于1直接移动到下一点
			            if (count < 1) {
			                me._moveNext(++me.i);
			                return;
			            }
			            me._intervalFlag = setInterval(function() {
			            //两点之间当前帧数大于总帧数的时候，则说明已经完成移动
			                if (currentCount >= count) {
			                    clearInterval(me._intervalFlag);
			                    //移动的点已经超过总的长度
			                    if(me.i > me._path.length){
			                        return;
			                    }
			                    //运行下一个点
			                    me._moveNext(++me.i);
			                }else {
			                        currentCount++;
			                        var x = effect(init_pos.x, target_pos.x, currentCount, count),
			                            y = effect(init_pos.y, target_pos.y, currentCount, count),
			                            pos = me._projection.pointToLngLat(new BMap.Pixel(x, y));
			                        //设置marker
			                        if(currentCount == 1){
			                            var proPos = null;
			                            if(me.i - 1 >= 0){
			                                proPos = me._path[me.i - 1];
			                            }
			                            if(me._opts.enableRotation == true){
			                                 me.setRotation(proPos,initPos,targetPos);
			                            }
			                            if(me._opts.autoView){
			                                if(!me._map.getBounds().containsPoint(pos)){
			                                    me._map.setCenter(pos);
			                                }  
			                            }
			                        }
			                        //正在移动
			                        me._marker.setPosition(pos);
			                        //设置自定义overlay的位置
			                        me._setInfoWin(pos);  
			                    }
			            },timer);
			        };
			                lushu = new BMapLib.LuShu(map,arrPois,{
			                defaultContent:getQueryString("verhicalName"),//"从天安门到百度大厦"
			                autoView:true,//是否开启自动视野调整，如果开启那么路书在运动过程中会根据视野自动调整
			                icon  : new BMap.Icon('http://developer.baidu.com/map/jsdemo/img/car.png', new BMap.Size(52,26),{anchor : new BMap.Size(27, 13)}),
			                speed: 14500,
			                enableRotation:true,//是否设置marker随着道路的走向进行旋转
			                   landmarkPois:[
			                   
			                  ]
			                    
			                }); 
			         
			      marker.addEventListener("click",function(){
			        marker.enableMassClear();   //设置后可以隐藏改点的覆盖物
			        marker.hide();
			        lushu.start();
			        //map.clearOverlays();  //清除所有覆盖物
			      });
			            //}
//			        }
			  //  });
			    //drv.search('天安门', '百度大厦');
			     // lushu.start();
			     // lushu.pause();
			    //绑定事件
			    $("run").onclick = function(){
			      marker.enableMassClear(); //设置后可以隐藏改点的覆盖物
			      marker.hide();
			      lushu.start();
			     // map.clearOverlays();    //清除所有覆盖物
			    }
			    $("stop").onclick = function(){
			        lushu.stop();
			    }
			    $("pause").onclick = function(){
			        lushu.pause();
			    }
			    $("hide").onclick = function(){
			        lushu.hideInfoWindow();
			    }
			    $("show").onclick = function(){
			        lushu.showInfoWindow();
			    }
			    function $(element){
			        return document.getElementById(element);
			    }
			
		})
	</script>
</body>
</html>