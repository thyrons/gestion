$(document).on("ready",inicio);    
function inicio (){
	$('.chosen-select').chosen({
		allow_single_deselect:true,
		no_results_text: "Sin resultados!",		
	}); 
	$(window)
	.off('resize.chosen')
	.on('resize.chosen', function() {
		$('.chosen-select').each(function() {
			 var $this = $(this);
		//	 console.log($this.parent().width())
			 $this.next().css({'width': $this.parent().width()});			 
		})
	}).trigger('resize.chosen');
	/////////////		
	var d = new Date();
    var strDate = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();    		
	$('#txt_4').datepicker({
		autoclose: "true",
		calendarWeeks: "true",
		clearBtn: "true",
		format: "yyyy-mm-dd",
		todayHighlight: "true",
		setDate: strDate,
		startDate: '+0d',
		language: 'es',
	}).datepicker("setDate", strDate);		  	  	
	///////////////////////////
	var loc = document.location.href;
 	var id_get = getGET(loc);  
 	///////////////////// 	
 	CKEDITOR.replace( 'txt_8', {
	toolbarGroups: [		
 		{ name: 'document',	   groups: [ 'mode', 'document' ] },			// Displays document group with its two subgroups.
	],
	height: '265',	
	resize_enabled : 'false',
	
	});
	CKEDITOR.replace( 'txt_10', {	
	resize_enabled : 'false',
	toolbar:  'Basic',
	uiColor:  '#dddddd'
	}); 	
 	cargar_datos_documento(id_get.id); 
}
function cargar_datos_documento(id){
	////usuarios
	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id="+id+"&tam=2&fun=22",        
    	success: function(data, status) {      		
      		$('#txt_1').html("");	        	
      		for (var i = 0; i < data.length; i=i+2) {            				            		            	        		
                $("#txt_1").append("<option value ="+data[i]+" selected>"+data[i+1]+"</option>"); 
      		}	
      		$("#txt_1").trigger("chosen:updated");            
      		////////////////////      		
    	},
    	error: function (data) {		        
    	}	        
  	});    	   
  	///// comentarios
  	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id="+id+"&tam=6&fun=23",        
    	success: function(data, status) {      		
    		$('#txt_8').text("");	        	
    		console.log(data);
    		var text = '';
			//$("#txt_8").text('');
      		for (var i = 0; i < data.length; i=i+6) {           
      			text = $("#txt_8").text(); 				            		            	        		      			
      			lineas ="----------------------- "+data[i+5];      			
      			$("#txt_8").append("<pre>"+data[i+3]+"</pre>");      			      			  
    		}
    	},
    	error: function (data) {		        
    	}	        
  	});    	   
}