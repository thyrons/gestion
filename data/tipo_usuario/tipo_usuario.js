$(document).on("ready",inicio);
function inicio(){	
	cargar_tabla();
	$("#btn_1").attr("disabled", true);
	$('#tabla_tipo_usuario tbody').on( 'dblclick', 'tr', function () {  		
		var data = $("#tabla_tipo_usuario").dataTable().fnGetData(this);                
        $("#txt_0").val(data[0]);        
        $("#txt_1").val(data[1]);        
        $("#btn_1").html("");
        $("#btn_1").append("<span class='glyphicon glyphicon-edit'></span> Modificar");   
        $("#btn_1").attr("disabled", false);
        comprobarCamposRequired("form_tipo_usuario");
	});
	///////////
	$("#btn_2").on('click',function(){
		limpiar_form('form_tipo_usuario');
	});
	$("#form_tipo_usuario :input").on("keyup click",function (e){//campos requeridos		
		comprobarCamposRequired(e.currentTarget.form.id)
	});	
	//////////////////
	$("#btn_1").on("click",guardar_tipo_usuario);
	$("#btn_2").on("click",limpiar_form);
}
function cargar_tabla(){
	var dataTable = $('#tabla_tipo_usuario').dataTable();
	$.ajax({
        type: "POST",
        url: "../varios.php?tipo=0&fun=10&tam=2",          
        dataType: 'json',
        success: function(response) {         
        	dataTable.fnClearTable();
        	for (var i = 0; i < response.length; i=i+2) {            	        		
        		dataTable.fnAddData([
	            response[i+0],
	            response[i+1],	            
	           	]);                    
            }                            
        }        
    });        
}
function guardar_tipo_usuario(){
	var resp=comprobarCamposRequired("form_tipo_usuario");
	//console.log(resp)
	if(resp==true){
		$("#form_tipo_usuario").on("submit",function (e){				
			var valores = $("#form_tipo_usuario").serialize();
			var texto=($("#btn_1").text()).trim();	
			if(texto=="Guardar"){						
				datos_tipo_usuario(valores,"g",e);					
			}else{				
				datos_tipo_usuario(valores,"m",e);					
			}
			e.preventDefault();
    		$(this).unbind("submit")
		});
	}
}


function datos_tipo_usuario(valores,tipo,p){	
	$.ajax({				
		type: "POST",
		data: valores+"&tipo="+tipo,
		//contentType: "application/x-www-form-urlencoded;charset=ISO-8859-15",
		url: "tipo_usuario.php",			
	    success: function(data) {	
	    	if( data == 3 ){
	    		$.gritter.add({			
		    		title: 'Datos Enviados..!',							
					text: "Datos Agregados Correctamente",
					image: '../../dist/img/ok.fw.png',
					sticky: false, 							
					time: 1000,									
					class_name: 'light',						        					
				});		
	    		cargar_tabla();
	    		limpiar_form(p);		    		
	    	}else{
	    		if( data == 1 ){	    						
	    		}else{
	    			if( data == 2){
	    				$.gritter.add({			
				    		title: 'Datos Enviados..!',							
							text: "Este nombre de usuario ya existe ingrese otro",
							image: '../../dist/img/advertencia.fw.png',
							sticky: false, 							
							time: 1000,									
							class_name: 'light',						        					
						});			    				
	    				$("#txt_1").val("");
	    				$("#txt_1").focus();	    			
	    			}else{
	    				$.gritter.add({			
				    		title: 'Datos Enviados..!',							
							text: "Error al momento de enviar los datos la página se recargara",
							image: '../../dist/img/error.fw.png',
							sticky: false, 							
							time: 1000,									
							class_name: 'light',						        
							after_close: function(){
								actualizar_form();	
							},								    			    		
						});	
	    			}	    			
	    		}
	    	}
		}
	}); 
}

 