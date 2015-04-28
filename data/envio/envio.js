$(document).on("ready",inicio);    
function inicio(){				
	$("[data-mask]").inputmask();	
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
	
	
}

function autocompletar(id_chosen,id){
	var input_chosen = $("#"+id_chosen).children().next().children();		
  	$(input_chosen).on("keyup",function(input_chosen){
  	var text = $(this).children().val();
    if(text != ""){
			$.ajax({        
	        	type: "POST",
	        	dataType: 'json',        
	        	url: "../carga_ubicaciones.php?tipo=0&id=0&fun=12&val="+text,        
	        	success: function(data, status) {
	          		$('#txt_nro_identificacion').html("");	        	
	          		for (var i = 0; i < data.length; i=i+3) {            				            		            	
	            		appendToChosen(data[i],data[i+1],text,data[i+2],"txt_nro_identificacion","txt_nro_identificacion_chosen");
	          		}		        
	          		$('#txt_nombre_proveedor').html("");
	          		$('#txt_nombre_proveedor').append($("<option data-extra='"+data[1]+"'></option>").val(data[0]).html(data[2])).trigger('chosen:updated');                    
	          		$("#id_proveedor").val(data[0])            
	        	},
	        	error: function (data) {		        
	        	}	        
	      	});
    	}
	});	
}