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
	tipo_documento();
	///////////////

	$("#btn_1").on('click',function(){
		window.open("../../reportes/reporte_fechas.php?inicio="+$("#txt_1").val()+"&fin="+$("#txt_2").val());
	});

	$("#btn_2").on('click',function(){
		window.open("../../reportes/reporte_peso.php?inicio="+$("#txt_3").val()+"&fin="+$("#txt_4").val());
	});

	$("#btn_3").on('click',function(){
		window.open("../../reportes/reporte_dia.php?inicio="+$("#txt_5").val()+"&fin="+$("#txt_5").val());
	});

	$("#btn_4").on('click',function(){
		window.open("../../reportes/reporte_documento.php?id="+$("#tipo_doc").val()+"&tipo="+$("#tipo_doc option:selected").text());
	});

	$("#btn_5").on('click',function(){
		window.open("../../reportes/reporte_archivo.php?tipo="+$("#tipo").val()+"&val="+$("#tipo option:selected").text());
	});
	$("#btn_6").on('click',function(){
		window.open("../../reportes/reporte_auditoria.php?inicio="+$("#txt_6").val()+"&fin="+$("#txt_7").val());
	});
	$("#btn_7").on('click',function(){
		window.open("../../reportes/reporte_base_datos.php?inicio="+$("#txt_8").val()+"&fin="+$("#txt_9").val());
	});


}
function tipo_documento(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=8&tam=3",          
	    success: function(response) {         			        	
	    	$("#tipo_doc").html("");
	        for (var i = 0; i < response.length; i=i+3) {            				            		        	
				$("#tipo_doc").append("<option value ="+response[i]+">"+response[i+2]+"</option>");
	        }   
	        $("#tipo_doc").trigger("chosen:updated"); 	                                     
	    }
	});	      
}
