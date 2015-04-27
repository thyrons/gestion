$(document).on("ready",inicio);
    var dataTable = jQuery('#tabla_usuarios').DataTable({
    "bAutoWidth": false,	
    "scrollY": "200px",
    "scrollX": "100%",
    "sScrollXInner": "200%",
    "paging": false,
    "aoColumnDefs": [
        { "bSearchable": false, "bVisible": true, "aTargets": [ 0 ], },        
        { "bSearchable": false, "bVisible": false, "aTargets": [ 4 ] },        
        { "bSearchable": false, "bVisible": false, "aTargets": [ 6 ] },        
        { "bSearchable": false, "bVisible": false, "aTargets": [ 8 ] },        
        { "bSearchable": false, "bVisible": false, "aTargets": [ 13 ] },        
        { "bSearchable": false, "bVisible": false, "aTargets": [ 17 ] },        
        { "bSearchable": false, "bVisible": false, "aTargets": [ 19 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 3 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 7 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 9 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 10 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 11 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 21 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 22 ] },                
        { "bSearchable": false, "bVisible": false, "aTargets": [ 12 ] }, 
        { "bSearchable": false, "bVisible": false, "aTargets": [ 15 ] }, 
        { "bSearchable": false, "bVisible": false, "aTargets": [ 16 ] }, 
       	{ "bSearchable": false, "bVisible": false, "aTargets": [ 14 ] }, 
        { "bSearchable": false, "bVisible": false, "aTargets": [ 18 ] }, 
        { "bSearchable": false, "bVisible": false, "aTargets": [ 23 ] }, 
        { "bSearchable": false, "bVisible": false, "aTargets": [ 24 ] }, 
    ],      	   			
  	"bPaginate": true,
  	"bLengthChange": true,
  	"bFilter": true,
  	"bSort": true,
  	"bInfo": true,
  	
  	'iDisplayLength': 5,             
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
	/////////
	$("#btn_5").on('click',function(){
		cargar_tabla();
	});
	////////////
	$('#tabla_usuarios tbody').on( 'dblclick', 'tr', function () {  		
		var data = $("#tabla_usuarios").dataTable().fnGetData(this);                        
        $("#txt_0").val(data[0]);        
        $("#txt_3").val(data[2]);                        
        $("#txt_9").val(data[3]);
		
		$("#txt_4").val(data[8]);
		$("#txt_4").trigger("chosen:updated"); 
		
		$.ajax({        
		    type: "POST",
		    dataType: 'json',        
		    url: "../varios.php?tipo=0&fun=5&tam=2&id="+$("#txt_4").val(),          
		    success: function(response) {         			        	
		    	$("#txt_5").html("");
		        for (var i = 0; i < response.length; i=i+2) {            				            			        	
					$("#txt_5").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
		        }   
		        $("#txt_5").val(data[6]);
		        $("#txt_5").trigger("chosen:updated"); 	                                     

		        $.ajax({        
				    type: "POST",
				    dataType: 'json',        
				    url: "../varios.php?tipo=0&fun=11&tam=2&id="+$("#txt_5").val(),          
				    success: function(response) {         			        	
				    	$("#txt_6").html("");
				        for (var i = 0; i < response.length; i=i+2) {            				            			        	
							$("#txt_6").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
				        }   
				        $("#txt_6").val(data[4]);
				        $("#txt_6").trigger("chosen:updated"); 	 				         
				        $('#modal_usuarios').modal('hide');                                  				        
				    }
				});
		    }
		});	   				
		$("#txt_1").val(data[22]);   
		$("#txt_1").trigger("chosen:updated"); 
		documentos('0',"txt_1","txt_2");
		$("#txt_2").val(data[23]);   		
		$("#txt_7").val(data[10]);   				
		$("#txt_8").val(data[11]);
		$("#txt_10").val(data[13]);
		$("#txt_10").trigger("chosen:updated"); 	 				         
		$("#txt_11").val(data[17]);
		$("#txt_11").trigger("chosen:updated"); 	 				         
		$("#txt_12").val(data[19]);
		$("#txt_12").trigger("chosen:updated"); 	 				         
		$("#txt_13").val(data[15]);
		$("#txt_14").val(data[24]);
		$("#txt_15").val(data[24]);

		$("#txt_16").val(data[16]);
		$("#txt_17").val(data[12]);

        $("#btn_1").html("");
        $("#btn_1").append("<span class='glyphicon glyphicon-edit'></span> Modificar");   
        $("#btn_1").attr("disabled", false);
        comprobarCamposRequired("form_usuarios");        
	});
	////////////////
	$("#btn_3").on("click",function (){   
	    var resp = "";    
	    resp =atras($("#txt_0").val(),"usuarios","secuencia.php");   
	    console.log(resp)
	    if(resp[0] != false){	    	
	    	$("#txt_0").val(resp[0][0]);
	    	$("#txt_3").val(resp[0][2]);
	    	$("#txt_9").val(resp[0][3]);
	    	$("#txt_7").val(resp[0][10]);
	    	$("#txt_8").val(resp[0][11]);
	    	$("#txt_17").val(resp[0][12]);
	    	$("#txt_13").val(resp[0][15]);
	    	$("#txt_16").val(resp[0][16]);	    	

	    	$("#txt_4").val(resp[0][8]);
			$("#txt_4").trigger("chosen:updated"); 			
			$.ajax({        
			    type: "POST",
			    dataType: 'json',        
			    url: "../varios.php?tipo=0&fun=5&tam=2&id="+$("#txt_4").val(),          
			    success: function(response) {         			        				    	
			    	$("#txt_5").html("");
			        for (var i = 0; i < response.length; i=i+2) {            			        	
						$("#txt_5").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
			        }   
			        $("#txt_5").val(resp[0][6]);
			        $("#txt_5").trigger("chosen:updated"); 	                                     

			        $.ajax({        
					    type: "POST",
					    dataType: 'json',        
					    url: "../varios.php?tipo=0&fun=11&tam=2&id="+resp[0][6],          
					    success: function(response) {         			        	
					    	$("#txt_6").html("");
					        for (var i = 0; i < response.length; i=i+2) {            				            			        	
								$("#txt_6").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
					        }   
					        $("#txt_6").val(resp[0][4]);
					        $("#txt_6").trigger("chosen:updated"); 	 				         
					        $('#modal_usuarios').modal('hide');                                  				        
					    }
					});
			    }
			});	   			    	

	    	$("#txt_10").val(resp[0][13]);
			$("#txt_10").trigger("chosen:updated"); 	 				         
			$("#txt_11").val(resp[0][17]);
			$("#txt_11").trigger("chosen:updated"); 	 				         
			$("#txt_12").val(resp[0][19]);
			$("#txt_12").trigger("chosen:updated"); 	 				         

	    	$("#txt_1").trigger("chosen:updated"); 
	    	$("#txt_1").val(resp[0][22]);
	    	documentos('0',"txt_1","txt_2");
	    	$("#txt_2").val(resp[0][23]);
	    	$("#txt_14").val(resp[0][24]);
			$("#txt_15").val(resp[0][24]);

			$("#btn_1").html("");
        	$("#btn_1").append("<span class='glyphicon glyphicon-edit'></span> Modificar");   
        	$("#btn_1").attr("disabled", false);
        	comprobarCamposRequired("form_usuarios");        

	    }else{
	    	$.gritter.add({                         
                title: 'Datos Enviados..!',                         
                text: 'No existen mas registros.',
                image: '../../img/confirm.png',                           
                sticky: false,                          
                time: 1000,                                 
                class_name: 'light',                                                                
            });      
	    }         	    
	}); 	
	$("#btn_4").on("click",function (){   
		    var resp = "";    
		    resp =adelante($("#txt_0").val(),"usuarios","secuencia.php");   
		    console.log(resp)
		    if(resp[0] != false){	    	
		    	$("#txt_0").val(resp[0][0]);
		    	$("#txt_3").val(resp[0][2]);
		    	$("#txt_9").val(resp[0][3]);
		    	$("#txt_7").val(resp[0][10]);
		    	$("#txt_8").val(resp[0][11]);
		    	$("#txt_17").val(resp[0][12]);
		    	$("#txt_13").val(resp[0][15]);
		    	$("#txt_16").val(resp[0][16]);	    	

		    	$("#txt_4").val(resp[0][8]);
				$("#txt_4").trigger("chosen:updated"); 			
				$.ajax({        
				    type: "POST",
				    dataType: 'json',        
				    url: "../varios.php?tipo=0&fun=5&tam=2&id="+$("#txt_4").val(),          
				    success: function(response) {         			        				    	
				    	$("#txt_5").html("");
				        for (var i = 0; i < response.length; i=i+2) {            			        	
							$("#txt_5").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
				        }   
				        $("#txt_5").val(resp[0][6]);
				        $("#txt_5").trigger("chosen:updated"); 	                                     

				        $.ajax({        
						    type: "POST",
						    dataType: 'json',        
						    url: "../varios.php?tipo=0&fun=11&tam=2&id="+resp[0][6],          
						    success: function(response) {         			        	
						    	$("#txt_6").html("");
						        for (var i = 0; i < response.length; i=i+2) {            				            			        	
									$("#txt_6").append("<option value ="+response[i]+">"+response[i+1]+"</option>");
						        }   
						        $("#txt_6").val(resp[0][4]);
						        $("#txt_6").trigger("chosen:updated"); 	 				         
						        $('#modal_usuarios').modal('hide');                                  				        
						    }
						});
				    }
				});	   			    	

		    	$("#txt_10").val(resp[0][13]);
				$("#txt_10").trigger("chosen:updated"); 	 				         
				$("#txt_11").val(resp[0][17]);
				$("#txt_11").trigger("chosen:updated"); 	 				         
				$("#txt_12").val(resp[0][19]);
				$("#txt_12").trigger("chosen:updated"); 	 				         

		    	$("#txt_1").trigger("chosen:updated"); 
		    	$("#txt_1").val(resp[0][22]);
		    	documentos('0',"txt_1","txt_2");
		    	$("#txt_2").val(resp[0][23]);
		    	$("#txt_14").val(resp[0][24]);
				$("#txt_15").val(resp[0][24]);

				$("#btn_1").html("");
	        	$("#btn_1").append("<span class='glyphicon glyphicon-edit'></span> Modificar");   
	        	$("#btn_1").attr("disabled", false);
	        	comprobarCamposRequired("form_usuarios");        

		    }else{
		    	$.gritter.add({                         
	                title: 'Datos Enviados..!',                         
	                text: 'No existen mas registros.',
	                image: '../../img/confirm.png',                           
	                sticky: false,                          
	                time: 1000,                                 
	                class_name: 'light',                                                                
	            });      
		    }         	    
		}); 	
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
				if($("#txt_6").val() != null){
					if($("#txt_14").val() == $("#txt_15").val()){
						datos_usuarios(valores,"g",e);						
					}else{
						$.gritter.add({							
							title: 'Error..!',							
							text: "Las claves no coinciden vuelva a ingresarlas",														
							image: '../../img/error.png',							
							sticky: false, 							
							time: 500,									
							class_name: 'light',						        
							after_close: function(){
								$("#txt_15").val("");
								$("#txt_15").focus();
							},							
						});						
					}
				}else{
					$.gritter.add({							
						title: 'Error..!',							
						text: "Seleccione una cuidad antes de continuar",														
						image: '../../img/error.png',							
						sticky: false, 							
						time: 500,									
						class_name: 'light',						        
						after_close: function(){
							$('#txt_6_chosen').trigger('mousedown');
						},							
					});																
				}								
				
			}else{
				if($("#txt_6").val() != null){				
					if($("#txt_14").val() == $("#txt_15").val()){
						datos_usuarios(valores,"m",e);						
					}else{						
						$.gritter.add({							
							title: 'Error..!',							
							text: "Las claves no coinciden vuelva a ingresarlas",														
							image: '../../img/error.png',							
							sticky: false, 							
							time: 1000,									
							class_name: 'light',						        
							after_close: function(){
								$("#txt_15").val("");
								$("#txt_15").focus();
							},							
						});						
					}
				}else{
					$.gritter.add({							
						title: 'Error..!',							
						text: "Seleccione una cuidad antes de continuar",														
						image: '../../img/error.png',							
						sticky: false, 							
						time: 1000,									
						class_name: 'light',						        
						after_close: function(){
							$('#txt_6_chosen').trigger('mousedown');
						},							
					});											
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
	    		$.gritter.add({							
					title: 'Datos Enviados..!',							
					text: 'Datos Agregados Correctamente',
					image: '../../img/confirm.png',							
					sticky: false, 							
					time: 1000,									
					class_name: 'light',						        
					after_close: function(){
						limpiar_form(p);		    		
					},							
				});		    				    			    		
	    	}else{
	    		if( data == 1 ){
	    			$.gritter.add({							
						title: 'Datos Enviados..!',							
						text: 'Este código de documento ya existe ingrese otro',	
						image: '../../img/error.png',							
						sticky: false, 							
						time: 1000,									
						class_name: 'light',						        
						after_close: function(){
							$("#txt_1").val("");
	    					$("#txt_1").focus();	    			
						},							
					});		    				    			    			    				    			
	    		}else{
	    			if( data == 2){
	    				$.gritter.add({							
							title: 'Datos Enviados..!',							
							text: 'Este nombre de documento ya existe ingrese otro',		    				
							image: '../../img/error.png',							
							sticky: false, 							
							time: 1000,									
							class_name: 'light',						        
							after_close: function(){
								$("#txt_2").val("");
	    						$("#txt_2").focus();	    			
							},							
						});		    				
	    			}else{
	    				$.gritter.add({							
							title: 'Datos Enviados..!',							
							text: "Error al momento de enviar los datos la página se recargara",
							image: '../../img/error.png',							
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

function cargar_tabla(){
	$.ajax({
        type: "POST",
        url: "../varios.php?tipo=0&fun=14&tam=25",          
        dataType: 'json',
        success: function(response) {
    
        	dataTable.fnClearTable();
        	for (var i = 0; i < response.length; i=i+25) {            	        		
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
	            response[i+24],
	           	]);                    
            }                            
        }        
    });        
}
