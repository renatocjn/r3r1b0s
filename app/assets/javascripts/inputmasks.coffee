# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  $(".cpf_cnpj_inputs").inputmask
    mask: ['999.999.999-99', '99.999.999/9999-99'],
    keepStatic: true

  $(".cpf_inputs").inputmask
    mask: '999.999.999-99',
    keepStatic: true

  $(".date_inputs").inputmask
    mask: '99/99/9999',
    keepStatic: true

#  $("input[type=number]").inputmask
#     regex: '[0-9]*',
#     keepStatic: true

#$(document).ready(ready)
$(document).on 'turbolinks:load', ready