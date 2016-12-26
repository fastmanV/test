//#= require jquery.js
//*=  require bootstrap-datepicker.min.js



$(function($){
	$.fn.datepicker.dates['ru'] = {
		days: ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"],
		daysShort: ["Вск", "Пнд", "Втр", "Срд", "Чтв", "Птн", "Суб"],
		daysMin: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
		months: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"],
		monthsShort: ["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек"],
		today: "Сегодня",
		clear: "Очистить",
		format: "dd.mm.yyyy",
		weekStart: 1
	};
}(jQuery));


 $(function() {


$('#ok').click(function() {
   
function submitForm(form){
var url = form.attr("action");
alert(url);
}


  });




$('#permission_link').click(function(){
$('#myModal').show();
});

$('.close').click(function(){
//$('#myModal').empty();
$('#myModal').hide();	
}
	)


   $( ".datepickers" ).datepicker({
multidate: true,
format: 'yyyy-mm-dd',
language: "ru" });

 $( ".vacs" ).datepicker({

format: 'yyyy-mm-dd',
language: "ru"
}
);
 $( ".timepick" ).datepicker({

pickDate: false,
language: "ru"
}
);

 $( ".xlssclass" ).datepicker({

format: 'yyyy-mm-dd',
language: "ru"
}
);


//format: 'yyyy/mm/dd'

  });


