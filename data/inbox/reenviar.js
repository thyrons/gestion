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
    		var observaciones = '';
      		for (var i = 0; i < data.length; i=i+6) {                 			
      			observaciones = '';
      			var text_editor = CKEDITOR.instances.txt_8.getData();    			      					
      			text = $("#txt_8").text(); 				            		            	        		      			
      			lineasIz ="---------- ";
      			lineasDer =" ----------";      			
      			if(data[i + 3] == ''){
      				observaciones = "<p>Sin observaciones</p>";

      			}else{
      				observaciones = data[i + 3];
      			}      			
      			userP = text_editor +  observaciones + lineasIz + data[i+5] +lineasDer
      			CKEDITOR.instances.txt_8.setData(userP);    			
    		}
    	},
    	error: function (data) {		        
    	}	        
  	});    	   
}