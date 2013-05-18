# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
initUpDownHeaderButton = ->
  $("a.updown").click ->
    if $("body").hasClass("big-header")
      $("body").css
        "padding-top":"50px"
      $("div.navbar-inner").css
        "min-height": "40px"
      $("body").removeClass "big-header"
      $("div.navbar-inner").removeClass "big-header"
      $(this).children("i").removeClass()
      $(this).children("i").addClass "icon-chevron-down"
      setTimeout (->$("header .properties").addClass "hidden"),100
    else
      $("body").css
        "padding-top":(window.chevron_height+50)+"px"
      $("div.navbar-inner").css
        "min-height":(window.chevron_height+45)+"px"
      $("body").addClass "big-header"
      $("div.navbar-inner").addClass "big-header"
      $(this).children("i").removeClass()
      $(this).children("i").addClass "icon-chevron-up"
      setTimeout (->$("header .properties").removeClass "hidden"),200
    return false

$(document).ready ->
  initUpDownHeaderButton()
  window.chevron_height = $("header .properties").height()
  $("a.updown").click()
