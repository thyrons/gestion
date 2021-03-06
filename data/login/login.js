$(document).on("ready",inicio);
function inicio(){	
	$("#btn_1").on('click',ingresar);
	$("#txt_1").focus();
}

function ingresar(){	
	$("#form_login").on("submit",function (e){				
		var valores = $("#form_login").serialize();
		var texto=($("#btn_1").text()).trim();	
		if(texto == "Ingreso"){					
			datos_login(valores,"l",e);				//l = login
		}else{
			alert('Error.... Al enviar datos');
			actualizar_form();			
		}
		e.preventDefault();
		$(this).unbind("submit")
	});	
}
function datos_login(valores,tipo,p){	
	$.ajax({				
		type: "POST",
		data: valores+"&tipo="+tipo,		
		url: "login.php",			
	    success: function(data) {	
	    	if( data == 0 ){
	    		$.gritter.add({			
		    		title: 'Datos Enviados..!',							
					text: "Bienvenido",
					image: '../../dist/img/ok.fw.png',
					sticky: false, 							
					time: 2000,									
					class_name: 'light',						        
					after_close: function(){
						location.href='../../data/inbox/';
					},								    			    		
				});		    			
	    	}else{
	    		if( data == 1 ){	    			
					$.gritter.add({							    				
						title: 'Datos Enviados..!',							
						text: "Este usuario no existe...",
						image: '../../img/error.png',							
						sticky: false, 							
						time: 2000,									
						class_name: 'light',						        
						after_close: function(){
							$("#txt_1").val("");
	    					$("#txt_1").focus();	    										
						},							
					});		    			
	    		}else{
	    			if( data == 2 ){
	    				$.gritter.add({							
							title: 'Datos Enviados..!',							
							text: "Clave Incorrecta...",
							image: '../../img/error.png',							
							sticky: false, 							
							time: 2000,									
							class_name: 'light',						        
							after_close: function(){
								$("#txt_2").val("");
	    						$("#txt_2").focus();	    				    										
							},							
						});		    				
	    			}else{
	    				if( data == 3 ){
	    					$.gritter.add({							
								title: 'Datos Enviados..!',							
								text: "Este usuario ya esta conectado...",
								image: '../../dist/img/advertencia.fw.png',							
								sticky: false, 							
								time: 2000,									
								class_name: 'light',						        
								after_close: function(){
									$("#txt_1").val("");
									$("#txt_1").focus();	    				    										
									$("#txt_2").val("");		    						
								},							
							});				    						    				
		    			}else{
		    				$.gritter.add({							
								title: 'Datos Enviados..!',							
								text: "Error al momento de enviar los datos la página se recargara",
								image: '../../img/error.png',							
								sticky: false, 							
								time: 2000,									
								class_name: 'light',						        
								after_close: function(){
									actualizar_form();	
								},							
							});				    					    					
		    			}	    				
	    			}
	    			
	    		}
	    	}
		}
	}); 
}
 
 /*   // advertencia
      $.gritter.add({
        title: 'This is a regular notice!',
        text: 'This will fade out after a certain amount of time.',
        image: '../../dist/img/advertencia.fw.png',
        class_name: 'dc_ok'
      });
      // error
      $.gritter.add({
        title: 'This is a regular notice!',
        text: 'This will fade out after a certain amount of time.',
        image: '../../dist/img/error.fw.png',
        class_name: 'dc_ok'
      });
      // ok
      $.gritter.add({
        title: 'This is a regular notice!',
        text: 'This will fade out after a certain amount of time.',
        image: '../../dist/img/ok.fw.png',
        sticky: false, 
        class_name: 'dc_ok'
      });*/
    