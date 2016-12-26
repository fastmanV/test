
$(document).ready(function(){

$("input[type='checkbox']").change(function() {
    if(this.checked) {
        $('.oldvlan').show();
    } else {
$('.oldvlan').hide();

    }

});

});