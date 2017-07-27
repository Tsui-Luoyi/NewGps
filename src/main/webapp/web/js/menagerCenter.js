// 图标的前面扩展、收起状态变化
$(function() {
	$(".panel-heading").click(
			function() {
				$(this).parent(".panel").siblings().find("span").removeClass(
						"glyphicon-chevron-up").addClass(
						"glyphicon-chevron-down");
				$(this).find("span").stop(true, true).toggleClass(
						"glyphicon-chevron-down");
				$(this).find("span").stop(true, true).toggleClass(
						"glyphicon-chevron-up")
			});
	$("#managerParent .panel li").click(function() {
		$("#managerParent .panel li").removeClass("active");
		$(this).addClass("active");
	})
	$("#managerParent .panel li a").click(function() {
		console.log($(this).html())
	})
	$("#mcMenu .fontMenu").click(function() {
		var fontColor = $(".fontMenu").css("color");
		console.log(fontColor=="black");
		if (fontColor == "rgb(0, 0, 0)"||fontColor=="black") {
			$(".fontMenu").css({
				"color" : "white",
				"transform" : "rotate(-90deg)"
			});
			$("#mB1").fadeIn();
			/* $("#mB1").removeClass("hidden-xs"); */
		} else {
			$(".fontMenu").css({
				"color" : "black",
				"transform" : "rotate(0deg)"
			})
			/* $("#mB1").addClass("hidden-xs"); */
			$("#mB1").fadeOut();
		}
	})
})
// 左侧跳转的iframe路径
function changeIframe(obj, target) {
	var dd=Math.random()*9999;
	$(obj).attr("src", target+"?d="+dd);
}
