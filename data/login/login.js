$(document).on("ready",inicio);
function inicio(){	
	$("#btn_1").on('click',ingresar);
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
	    		location.href='../../data/inicio/';
	    		
	    	}else{
	    		if( data == 1 ){
	    			alert("El usuario no existe...")
	    			$("#txt_1").val("");
	    			$("#txt_1").focus();	    			
	    		}else{
	    			if( data == 2 ){
	    				alert("Clave Incorrecta...")
	    				$("#txt_2").val("");
	    				$("#txt_2").focus();	    			
	    			}else{
	    				alert("Error al momento de enviar los datos la página se recargara");	    			
	    				actualizar_form();	
	    			}
	    			
	    		}
	    	}
		}
	}); 
}
