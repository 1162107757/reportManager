$(".sidebar-scroll a").click(function(){
	window.location.href = basePath + "jump?type=" + $(this).attr("type") + "&pageCode=" + $(this).attr("id");
});