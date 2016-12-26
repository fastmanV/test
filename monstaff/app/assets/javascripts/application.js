//= require jquery
//= require jquery_ujs
//= require rails.validations
//= require bootstrap
#= require raphael-min.js


	$(document).ready(function(){
$('a').on('ajax:beforeSend', function(event, xhr, settings) {
$('#myModalload').show();
$("#img01").append('<img  src="http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_512.gif" />');


});


$('a').on('ajax:success', function(event, xhr, status, error) {

  $('#myModalload').hide();
$("#img01").empty();

});


$('a').on('ajax:error', function(event, xhr, status, error) {
  $('#myModalload').hide();
  $("#img01").empty();
alert(error);
});

   });


