$(document).on("ready",inicio);    
function inicio(){				
	var d = new Date();
    var strDate = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();    		
	$('#txt_1').datepicker({
		autoclose: "true",
		calendarWeeks: "true",
		clearBtn: "true",
		format: "yyyy-mm-dd",
		todayHighlight: "true",
		setDate: strDate,
		startDate: '+0d',
		language: 'es',
	}).datepicker("setDate", strDate);		  	  	

	$('#txt_2').datepicker({
		autoclose: "true",
		calendarWeeks: "true",
		clearBtn: "true",
		format: "yyyy-mm-dd",
		todayHighlight: "true",
		setDate: strDate,
		startDate: '+0d',
		language: 'es',
	}).datepicker("setDate", strDate);		

	
}
