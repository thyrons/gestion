$(document).on("ready",inicio);
var dataTable = 
	$('#tabla_provincia').dataTable({
		"aoColumnDefs": [
	        { "bSearchable": false, "bVisible": true, "aTargets": [ 0 ] },
	        { "bVisible": true, "aTargets": [ 1 ] },
	        { "bSearchable": false, "bVisible": false, "aTargets": [ 2 ] },
	        { "bVisible": true, "aTargets": [ 3 ] },
	    ],      
      	"bPaginate": true,
      	"bLengthChange": true,
      	"bFilter": true,
      	"bSort": true,
      	"bInfo": true,
      	"bAutoWidth": true,
      	'iDisplayLength': 5,             
    });

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
			 $this.next().css({'width': $this.parent().width()});
		})
	}).trigger('resize.chosen');
	////////////////
	cargar_pais();
	cargar_tabla();

	$("#btn_1").attr("disabled", true);
	$('#tabla_provincia tbody').on( 'dblclick', 'tr', function () {  		
		var data = $("#tabla_provincia").dataTable().fnGetData(this);                        
        $("#txt_0").val(data[0]);        
        $("#txt_2").val(data[1]);
        $("#txt_1").val(data[2]);
		$("#txt_1").trigger("chosen:updated"); 

        $("#btn_1").html("");
        $("#btn_1").append("<span class='glyphicon glyphicon-edit'></span> Modificar");   
        $("#btn_1").attr("disabled", false);
        comprobarCamposRequired("form_provincia");        
	});
	///////////
	$("#btn_2").on('click',function(){
		limpiar_form('form_provincia');
	});
	$("#form_provincia :input").on("keyup click",function (e){//campos requeridos		
		comprobarCamposRequired(e.currentTarget.form.id)
	});	
	///////
	$("#btn_1").on("click",guardar_provincia);
	$("#btn_2").on("click",limpiar_form);

}
function cargar_tabla(){	
	$.ajax({
        type: "POST",
        url: "../varios.php?tipo=0&fun=3&tam=4",          
        dataType: 'json',
        success: function(response) {         
        	dataTable.fnClearTable();
        	for (var i = 0; i < response.length; i=i+4) {            	        		
        		dataTable.fnAddData([
	            response[i+0],
	            response[i+1],
	            response[i+2],	            
	            response[i+3],	            
	           	]);                    
            }                            
        }        
    });        
}
function cargar_pais(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=1&tam=2",          
	    success: function(response) {         			        	
	    	$("#txt_1").html("");
	        for (var i = 0; i < response.length; i=i+2) {            				            	
	        	if(response[i+1] == 'Ecuador'){
					$("#txt_1").append("<option value ="+response[i]+" selected>"+response[i+1]+"</option>");            																																
	        	}
				else{
					$("#txt_1").append("<option value ="+response[i]+">"+response[i+1]+"</option>");            																																
				}
	        }   
	        $("#txt_1").trigger("chosen:updated"); 	                                     
	    }
	});	      
}
function guardar_provincia(){
	var resp=comprobarCamposRequired("form_provincia");
	console.log(resp)
	if(resp==true){
		$("#form_provincia").on("submit",function (e){				
			var valores = $("#form_provincia").serialize();
			var texto=($("#btn_1").text()).trim();	
			if(texto=="Guardar"){						
				datos_provincia(valores,"g",e);					
			}else{				
				datos_provincia(valores,"m",e);					
			}
			e.preventDefault();
    		$(this).unbind("submit")
		});
	}
}


function datos_provincia(valores,tipo,p){	
	$.ajax({				
		type: "POST",
		data: valores+"&tipo="+tipo,
		//contentType: "application/x-www-form-urlencoded;charset=ISO-8859-15",
		url: "provincia.php",			
	    success: function(data) {	
	    	if( data == 3 ){
	    		alert('Datos Agregados Correctamente');			
	    		cargar_tabla();
	    		limpiar_form(p);		    		
	    	}else{
	    		if( data == 1 ){	    			
	    		}else{
	    			if( data == 2){
	    				alert('Este nombre de Provincia ya existe ingrese otro');	
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


