$(document).on("ready",inicio);
function inicio(){	
	cargar_tabla();
	$("#btn_1").attr("disabled", true);
	$('#tabla_pais tbody').on( 'dblclick', 'tr', function () {  		
		var data = $("#tabla_pais").dataTable().fnGetData(this);                
        $("#txt_0").val(data[0]);        
        $("#txt_1").val(data[1]);
        $("#txt_2").val(data[2]);                     
        $("#btn_1").html("");
        $("#btn_1").append("<span class='glyphicon glyphicon-edit'></span> Modificar");   
        $("#btn_1").attr("disabled", false);
        comprobarCamposRequired("form_pais");
	});
	///////////
	$("#btn_2").on('click',function(){
		limpiar_form('form_pais');
	});
	$("#form_pais :input").on("keyup click",function (e){//campos requeridos		
		comprobarCamposRequired(e.currentTarget.form.id)
	});	
	//////////////////
	$("#btn_1").on("click",guardar_pais);
	$("#btn_2").on("click",limpiar_form);
}
function cargar_tabla(){
	var dataTable = $('#tabla_pais').dataTable();
	$.ajax({
        type: "POST",
        url: "../varios.php?tipo=0&fun=2&tam=3",          
        dataType: 'json',
        success: function(response) {         
        	dataTable.fnClearTable();
        	for (var i = 0; i < response.length; i=i+3) {            	        		
        		dataTable.fnAddData([
	            response[i+0],
	            response[i+1],
	            response[i+2],	            
	           	]);                    
            }                            
        }        
    });        
}
function guardar_pais(){
	var resp=comprobarCamposRequired("form_pais");
	//console.log(resp)
	if(resp==true){
		$("#form_pais").on("submit",function (e){				
			var valores = $("#form_pais").serialize();
			var texto=($("#btn_1").text()).trim();	
			if(texto=="Guardar"){						
				datos_pais(valores,"g",e);					
			}else{				
				datos_pais(valores,"m",e);					
			}
			e.preventDefault();
    		$(this).unbind("submit")
		});
	}
}


function datos_pais(valores,tipo,p){	
	$.ajax({				
		type: "POST",
		data: valores+"&tipo="+tipo,
		//contentType: "application/x-www-form-urlencoded;charset=ISO-8859-15",
		url: "pais.php",			
	    success: function(data) {	
	    	if( data == 3 ){
	    		$.gritter.add({			
		    		title: 'Datos Enviados..!',							
					text: "Datos guardados correctamente",
					image: '../../dist/img/ok.fw.png',
					sticky: false, 							
					time: 1000,									
					class_name: 'light',						        					
				});			
	    		cargar_tabla();
	    		limpiar_form(p);		    		
	    	}else{
	    		if( data == 1 ){
	    			$.gritter.add({			
			    		title: 'Datos Enviados..!',							
						text: "Este código de País ya existe ingrese otro",
						image: '../../dist/img/advertencia.fw.png',
						sticky: false, 							
						time: 1000,									
						class_name: 'light',						        					
					});			    			
	    			$("#txt_1").val("");
	    			$("#txt_1").focus();	    			
	    		}else{
	    			if( data == 2){	    				
	    				$.gritter.add({			
				    		title: 'Datos Enviados..!',							
							text: "Este nombre de País ya existe ingrese otro",
							image: '../../dist/img/advertencia.fw.png',
							sticky: false, 							
							time: 1000,									
							class_name: 'light',						        					
						});		
	    				$("#txt_2").val("");
	    				$("#txt_2").focus();	    			
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

 