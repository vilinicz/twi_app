$(document).ready ->
	$("body").on('click', "div.hideWrap a.hideBtn", ->
		$(this).toggleClass("show").siblings("div.hideCont").slideToggle "slow" 
		false )

$(document).ready ->
	$("body").on('ajax:success', '.delete_post', ->
    	$(this).closest('li').fadeOut() )
 

$(document).ready ->
  	$("body").on('hover', '.block', ->
    	$(this).toggleClass "highlighted" )