$(document).ready ->
	$("div.hideWrap a.hideBtn").click ->
		$(this).toggleClass("show").siblings("div.hideCont").slideToggle "noormal"
		false
		