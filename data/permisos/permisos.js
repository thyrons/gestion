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
  	});  	
  	////////////////
  	$("#btn_1").on("click",guardarPermisos);
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
	var cont = 1;
	var temp = "";
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&id="+id+"&tam=2&fun=40",        
	    success: function(response) { 	    		    	
	    	$('#form_permisos input:checkbox').each(function(e){
	    		if(response[cont] == 0){
	    			$(this).parent().iCheck('check');    				    				    			
	    		}else{	    						
	    			$(this).parent().iCheck('uncheck');		
	    		}
	    		cont = cont + 2;
	    	});
	        
	    }
	});	      
}

function guardarPermisos(){				
	$("#form_permisos").on("submit",function (e){				
		var vector_permisos = new Array();	
		var i = 0;
		$('#form_permisos input:checkbox').each(function(e){			
			if($(this).is(":checked")){
				vector_permisos[i] = 0;	
			}else{
				vector_permisos[i] = 1;	
			}
			i++;			
		});								
		if($("#txt_1").val() != ''){
			datos_permisos(vector_permisos,"g",$("#txt_1").val(),e);								
		}else{
			alert("seleccione una usuario antes de continuar");
		}
		
		e.preventDefault();
		$(this).unbind("submit")
	});					
}
function datos_permisos(valores,tipo,user,p){	

	$.ajax({				
		type: "POST",
		data: "permisos="+valores+"&tipo="+tipo+"&user="+user,		
		url: "permisos.php",			
	    success: function(data) {	
	    	if( data == 1 ){
	    		alert('Datos Agregados Correctamente');				    		
	    		actualizar_form();		    			    	
	    	}else{	    		
	    		alert("Error al momento de enviar los datos la página se recargara");	    			
	    		actualizar_form();		    			    				    	
	    	}
		}
	}); 
}

