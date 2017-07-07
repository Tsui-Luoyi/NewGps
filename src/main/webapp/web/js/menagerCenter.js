// 图标的前面扩展、收起状态变化
$(function(){
	$(".panel-heading").click(function(){
        $(this).parent(".panel").siblings().find("span").removeClass("glyphicon-chevron-up").
        addClass("glyphicon-chevron-down");
        $(this).find("span").stop(true, true).toggleClass("glyphicon-chevron-down");
        $(this).find("span").stop(true, true).toggleClass("glyphicon-chevron-up")
    });
	$("#mcMenu .fontMenu").click(function(){
		var fontColor=$(".fontMenu").css("color");
		if(fontColor=="rgb(0, 0, 0)"){
			$(".fontMenu").css({"color":"white", "transform":"rotate(-90deg)"});
			console.log(123);
			$("#mB1").fadeIn();
		/*$("#mB1").removeClass("hidden-xs");*/
		}else{
			$(".fontMenu").css({"color":"rgb(0, 0, 0)","transform":"rotate(0deg)"})
			/*$("#mB1").addClass("hidden-xs");*/
			$("#mB1").fadeOut();
		}
	})
})
