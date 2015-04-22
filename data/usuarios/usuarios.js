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
			 //console.log($this.parent().width())
			 $this.next().css({'width': $this.parent().width()});			 
		})
	}).trigger('resize.chosen');
	/////////////
	carga_ubicaciones("txt_7","txt_8","txt_9");//pais provincia ciudad			
	$("#txt_7").change(function(){
		change_pais("txt_7","txt_8","txt_9");
	});
	$("#txt_8").change(function(){
		change_provincia("txt_7","txt_8","txt_9");
	});
	//////////////
	cargar_tipo_usuario();
	cargar_categoria_usuario();


}

function cargar_tipo_usuario(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=10&tam=2",          
	    success: function(response) {         			        	
	    	$("#txt_11").html("");
	        for (var i = 0; i < response.length; i=i+2) {            				            		        	
				$("#txt_11").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
	        }   
	        $("#txt_11").trigger("chosen:updated"); 	                                     
	    }
	});	      
}
function cargar_categoria_usuario(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=12&tam=2",          
	    success: function(response) {         			        	
	    	$("#txt_12").html("");
	        for (var i = 0; i < response.length; i=i+2) {            				            		        	
				$("#txt_12").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
	        }   
	        $("#txt_12").trigger("chosen:updated"); 	                                     
	    }
	});	      
}