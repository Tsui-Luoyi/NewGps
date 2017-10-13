<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
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
<!-- 网页不会被缓存 -->
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<!-- 解决部分兼容性问题，如果安装了GCF，则使用GCF来渲染页面，如果未安装GCF，则使用最高版本的IE内核进行渲染。 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- 页面按原比例显示 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" href="css/baidu.css">
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
<link
	href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=4d479f21ba6b7061741fab5a5a8bd6ba"></script>
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
<!-- 拉框搜索 -->
<script type="text/javascript"
	src="http://api.map.baidu.com/library/SearchInRectangle/1.2/src/SearchInRectangle_min.js"></script>
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

.cel, .findCar {
	position: absolute;
	background-color: #fff;
	box-shadow: rgba(0, 0, 0, 0.35) 0px 2px 3px;
	color: #000;
	z-index: 20;
	border: 1px #8ba4dc solid;
	padding: 2px 6px;
	font-size: 12px;
	line-height: 1.3em;
	border-radius: 20px;
}
/* 测距 */
.cel {
	top: 20px;
	right: 216px;
}
/* 查车 */
.findCar {
	top: 20px;
	right: 155px;
}
/* 路况 */
#tcBtn {
	box-shadow: rgba(0, 0, 0, 0.35) 2px 2px 3px;
	border: 1px #8ba4dc solid;
	border-radius: 20px;
}
/*上方灰背景条 */
#topBar {
	position: absolute;
	z-index: 1;
	opacity: 0.4;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=40);
	top: 17px;
	height: 30px;
	background: #000;
	color: white;
	width: 100%;
}
/* 地图类型 */
.anchorTR>div div {
	border-radius: 20px !important;
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

#fenceWindow #errorLabelRound {
	color: red;
	height: 20px;
	float: none;
	font-size: 12px;
	margin: 0 0 0 3px
}

#fenceWindow #errorLabelRect {
	color: red;
	height: 20px;
	float: none;
	font-size: 12px;
	margin: 0 0 0 3px
}

#fenceWindow #errorLabelPolygon {
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
/*区域查车结果  */
#findVerhicleResult {
	background-color: #fff;
	opacity: 0.8;
	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=80);
	position: absolute;
	z-index: 5;
	color: #000;
	width: 80%;
	height: 500px;
	top: 50%;
	left: 50%;
	margin-left: -40%;
	margin-top: -280px;
	padding: 0 8px;
	display: none;
}

#findVerhicleResult h4: {
	font-weight: bolder;
}

#findVerhicleResult h4 span {
	font-size: 25px;
	display: inline-block;
	width: 20px;
	height: 20px;
	line-height: 20px;
	text-align: center;
	float: right;
	margin-right: 30px;
	border: 1px black solid;
	border-radius: 50%;
}
/* 围栏框关闭按钮 */
#findVerhicleResult h4 span:hover {
	cursor: pointer
}

#findVerhicleResult hr {
	margin: 5px 0px;
	border-top: 2px #000 solid;
}
/* 结果表格 */
#resultTable {
	border: 2px black solid;
	width: 100%;
	text-align: center;
	border-collapse: collapse
}

#resultContainer {
	width: 100%;
	height: 410px;
	overflow: scroll
}

#resultTable th {
	border: 2px black solid;
	text-align: center;
	height: 20px;
}

#resultTable td {
	height: 15px;
	padding: 2px
}

#jump {
	position: absolute;
	bottom: 5px;
	left: 220px;
	z-index: 50;
}

#jump input {
	width: 60px;
}
/* 报警按钮 */
#lookAlarm {
	position: absolute;
	right: 0;
	top: 100px;
	z-index: 1000;
	/* border: 1px red solid; */
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
					<label>围栏名称：</label><input id="fenceRoundName" type="text"><label
						id="errorLabelRound"></label>
				</p>
				<p>
					<label>中心经度：</label><input disabled="disabled" id="fenceLngRound"
						type="text">
				</p>
				<p>
					<label>中心纬度：</label><input disabled="disabled" id="fenceLatRound"
						type="text">
				</p>
				<p>
					<label>围栏半径：</label><input disabled="disabled"
						id="fenceRadiusRound" type="text"><span>千米</span>
				</p>
				<div>
					<label>围栏备注：</label>
					<textarea id="fenceRoundInfo" cols="40" rows="3"></textarea>
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
		<div class="fencePolygon">
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
					<label>围栏名称：</label><input id="fencePolygonName" type="text"><label
						id="errorLabelPolygon"></label>
				</p>
				<div>
					<label>围栏备注：</label>
					<textarea id="fencePolygonInfo" cols="40" rows="5"></textarea>
				</div>
				<p>
					<input id="fenceSubmit3" type="button" value="保存"><input
						id="fenceQuit3" type="button" value="取消">
				</p>
			</form>
		</div>
	</div>
	<!-- 左边选择的复选框ID -->
	<input id="carId" type="hidden" value="" />
	<input id="clickCarId" type="hidden" value="" />
	<input id="selectedMarkerId" type="hidden" value="" />
	<input id="clickMarkerId" type="hidden" value="" />
	<input id="selectedFenceId" type="hidden" value="" />
	<!-- 查车结果面板 -->
	<div id="findVerhicleResult">
		<h4>
			区域内车辆:<span title="关闭">&times;</span>
		</h4>
		<hr />
		<div id="resultContainer">
			<table id="resultTable" width="100%" height="" cellspacing="0"
				cellpadding="0" border="1">
				<thead>
					<tr>
						<th>车辆ID</th>
						<th>定位方式</th>
						<th>最后回传时间</th>
						<th>车辆位置</th>
						<th>查看轨迹</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	<div id="map"></div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.form.js"></script>
	<script src="js/jquery.dataTables.js"></script>
	<script src="js/baidu.js"></script>
	<!--[if lt IE 9]>
	console.log("can")
      <script src="js/excanvas.compiled.js"></script>
       <![endif]-->
</body>
</html>