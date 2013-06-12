$(document).ready ->
	$("div.hideWrap a.hideBtn").click ->
		$(this).toggleClass("show").siblings("div.hideCont").slideToggle "noormal"
		false
	
$(document).ready( ->
  $('.delete_post').bind('ajax:success', ->
    $(this).closest('li').fadeOut();
  );
);
