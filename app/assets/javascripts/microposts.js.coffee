$(document).ready ->
	$("div.hideWrap a.hideBtn").hover ->
		$(this).toggleClass("show").siblings("div.hideCont").slideToggle "noormal"
		false
	


#$(document).ready(function(){
#    $('micrposts.li').mouseenter(function(){
#        $('li').fadeTo('fast', 1);
#    });
#    $('li').mouseleave(function(){
#        $('li').fadeTo('fast', 0.5);
#    });
#});	