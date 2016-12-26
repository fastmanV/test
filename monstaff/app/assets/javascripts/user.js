$(document).ready(function(){


$("#my_search").keyup(function(){
var inputtext = $(this).val();



$.ajax({
 
  dataType: "script",
type:"get",
  url:"/user",
  
  data: {search: inputtext},
  success:function(result){
   //alert('success');
  }
});


});
	

$( "div#ok2" ).load(function() {
  // Handler for .load() called.
alert('ok2');
});






$("#1").click(function(){
        $("#region").toggle();
$("#region_name").val('');
    });


$("#2").click(function(){
        $("#group").toggle();
$("#group_name").val('');
    });
});
