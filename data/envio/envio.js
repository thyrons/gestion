$(document).on("ready",inicio);    
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
	var d = new Date();
    var strDate = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();    		
	$('#txt_4').datepicker({
		autoclose: "true",
		calendarWeeks: "true",
		clearBtn: "true",
		format: "yyyy-mm-dd",
		todayHighlight: "true",
		setDate: strDate,
		startDate: '+0d',
		language: 'es',
	}).datepicker("setDate", strDate);		  	  	

  	cargar_usuarios();
  	tipo_documento();
  	medio_recepcion();
  	CKEDITOR.replace('txt_8');

  	/////////////////
  	comprobarCamposRequired('form_envio');
  	$("#form_envio :input").on("keyup click",function (e){//campos requeridos				
		comprobarCamposRequired(e.currentTarget.form.id);
	});	
	$("#btn_1").on('click',guardar_envio);	
}

function cargar_usuarios(){	  	
	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id=0&tam=3&fun=16",        
    	success: function(data, status) {
      		$('#txt_1').html("");	        	
      		for (var i = 0; i < data.length; i=i+3) {            				            		            	
        		appendToChosen(data[i],data[i+1],data[i+1],data[i+2],"txt_1","txt_1_chosen");
      		}		                  		
    	},
    	error: function (data) {		        
    	}	        
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
function guardar_envio(){
	var resp=comprobarCamposRequired("form_envio");	
	if(resp==true){
		$("#form_envio").on("submit",function (e){				
			var valores = $("#form_envio").serialize();			
			var archivos = document.getElementById("txt_9");
		    var archivo = archivos.files;
		    var archivos = new FormData();    
		    var users = $("#txt_1").val();		    		    
		    
		    if(users != null){	
		    	$("#background_envio").append('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');	    			    	
		   		for(var i = 0; i < archivo.length; i++){
			        archivos.append('archivo'+i,archivo[i]);        			        			        
			    }	
			    if(archivo.length == 0){		    
				    $.ajax({
				        url:'envio.php?tipo=g&'+valores+'&dep='+data[19]+'&user='+$("#txt_1").val(),
				        type:'POST',
				        contentType:false,
				        data:archivos,
				        processData:false,
				        cache:false,        
				    }).done(function(data){
				         if( data == 1 ){            
				            alert('Archivo subido satisfactoriamente');	
				            actualizar_form();			            
				        }else{
				            if(data == 2){
				            	alert("Error al momento de enviar los datos la página se recargara");
				            	actualizar_form();
				            }else{
				            	alert(data);
				            	actualizar_form();
				            }
				        }
				    }); 		
				}else{
					//console.log((archivo[0].size) / 1024)
					if((archivo[0].size) / 1024 <= 50000){						
				    	$.ajax({
					        url:'envio.php?tipo=s&'+valores+'&dep='+data[19]+'&user='+$("#txt_1").val(),
					        type:'POST',
					        contentType:false,
					        data:archivos,
					        processData:false,
					        cache:false,        
					    }).done(function(data){
					        if( data == 1 ){            
					            alert('Archivo subido satisfactoriamente');					            
					            actualizar_form();
					        }else{
					            if(data == 2){
					            	alert("Error al momento de enviar los datos la página se recargara");
					            	actualizar_form();
					            }else{
					            	alert(data);
					            	actualizar_form();
					            }
					        }
					    });
				    }else{
				    	alert("El archivo supera las 50 MB permitidas");
				    	$("#txt_9").val("");
				    }
				}
		    }else{
		    	alert("Seleccione al menos un remitente antes de enviar");
		    }		    
			e.preventDefault();
    		$(this).unbind("submit");
		});
	}
}