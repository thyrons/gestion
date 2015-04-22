$(document).on("ready",inicio);
function inicio(){	
	cargar_tabla();
	$("#btn_1").attr("disabled", true);
	$('#tabla_tipo_documento tbody').on( 'dblclick', 'tr', function () {  		
		var data = $("#tabla_tipo_documento").dataTable().fnGetData(this);                
        $("#txt_0").val(data[0]);        
        $("#txt_1").val(data[1]);
        $("#txt_2").val(data[2]);                     
        $("#btn_1").html("");
        $("#btn_1").append("<span class='glyphicon glyphicon-edit'></span> Modificar");   
        $("#btn_1").attr("disabled", false);
        comprobarCamposRequired("form_tipo_documento");
	});
	///////////
	$("#btn_2").on('click',function(){
		limpiar_form('form_tipo_documento');
	});
	$("#form_tipo_documento :input").on("keyup click",function (e){//campos requeridos		
		comprobarCamposRequired(e.currentTarget.form.id)
	});	
	//////////////////
	$("#btn_1").on("click",guardar_tipo_documento);
	$("#btn_2").on("click",limpiar_form);
}
function cargar_tabla(){
	var dataTable = $('#tabla_tipo_documento').dataTable();
	$.ajax({
        type: "POST",
        url: "../varios.php?tipo=0&fun=8&tam=3",          
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
function guardar_tipo_documento(){
	var resp=comprobarCamposRequired("form_tipo_documento");
	console.log(resp)
	if(resp==true){
		$("#form_tipo_documento").on("submit",function (e){				
			var valores = $("#form_tipo_documento").serialize();
			var texto=($("#btn_1").text()).trim();	
			if(texto=="Guardar"){						
				datos_tipo_documento(valores,"g",e);					
			}else{				
				datos_tipo_documento(valores,"m",e);					
			}
			e.preventDefault();
    		$(this).unbind("submit")
		});
	}
}


function datos_tipo_documento(valores,tipo,p){	
	$.ajax({				
		type: "POST",
		data: valores+"&tipo="+tipo,
		//contentType: "application/x-www-form-urlencoded;charset=ISO-8859-15",
		url: "tipo_documento.php",			
	    success: function(data) {	
	    	if( data == 3 ){
	    		alert('Datos Agregados Correctamente');			
	    		cargar_tabla();
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

 