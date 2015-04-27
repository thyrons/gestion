$(document).on("ready",inicio);
var data = cargar_datos_usuarios();
console.log(data)
var modal = "<div class='modal fade' id='modal_mod_user'><div class='modal-dialog'><div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button><h4 class='modal-title'>Datos Usuario</h4></div><div class='modal-body'><div class='form'><div class='form-group col-md-6'><label for='txt_2_mod' class='col-md-6 control-label'>T. Documento</label><div class='col-md-6'><a href='#' class='col-md-12' id='txt_2_mod' data-type='select' data-name='txt_2_mod' data-pk='2' data-value='"+data[22]+"'  data-original-title='Seleccione'>"+data[22]+"</a></div></div><div class='form-group col-md-6'><label for='txt_1_mod' class='col-md-6 control-label'>Nro. Doc.</label><div class='col-md-6'><a href='#' id='txt_1_mod' data-pk='1'>"+data[23]+"</a></div></div><div class='form-group col-md-6'><label for='txt_3_mod' class='col-md-6 control-label'>Nombres</label><div class='col-md-6'><a href='#' class='col-md-12' id='txt_3_mod' data-pk='3' style='white-space: nowrap;overflow: hidden;'>"+data[2]+"</a></div></div><div class='form-group col-md-6'><label for='txt_4_mod' class='col-md-6 control-label'>Usuario</label><div class='col-md-6'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_4_mod' data-pk='4'>"+data[15]+"</a></div></div><div class='form-group col-md-6'><label for='txt_5_mod' class='col-md-6 control-label'>Teléfono</label><div class='col-md-6'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_5_mod' data-pk='5'>"+data[10]+"</a></div></div><div class='form-group col-md-6'><label for='txt_6_mod' class='col-md-6 control-label'>Celular</label><div class='col-md-6'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_6_mod' data-pk='6'>"+data[11]+"</a></div></div><div class='form-group col-md-6'><label for='txt_7_mod' class='col-md-6 control-label'>E-mail</label><div class='col-md-6'><a href='#' class='col-md-12' style='white-space: nowrap;overflow: hidden;' id='txt_7_mod' data-pk='7'>"+data[12]+"</a></div></div><div class='form-group col-md-6'><label for='txt_8_mod' class='col-md-4 control-label'>Institución</label><div class='col-md-8'><a href='#' style='white-space: nowrap;overflow: hidden;' class='col-md-12' id='txt_8_mod' data-pk='8'>"+data[16]+"</a></div></div></div></div><div class='modal-footer'><button type='button' class='btn btn-default pull-left' data-dismiss='modal'>Cerrar</button></div></div></div></div>";

function inicio(){		 	
	$('body').append(modal);
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
	       type:  'text',
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
		$('#modal_mod_user').modal('show');                
	})
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