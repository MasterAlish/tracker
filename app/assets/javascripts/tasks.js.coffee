# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  initNewCommentButton()

initNewCommentButton = ->
  $(".new_comment_button").click ->
    window.current_markup_result = $(this).parents(".task").find(".markup_result")
    $(".commenting").addClass 'hidden'
    $(this).parents(".task").find(".commenting").removeClass "hidden"
    false

