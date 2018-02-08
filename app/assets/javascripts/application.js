// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require refile
//= require jquery-ui/effects/effect-shake
//= require_tree ../../../vendor/assets/javascripts
//= require_tree .

/*global $*/ //supressão de warning

// var options = {
//   onKeyPress: function(cpf, ev, el, op) {
//     var masks = ['000.000.000-000', '00.000.000/0000-00'];
//     var mask = (cpf.length > 13) ? masks[1] : masks[0];
//     console.log(cpf.length);
//     console.log(mask);
//     $(el).mask(mask, op);
//   }
// };

// $(function() {
//   $('.cpf_cnpj_inputs').mask('000.000.000-000', options);
// });

$(function() {
  console.log((new Date).getTime());

  $(".cpf_cnpj_inputs").inputmask({
    mask: ['999.999.999-99', '99.999.999/9999-99'],
    keepStatic: true
  });

  $(".cpf_inputs").inputmask({
    mask: '999.999.999-99',
    keepStatic: true
  });

  $(".date_inputs").inputmask({
    mask: '99/99/9999',
    keepStatic: true
  });

  // $("input[type=number]").inputmask({
  //   regex: '\\d*'
  // });
});
