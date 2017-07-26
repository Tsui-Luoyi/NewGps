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
<link rel="stylesheet" href="css/positionCenter.css">
<link rel="stylesheet" href="css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="css/media.css">
<link rel="stylesheet" href="css/color.css">
<style>
     .ztree li span.button.group_ico_open,.ztree li span.button.group_ico_close{
     	background-image:url("css/zTreeStyle/img/diy/group.png")
     }
     .ztree li span.button.group_ico_docu{
     	background-image:url("css/zTreeStyle/img/diy/group.png")
     }
    .ztree li span.button.offLine_ico_docu{
     	background-image:url("css/zTreeStyle/img/diy/offline.png");
     }
    .ztree li span.button.onLine_ico_docu{
    	background-image:url("css/zTreeStyle/img/diy/online.png");
    };
	</style>
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<!--[if lt IE 9]>
       <script src="js/HTML5Shiv.min.js"></script>
       <script src="js/response.js"></script>
       <![endif]-->
</head>
<body>
	<div class="container-fluit">
		<div class="row-fluit clearfix">
			<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12" id="mB2">
				<ul id="positionTab" class="nav nav-tabs">
					<li class="active"><a href="#group" data-toggle="tab">分组
					</a></li>
					<li><a href="#mark" data-toggle="tab">标注</a></li>
					<li><a href="#ios2" data-toggle="tab">围栏</a></li>
					<li><a href="#ios3" data-toggle="tab">报警</a></li>
				</ul>
				<div id="myTabContent" class="tab-content clearfix">
					<div class="tab-pane fade in active" id="group">
						<ul id="groupTree" class="ztree"></ul>
					</div>
					<div class="tab-pane fade" id="mark">
						<ul id="markTree" class="ztree"></ul>
					</div>
					<div class="tab-pane fade" id="ios2">
						<p>jMeter 是一款开源的测试软件。它是 100% 纯 Java 应用程序，用于负载和性能测试。</p>
					</div>
					<div class="tab-pane fade" id="ios3">
						<p>Enterprise Java
							Beans（EJB）是一个创建高度可扩展性和强大企业级应用程序的开发架构，部署在兼容应用程序服务器（比如 JBOSS、Web
							Logic 等）的 J2EE 上。</p>
					</div>
				</div>
			</div>

			<!-- <div id="midToggleBar"></div> -->
			<div id="changeMap"><strong>切换地图：</strong><select name="" id="">
					<option selected="selected" value="BD">百度地图</option>
					<option value="GD">高德地图</option>
					<option value="GG">谷歌地图</option>
				</select></div>
			<div class="col-lg-10 col-md-9 col-sm-9 col-xs-12"
				id="positionInnerIframeContainer">
				<div id="midToggleBar"></div>
				<iframe id="positionInnerIframe" src="baidu.jsp" frameborder="0"
					scrolling="yes" style="width: 100%; height: 100%">浏览器不支持，请升级或更换浏览器</iframe>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.ztree.all.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/positionCenter.js"></script>
	<script>
	        	$(document).ready(function(){
	        		var setting = {
	        				check:{
	        					enable:true,
	        					autoCheckTrigger:true,
	        					chkStyle: "checkbox",
	        					chkboxType:{"Y":"s","N":"s"}
	        				},
	        				data:{
	        					simpleData:{
	        						enable: true,
	        						idKey: "id",
	        						pIdKey: "pId",
	        						rootPId: 0
	        					},
	        					keep: {
	        							parent: true
	        						}
	        				},
	        				async:{
	        					autoParam: ["id","name","isParent"],
	        					enable:true,
	        					dataType:"text",
	        					type:"get",
	        					url:"data/data2.json",
	        						dataFilter: ajaxDataFilter
	        				},
	        				callback:{
	        					onClick:function(event, treeId, treeNode){
	        						if(treeNode.pId!=null){
	        						    alert("id:"+treeNode.id + ", name:" + treeNode.name+",父ID："+treeNode.pId);
	        						}
	        					},
	        					onCheck: zTreeOnCheck
	        				}
	        			};
	        		$.fn.zTree.init($("#groupTree"), setting);
	        		$.fn.zTree.init($("#markTree"), setting);
	        		function ajaxDataFilter(treeId, parentNode, responseData) {
	        		    if (responseData) {
	        		      for(var i =0; i < responseData.length; i++) {
	        		        if(responseData[i].pId== "0"){
	        		        	responseData[i].isParent==true
	        		        };
	        		      }
	        		    }
	        		    return responseData;
	        		};
	        		var a;
	        		function zTreeOnCheck(event, treeId, treeNode){
	        			a=[]
	        			var treeObj = $.fn.zTree.getZTreeObj("groupTree");
	        			var nodes =treeObj.getChangeCheckedNodes();
	        			for(var i=0;i<nodes.length;i++){
	        				/* console.log(nodes[i].id); */
	        				if(nodes[i].pId!='0'){
	        					a.push(nodes[i].id);
	        				}
	        			}
	        			var selectedCar=a.join(",");
	        			sessionStorage.setItem("selectedCar",selectedCar);
	        			
	        		}
	        		
	        	});
	        	
	        	
	        	
	</script>
</body>
</html>