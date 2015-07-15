$(document).on("ready",inicio);    
function inicio(){				
	var d = new Date();
    var strDate = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();    		
	

	$('#txt_1, #txt_2, #txt_3, #txt_4, #txt_5, #txt_6, #txt_7, #txt_8, #txt_9').datepicker({
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
