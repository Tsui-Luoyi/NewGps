//刀郎蓝点击选项变色
$(function(){
	$("#navMenu li").click(function(){
    $(this).addClass("active").siblings("li").removeClass("active")
   })
})