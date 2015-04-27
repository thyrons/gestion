$(document).on("ready",inicio);
var data = cargar_datos_usuarios();
console.log(data)
var modal = "<div class='modal fade' id='modal_mod_user'><div class='modal-dialog'><div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button><h4 class='modal-title'>Datos Usuario</h4></div><div class='modal-body'><div class='form'><div class='form-group col-md-6'><label for='txt_2_mod' class='col-md-6 control-label'>T. Documento</label><div class='col-md-6'><a href='#' class='col-md-12' id='txt_2_mod' data-type='select' data-name='txt_2_mod' data-pk='2' data-value='"+data[22]+"'  data-original-title='Seleccione'>"+data[22]+"</a></div></div><div class='form-group col-md-6'><label for='txt_1_mod' class='col-md-6 control-label'>Nro. Doc.</label><div class='col-md-6'><a href='#' id='txt_1_mod' data-pk='1'>"+data[23]+"</a></div></div><div class='form-group col-md-6'><label for='txt_3_mod' class='col-md-6 control-label'>Nombres</label><div class='col-md-6'><a href='#' class='col-md-12' id='txt_3_mod' data-pk='3' style='white-space: nowrap;overflow: hidden;'>"+data[2]+"</a></div></div><div class='form-group col-md-6'><label for='txt_4_mod' class='col-md-6 control-label'>Usuario</label><div class='col-md-6'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_4_mod' data-pk='4'>"+data[15]+"</a></div></div><div class='form-group col-md-6'><label for='txt_5_mod' class='col-md-6 control-label'>Teléfono</label><div class='col-md-6'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_5_mod' data-pk='5'>"+data[10]+"</a></div></div><div class='form-group col-md-6'><label for='txt_6_mod' class='col-md-6 control-label'>Celular</label><div class='col-md-6'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_6_mod' data-pk='6'>"+data[11]+"</a></div></div><div class='form-group col-md-6'><label for='txt_7_mod' class='col-md-6 control-label'>E-mail</label><div class='col-md-6'><a href='#' class='col-md-12' style='white-space: nowrap;overflow: hidden;' id='txt_7_mod' data-pk='7' data-type='text'>"+data[12]+"</a></div></div><div class='form-group col-md-6'><label for='txt_8_mod' class='col-md-4 control-label'>Institución</label><div class='col-md-8'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_8_mod' data-pk='8'>"+data[16]+"</a></div></div><div class='form-group col-md-6'><label for='txt_9_mod' class='col-md-4 control-label'>Ciudad</label><div class='col-md-8'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_9_mod' data-pk='9' data-type='address'>"+data[5]+"</a></div></div><div class='form-group col-md-6'><label for='txt_10_mod' class='col-md-6 control-label'>Dirección</label><div class='col-md-6'><a href='#' id='txt_10_mod' data-pk='10'>"+data[3]+"</a></div></div></div></div><div class='modal-footer'><button type='button' class='btn btn-default pull-left' data-dismiss='modal'>Cerrar</button></div></div></div></div>";

var modal_clave = "<div class='modal fade' id='modal_clave_user'><div class='modal-dialog'><div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button><h4 class='modal-title'>Cambiar Clave</h4></div><div class='modal-body'><div class='form'><div class='form-group col-md-12'><label for='txt_1_clave' class='col-md-5 control-label'>C. Actual</label><div class='col-md-7'><input type='password' class='form-control' id='txt_1_clave' name='txt_1_clave' placeholder='Clave Actual'></div></div><div class='form-group col-md-12'><label for='txt_2_clave' class='col-md-5 control-label'>N. Clave</label><div class='col-md-7'><input type='password' class='form-control' id='txt_2_clave' name='txt_2_clave' placeholder='Nueva Clave'></div></div><div class='form-group col-md-12'><label for='txt_3_clave' class='col-md-5 control-label'>R. Clave</label><div class='col-md-7'><input type='password' class='form-control' id='txt_3_clave' name='txt_3_clave' placeholder='Repetir Clave'></div></div></div</div></div><div class='modal-footer'><button type='button' class='btn btn-default pull-left' data-dismiss='modal'>Cerrar</button><button type='button' id='mod_clave' class='btn btn-primary'>Guardar Cambios</button></div></div></div></div>";

function inicio(){		 		
	$('body').append(modal);	
	$('body').append(modal_clave);
	$("#cambiar_clave").on('click',function(){
		$('#modal_clave_user .modal-dialog').css({'width':'300px'});		
		$('#modal_clave_user').modal('show');                	
	});
	$("#mod_perfil").on('click',function(){										
		$('#txt_1_mod').editable({
	       type:  'text',
	       pk:    1,	       
	       name:  'txt_1_mod',
	       url:   'mod_user.php?id='+data[0],  
	       title: 'Nro del documento'
	    });
	    $('#txt_2_mod').editable({	       
	    	pk:    2,
	      	name:  'txt_2_mod',	       
	       	source: [	       
		    	{value: "Cédula", text: "Cédula"},
		    	{value: "Ruc", text: "Ruc"},
		    	{value: "Pasaporte", text: "Pasaporte"}
		  	],
		  	url:   'mod_user.php?id='+data[0],  
	    title: 'Seleccione'
	    });
	    $('#txt_3_mod').editable({
	       type:  'text',
	       pk:    3,
	       name:  'txt_3_mod',
	       url:   'mod_user.php?id='+data[0],  
	       title: 'Nombres Completos',	       
	    });
	    $('#txt_4_mod').editable({
	       	type:  'text',
	       	pk:    4,
	       	name:  'txt_4_mod',
	       	url:   'mod_user.php?id='+data[0],  
	       	title: 'Nombre Usuario',
	       	success: function(data,response, value) {	     
		        if(data == 3){
		        	return 'Error... el usuario ya existe.';		        	
		        }		        
		    },		    	    	
	    });	    
	    $('#txt_5_mod').editable({
	       type:  'text',
	       pk:    5,
	       name:  'txt_5_mod',
	       url:   'mod_user.php?id='+data[0],  
	       title: 'Teléfono Usuario',	       
	    });
	    $('#txt_6_mod').editable({
	       type:  'text',
	       pk:    6,
	       name:  'txt_6_mod',
	       url:   'mod_user.php?id='+data[0],  
	       title: 'Celular Usuario',	       
	    });
	    $('#txt_7_mod').editable({	       
	       type:  'email',
	       pk:    7,
	       name:  'txt_7_mod',
	       url:   'mod_user.php?id='+data[0],  
	       title: 'E-mail Usuario',	       
	    });
	    $('#txt_8_mod').editable({
	       type:  'text',
	       pk:    8,
	       name:  'txt_8_mod',
	       url:   'mod_user.php?id='+data[0],  
	       title: 'Institución',	       
	    });
	    $('#txt_9_mod').editable({
	       	url:   'mod_user.php?id='+data[0],  
	        title: 'Seleccione un País, Provincia y Ciudad',	        
	        success: function(data,response, value) {	     
		        if(data == 3){
		        	return 'Error... Complete todos los campos.';		        	
		        }else{
		        	if(data == 1){
		        		data = cargar_datos_usuarios();		        		
		        	}
		        }		        
		    },		    	    	
	        
	    });
	    $('#txt_10_mod').editable({
	       type:  'text',
	       pk:    9,
	       name:  'txt_10_mod',
	       url:   'mod_user.php?id='+data[0],  
	       title: 'Dirección',	       
	    });
		$('#modal_mod_user').modal('show');                
	});	
	//////////////
	$("#mod_clave").click(function(){
	if($("#txt_1_clave").val() != '' && $("#txt_2_clave").val() != '' && $("#txt_3_clave").val() != ''){
		if(encode64($("#txt_1_clave").val()) == data[24]){
			if($("#txt_2_clave").val() == $("#txt_3_clave").val()){
				$.ajax({        
				    type: "POST",				    
				    data: {name:$("#txt_1_clave").val(),value_2:$("#txt_1_clave").val(),value_3:$("#txt_1_clave").val()},
				    dataType: 'json',        
				    url: "mod_user.php?id="+data[0],          
				    success: function(response) {         			        					    	
				        //$('#modal_usuarios').modal('hide');                                  				        
				    }
				});
			}else{
				alert("Las claves no coinciden");
				$("#txt_3_clave").val("");
				$("#txt_3_clave").focus();	
			}
		}else{
			alert("La clave actual no es válida");
			$("#txt_1_clave").val("");
			$("#txt_1_clave").focus();
		}
	}else{
		alert("Llene todos lo campos antes de continuar")
	}		
	});
}
function cargar_datos_usuarios(){
	var data = '';
	$.ajax({        
	    type: "POST",
	    dataType: 'json',   
	    async:false,     
	    url: "../varios.php?tipo=0&fun=15&tam=25",          
	    success: function(response) {         			        	
	    	data = response;
	    }
	});
	return data;
}
function cargar_datos_paises(id_pais,id_provincia,id_ciudad){
    $.ajax({        
        type: "POST",
        dataType: 'json',        
        url: "../varios.php?tipo=0&fun=1&tam=2",          
        success: function(response) {                               
            $("#txt_pais").html("");
            for (var i = 0; i < response.length; i=i+2) {                                           
                if(response[i+0] == id_pais){
                    $("#txt_pais").append("<option value ="+response[i]+" selected>"+response[i+1]+"</option>");         
                }
                else{
                    $("#txt_pais").append("<option value ="+response[i]+">"+response[i+1]+"</option>");                 
                }
            }   
            $("#txt_pais").trigger("chosen:updated");                                        
            $.ajax({      /*cargar el select ciudades*/         
                type: "POST",
                dataType: 'json',        
                url: "../varios.php?tipo=0&id="+id_pais+"&fun=5&tam=2",        
                success: function(response) {  
                    $("#txt_provincia").html("");       
                    for (var i = 0; i < response.length; i=i+2) {                                           
	                    if(response[i+0] == id_provincia){
	                    	$("#txt_provincia").append("<option value ="+response[i]+" selected>"+response[i+1]+"</option>");
		                }
		                else{
		                    $("#txt_provincia").append("<option value ="+response[i]+">"+response[i+1]+"</option>");             
		                }                     
		            }
                    $("#txt_provincia").trigger("chosen:updated");                              
                    $.ajax({      /*cargar el select ciudades*/         
		                type: "POST",
		                dataType: 'json',        
		                url: "../varios.php?tipo=0&id="+id_provincia+"&fun=11&tam=2",        
		                success: function(response) {  
		                    $("#txt_ciudad").html("");       
		                    for (var i = 0; i < response.length; i=i+2) {                                           
			                    if(response[i+0] == id_ciudad){
			                    	$("#txt_ciudad").append("<option value ="+response[i]+" selected>"+response[i+1]+"</option>");
				                }
				                else{
				                    $("#txt_ciudad").append("<option value ="+response[i]+">"+response[i+1]+"</option>");             
				                }                     
				            }
		                    $("#txt_ciudad").trigger("chosen:updated");                              
		                }                                   
		            });     
                }                                   
            });                                
        }
    });       
}