$(document).on("ready",inicio);    
$('#loading').ajaxStart(function() {
    $(this).show();
}).ajaxComplete(function() {
    $(this).hide();
});
function inicio (){	
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
	var d = new Date();
    var strDate = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();    		
	$('#txt_4').datepicker({
		autoclose: "true",
		calendarWeeks: "true",
		clearBtn: "true",
		format: "yyyy-mm-dd",
		todayHighlight: "true",
		setDate: strDate,
		//startDate: '+0d',
		language: 'es',
	}).datepicker("setDate", strDate);		  	  	
	///////////////////////////
	var loc = document.location.href;
 	var id_get = getGET(loc);  
 	tipo_documento();
  	medio_recepcion();
 	///////////////////// 	
 	CKEDITOR.replace( 'txt_8', {
	toolbarGroups: [		
 		{ name: 'document',	   groups: [ 'mode', 'document' ] },			// Displays document group with its two subgroups.
	],
	height: '265',	
	resize_enabled : 'false',
	
	});
	CKEDITOR.replace( 'txt_10', {	
	resize_enabled : 'false',
	toolbar:  'Basic',
	uiColor:  '#dddddd'
	}); 	
 	cargar_datos_documento(id_get.id); 
 	comprobarCamposRequired('form_reenvio');
  	$("#form_reenvio :input").on("keyup click",function (e){//campos requeridos				
		comprobarCamposRequired(e.currentTarget.form.id);
	});	
 	$("#btn_1").on('click',function(){
 		modificar_inbox(id_get.id);
 		
 	});
}
function cargar_datos_documento(id){
	//obtener archivo id	
	//console.log(data);
	$("#background_reenvio").append('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');
	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id="+id+"&tam=1&fun=25",        
    	success: function(data, status) {      		
      		$("#txt_0").val(data[0]);
    	},
    	error: function (data) {		        
    	},
    	async: false,	        
  	});
	////usuarios
	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id="+$("#txt_0").val()+"&tam=2&fun=16",        
    	success: function(data, status) {      		
      		$('#txt_1').html("");	        	      		
      		for (var i = 0; i < data.length; i=i+2) {                		  				            		            	        		
                $("#txt_1").append("<option value ="+data[i]+" >"+data[i+1]+"</option>");                 
      		}
      		$("#txt_1").trigger("chosen:updated");	  	      		
      		$.ajax({        
		    	type: "POST",
		    	dataType: 'json',        
		    	url: "../varios.php?tipo=0&id="+$("#txt_0").val()+"&tam=2&fun=22",        
		    	success: function(data, status) {
		    		for (var i = 0; i < data.length; i=i+2) {                		  				            		            	        		
		    			$('#txt_1 > option[value='+data[i]+']').attr('selected', 'selected');
		    		}
		    		$("#txt_1").trigger("chosen:updated");	  	      		
		    	},
		    	error: function (data) {		        
		    	},
		    	async: false,	        
		  	});			  	
    	},

    	error: function (data) {		        
    	},
    	async: false,	        
  	});
  	///// comentarios
  	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id="+$("#txt_0").val()+"&tam=6&fun=23",        
    	success: function(data, status) {      		    		
    		var observaciones = '';
      		for (var i = 0; i < data.length; i=i+6) {                 			
      			observaciones = '';
      			var text_editor = CKEDITOR.instances.txt_8.getData();    			      					
      			text = $("#txt_8").text(); 				            		            	        		      			
      			lineasIz ="---------- De: ";
      			lineasDer =" ----------";      			
      			if(data[i + 3] == ''){
      				observaciones = "<p>Sin observaciones</p>";

      			}else{
      				observaciones = data[i + 3];
      			}      			
      			userP = text_editor +  observaciones + lineasIz + data[i+5] +lineasDer
      			CKEDITOR.instances.txt_8.setData(userP);        						
    		}
    	},
    	error: function (data) {		        
    	},
    	async: false,	        
  	});    
  	///generales medio
  	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id="+id+"&tam=10&fun=24",        
    	success: function(data, status) {      		
    		$("#txt_2").val(data[7]);
    		$("#txt_3").val(data[4]);
    		//$("#txt_4").val(data[3].substr(0,10));
			$("#txt_5").val(data[6]);    		
			$("#txt_5").trigger("chosen:updated"); 	 
    		$("#txt_6").val(data[5]);    			 
    		$("#txt_6").trigger("chosen:updated"); 
    		$("#txt_7").val(data[9]);    	    		    								
		    $.gritter.add({
		    	title: 'Mensaje del Servidor!',
		        text: 'Datos cargados correctamente',
		        image: '../../dist/img/ok.fw.png',
		        sticky: false, 
		        class_name: 'dc_ok',						        
				time: 2000,																					
				after_close: function(){
					comprobarCamposRequired('form_reenvio');										
					loadStop();                    								
				},		
		    });		    
		    if(data[9] == 1){
				$("#txt_7").attr("disabled",true);	
				$("#btn_1").attr("disabled",true);						
				$("#txt_7").trigger("chosen:updated"); 	 					    			
			}
		    //$("#btn_1").attr("disabled",false);		
    	},
    	error: function (data) {		        
    	},    	
  	});       	     	
  	   
}
function tipo_documento(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=8&tam=3",          
	    success: function(response) {         			        	
	    	$("#txt_6").html("");
	        for (var i = 0; i < response.length; i=i+3) {            				            		        	
				$("#txt_6").append("<option value ="+response[i]+">"+response[i+2]+"</option>");
	        }   
	        $("#txt_6").trigger("chosen:updated"); 	                                     
	    }
	});	      
}
function medio_recepcion(){
	$.ajax({        
	    type: "POST",
	    dataType: 'json',        
	    url: "../varios.php?tipo=0&fun=9&tam=3",          
	    success: function(response) {         			        	
	    	$("#txt_5").html("");
	        for (var i = 0; i < response.length; i=i+3) {            				            		        	
				$("#txt_5").append("<option value ="+response[i]+">"+response[i+2]+"</option>");
	        }   
	        $("#txt_5").trigger("chosen:updated"); 	                                     
	    }
	});	      
}
function modificar_inbox(id_bitacora){		
	//console.log(data);
	var resp=comprobarCamposRequired("form_reenvio");	
	if(resp==true){		
		$("#form_reenvio").on("submit",function (e){				
			var valores = $("#form_reenvio").serialize();			
			var archivos = document.getElementById("txt_9");
			var archivo = archivos.files;
		    var archivos = new FormData();    
		   	var users = $("#txt_1").val();	
		   	if($("#txt_7").val() == '1' && $("#txt_7").attr("disabled")){
				$.gritter.add({
			        title: 'Error al momento de enviar!',
			        text: 'Un documento finalizado no se puede modificar.',
			        image: '../../dist/img/error.fw.png',						        
			        sticky: false, 
			        class_name: 'dc_ok',						        
					time: 5000,																	
					after_close: function(){
						actualizar_form();			            		
					},		   	
				});				
			}else{	    		    		    		   
				if(users != null){		    			    	
			   		for(var i = 0; i < archivo.length; i++){
					    archivos.append('archivo'+i,archivo[i]);        			        			        
				   	}	
				   	//loadStart();	    
			    	if(archivo.length == 0){		    
					    $.ajax({
					        url:'inbox.php?tipo=m&'+valores+'&dep='+data[19]+'&user='+$("#txt_1").val()+'&id_reenvio='+id_bitacora,
					        type:'POST',
					        contentType:false,
					        data:archivos,
				    	    processData:false,
				        	cache:false,        
					    }).done(function(data){
					        if( data == 1 ){   
					         	$("#background_reenvio").append('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');         				            
					            $.gritter.add({
							    	title: 'Mensaje del Servidor!',
							        text: 'Archivo subido satisfactoriamente.',
							        image: '../../dist/img/ok.fw.png',
							        sticky: false, 
						    	    class_name: 'dc_ok',						        
									time: 1000,																	
									after_close: function(){
										location.href = "../inbox";
										actualizar_form();			            		
									},		
							    });				            
				    	    }else{
				        	    if(data == 2){
				            		$.gritter.add({
							        	title: 'Error al momento de enviar!',
								        text: 'La página se recargara.',
								        image: '../../dist/img/error.fw.png',						        
								        sticky: false, 
								        class_name: 'dc_ok',						        
										time: 1000,																	
										after_close: function(){
											actualizar_form();			            		
										},		
								    });				            	
					            }else{
				            		$.gritter.add({
								        title: 'Errores encontrados!',
								        text: '' + data,
								        image: '../../dist/img/advertencia.fw.png',							        
								        sticky: false, 
								        class_name: 'dc_ok',						        
										time: 1000,																	
										after_close: function(){
											actualizar_form();			            		
										},		
							    	});				            	
				            		actualizar_form();
				            	}
				        	}
				    	}); 		
					}else{
						//console.log((archivo[0].size) / 1024)
						if((archivo[0].size) / 1024 <= 50000){						
					    	$.ajax({
						        url:'inbox.php?tipo=sm&'+valores+'&dep='+data[19]+'&user='+$("#txt_1").val()+'&id_reenvio='+id_bitacora,
						        type:'POST',
						        contentType:false,
						        data:archivos,
						        processData:false,
						        cache:false,        
					    	}).done(function(data){
						        if( data == 1 ){          
						        	$("#background_reenvio").append('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');         				            
						        	$.gritter.add({
								    	title: 'Mensaje del Servidor!',
								        text: 'Archivo subido satisfactoriamente.',
								        image: '../../dist/img/ok.fw.png',
								        sticky: false, 
							    	    class_name: 'dc_ok',						        
										time: 1000,																	
										after_close: function(){
											location.href = "../inbox";
											actualizar_form();			            		
										},		
								    });								            						            
						        }else{
						            if(data == 2){
						            	$.gritter.add({
								        	title: 'Error al momento de enviar!',
									        text: 'La página se recargara.',
									        image: '../../dist/img/error.fw.png',						        
									        sticky: false, 
									        class_name: 'dc_ok',						        
											time: 1000,																	
											after_close: function(){
												actualizar_form();			            		
											},		
									    });								            	
					        	    }else{
					            		$.gritter.add({
									        title: 'Errores encontrados!',
									        text: '' + data,
									        image: '../../dist/img/advertencia.fw.png',							        
									        sticky: false, 
									        class_name: 'dc_ok',						        
											time: 1000,																	
											after_close: function(){
												actualizar_form();			            		
											},		
								    	});		
					            		actualizar_form();
					            	}
					        	}
					    	});
				    	}else{
					    	alert("El archivo supera las 50 MB permitidas");
					    	$("#txt_9").val("");
					    	loadStop();
					    }
					}
		    	}else{
			    	alert("Seleccione al menos un remitente antes de enviar");
			    	loadStop();
			    }	    
			
			}
		    e.preventDefault();
			$(this).unbind("submit");	
		});			
	}
}
function loadStart() { 
  $('#load').show();
}
function loadStop() {  
  $('#load').hide();  
}
