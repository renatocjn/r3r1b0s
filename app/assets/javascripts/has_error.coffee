# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $(".has-error").addClass('alert alert-warning')
  $(".has-error .help-block").addClass('text-danger')
  $(".has-error").effect('shake')