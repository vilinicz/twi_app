$(document).ready ->
  
  # Start DocumentReady 
  $("div.hideWrap a.hideBtn").click ->
    $(this).toggleClass("show").siblings("div.hideCont").slideToggle "normal"
    false

