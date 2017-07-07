$(function(){
	var windowWidth=window.screen.availWidth;
	var windowHeight=window.screen.availHeight;
	var hh=window.screen.height;
	var bodyHeight=$("body").height();
	if(windowWidth>=767){
		$(".outerIframeContainer").css("height",(bodyHeight-114)+"px")
	}else{
		$(".outerIframeContainer").css("height",(bodyHeight-84)+"px")
	}
	$("#navMenu li").click(function(){
	    $(this).addClass("active").siblings("li").removeClass("active")
	   })
	$("#navMenu a").click(function(){
		var hrefTarget=$(this).html();
		switch(hrefTarget){
		case "管理中心":
			$("#mainIframe").attr("src","menagerCenter.jsp");
			break;
		case "位置监测":
			$("#mainIframe").attr("src","positionCenter.jsp");
			break;
		case "统计报表":
			$("#mainIframe").attr("src","statisticalTable.jsp");
			break;
		case "系统管理":
			$("#mainIframe").attr("src","systemCenter.jsp");
			break;
			default:return;
		}
		
	})
})
$(window).resize(function(){
		var windowWidth=window.screen.availWidth;
		var windowHeight=window.screen.availHeight;
		var bodyHeight=$("body").height();
		if(windowWidth>=767){
			$(".outerIframeContainer").css("height",(bodyHeight-114)+"px")
		}else{
			$(".outerIframeContainer").css("height",(bodyHeight-84)+"px")
		}
		window.location.reload();
	})