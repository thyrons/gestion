$(document).on("ready",inicio);    
function inicio(){		
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
  	cargar_usuarios();  

  	$("#txt_1").on("change",function(){
  		cargar_permisos($(this).val());  		
  	})	  	  	
}

function cargar_usuarios(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&id=0&tam=3&fun=16",        
	    success: function(response) {         			        		    	
	    	$("#txt_1").html("");	    	
	    	$("#txt_1").append("<option></option>");
	        for (var i = 0; i < response.length; i=i+3) {            				            		        	
				$("#txt_1").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
	        }   
	        $("#txt_1").trigger("chosen:updated"); 	                                     
	    }
	});	      
}	
function cargar_permisos(id){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&id="+id+"&tam=2&fun=40",        
	    success: function(response) {         			        		    		    	
	    	console.log(response);
	        for (var i = 0; i < response.length; i=i+2) {            				            		        					

	        }   	                                     
	    }
	});	      
}
