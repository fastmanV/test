

#= require raphael-min.js



$(document).ready(function(){

$("input[type='checkbox']").change(function() {
    if(this.checked) {
        $('.oldvlan').show();
    } else {
$('.oldvlan').hide();

    }

});

$('button').click(function(){


//$('.tr').empty();

$('div#r' + this.id).show().siblings("div").hide();;
//css("display", "block");
})
	

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
