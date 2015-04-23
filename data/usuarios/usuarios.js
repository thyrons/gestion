$(document).on("ready",inicio);
    var dataTable = jQuery('#tabla_usuarios').DataTable({
            "scrollX": true
	        });         
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
	cargar_tabla();
	carga_ubicaciones("txt_4","txt_5","txt_6");//pais provincia ciudad			
	$("#txt_4").change(function(){
		change_pais("txt_4","txt_5","txt_6");
	});
	$("#txt_5").change(function(){
		change_provincia("txt_4","txt_5","txt_6");
	});
	//////////////
	cargar_tipo_usuario();
	cargar_categoria_usuario();
	carga_departamentos();
	///////////////////
	comprobarCamposRequired('form_usuarios');
	$("#btn_2").on('click',function(){
		limpiar_form('form_usuarios');
	});
	$("#form_usuarios :input").on("keyup click",function (e){//campos requeridos				
		comprobarCamposRequired(e.currentTarget.form.id);
	});	
	//////////
	documentos('0',"txt_1","txt_2");
	$("#txt_1").change(function(){
		documentos('0',"txt_1","txt_2");
	});
	$("#txt_2").on('keyup',function(){
		ci_ruc_pass('txt_2',$("#txt_2").val(), $("#txt_1").val());
	});	
	/////////////
	$("#btn_1").on('click',guardar_usuario);
}

function cargar_tipo_usuario(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=10&tam=2",          
	    success: function(response) {         			        	
	    	$("#txt_10").html("");
	        for (var i = 0; i < response.length; i=i+2) {            				            		        	
				$("#txt_10").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
	        }   
	        $("#txt_10").trigger("chosen:updated"); 	                                     
	    }
	});	      
}
function cargar_categoria_usuario(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=12&tam=2",          
	    success: function(response) {         			        	
	    	$("#txt_11").html("");
	        for (var i = 0; i < response.length; i=i+2) {            				            		        	
				$("#txt_11").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
	        }   
	        $("#txt_11").trigger("chosen:updated"); 	                                     
	    }
	});	      
}
function carga_departamentos(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=13&tam=2",          
	    success: function(response) {         			        	
	    	$("#txt_12").html("");
	        for (var i = 0; i < response.length; i=i+2) {            				            		        	
				$("#txt_12").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
	        }   
	        $("#txt_12").trigger("chosen:updated"); 	                                     
	    }
	});	      
}

function guardar_usuario(){
	var resp=comprobarCamposRequired("form_usuarios");
	console.log(resp)
	if(resp==true){
		$("#form_usuarios").on("submit",function (e){				
			var valores = $("#form_usuarios").serialize();
			var texto=($("#btn_1").text()).trim();	
			if(texto=="Guardar"){						
				if($("#txt_14").val() == $("#txt_15").val()){
					datos_usuarios(valores,"g",e);						
				}else{
					alert("Las claves no coinciden vuelva a ingresarlas");
					$("#txt_15").val("");
					$("#txt_15").focus();
				}
				
			}else{				
				if($("#txt_14").val() == $("#txt_15").val()){
					datos_usuarios(valores,"m",e);						
				}else{
					alert("Las claves no coinciden vuelva a ingresarlas");
					$("#txt_15").val("");
					$("#txt_15").focus();
				}
			}
			e.preventDefault();
    		$(this).unbind("submit")
		});
	}
}


function datos_usuarios(valores,tipo,p){	
	$.ajax({				
		type: "POST",
		data: valores+"&tipo="+tipo,
		//contentType: "application/x-www-form-urlencoded;charset=ISO-8859-15",
		url: "usuarios.php",			
	    success: function(data) {	
	    	if( data == 3 ){
	    		alert('Datos Agregados Correctamente');				    		
	    		limpiar_form(p);		    		
	    	}else{
	    		if( data == 1 ){
	    			alert('Este código de documento ya existe ingrese otro');	
	    			$("#txt_1").val("");
	    			$("#txt_1").focus();	    			
	    		}else{
	    			if( data == 2){
	    				alert('Este nombre de documento ya existe ingrese otro');	
	    				$("#txt_2").val("");
	    				$("#txt_2").focus();	    			
	    			}else{
	    				alert("Error al momento de enviar los datos la página se recargara");	    			
	    				//actualizar_form();	
	    			}	    			
	    		}
	    	}
		}
	}); 
}

function cargar_tabla(){
	$.ajax({
        type: "POST",
        url: "../varios.php?tipo=0&fun=14&tam=24",          
        dataType: 'json',
        success: function(response) {
    
        	dataTable.fnClearTable();
        	for (var i = 0; i < response.length; i=i+24) {            	        		
        		dataTable.fnAddData([
	            response[i+0],
	            response[i+1],
	            response[i+2],	            
	            response[i+3],
	            response[i+4],
	            response[i+5],	            
	            response[i+6],
	            response[i+7],
	            response[i+8],
	            response[i+9],
	            response[i+10],
	            response[i+11],
	            response[i+12],
	            response[i+13],
	            response[i+14],
	            response[i+15],
	            response[i+16],
	            response[i+17],
	            response[i+18],
	            response[i+19],
	            response[i+20],
	            response[i+21],
	            response[i+22],
	            response[i+23],
	           	]);                    
            }                            
        }        
    });        
}
