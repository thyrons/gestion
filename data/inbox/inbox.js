$(document).on("ready",inicio);    
var registros = 10;
var total_registros = 0;
var inicial = 0;
var fin = 0;
var cont_reg = 2;
var temp_reg = 0;
var loc = document.location.href;
function inicio(){	    
  //////////////procesos inbox recibidos
  total_registro();
	cargar_recibidos();	
  var id_get = getGET(loc);   
  cargar_datos_correo(id_get) 
  $("button[name$='adelante']").on('click',function(){        
    inicial =  fin;    
    fin = registros * cont_reg;        
    if(fin > total_registros){      
      temp_reg = fin;
      fin = total_registros;                  
    }else{
      temp_reg = fin;
      cont_reg = cont_reg + 1;                    
    }    
    atras_adelante(inicial,fin);                  
  });

  $("button[name$='atras']").on('click',function(){                  
    cont_reg = cont_reg - 1;    
    temp_reg = temp_reg - registros;    
    fin = temp_reg;
    inicial = fin - registros;    
    if(inicial < 0){
      inicial = 0;
      fin = 0
    }        
    atras_adelante(inicial,fin);  
    if(cont_reg < 2){
      cont_reg = 2;
      inicial = 0;
      fin = registros;
      temp_reg = 0;      
    }        
  });  
  $("#buscar_tabla").on('keyup',function (){
    $.ajax({        
      type: "POST",
      dataType: 'json',        
      url: "../varios.php?tipo=0&id=0&tam=11&fun=19&inicio="+inicial+"&fin="+registros+"&txt="+$("#buscar_tabla").val(),            
      success: function(data, status) {
        if(data['cuerpo'].length > 0){              
          $("#tabla_inbox tbody").html("");
          $("label[name$='tot']").html("");
          $("label[name$='tot']").append((inicial+1) + ' - '+ fin + ' de ' + total_registros);          
          for (var i = 0; i < (registros * 11); i=i+11) {            
            if((data['cuerpo'].length / 11) > (i / 11)){
          if(data['cuerpo'][i + 10] == ''){
                adjunto = "<i class=''></i>";
              }else{
                adjunto = "<i class='fa fa-paperclip'></i>";
              }             
              $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id="+data['cuerpo'][i]+"' target='_blank'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='#'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#'><i class='fa fa-search-plus'></i>Historial</a></li><li><a href='#'><i class='fa fa-share-square'></i>Reenviar</a></li></ul></div></td></tr>");
              
            }           
          }
        }
      },
      error: function (data) {            
      }         
    });
  });
  $("button[name$='refresh_inbox']").on('click',function(){                          
    inicial = 0;
    fin = 0;
    cont_reg = 2;
    temp_reg = 0;
    cargar_recibidos();   
  });
  /////////////////////proceos read mail


  /////////////////////////////////////

}
function cargar_recibidos(){  
	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id=0&tam=11&fun=17&inicio="+inicial+"&fin="+registros,        
    	success: function(data, status) {      				        
          if(registros > total_registros){
            registros = total_registros;
          }
          fin = registros;
      		$("#tabla_inbox tbody").html("");
          $("label[name$='tot']").html("");          
      		$("label[name$='tot']").append((inicial+1) + ' - '+ registros + ' de ' + total_registros);      		
      		for (var i = 0; i < (registros * 11); i=i+11) {      			
      			if((data['cuerpo'].length / 11) > (i / 11)){
					if(data['cuerpo'][i + 10] == ''){
	      				adjunto = "<i class=''></i>";
	      			}else{
	      				adjunto = "<i class='fa fa-paperclip'></i>";
	      			}	      				      			
              $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id="+data['cuerpo'][i]+"' target='_blank'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='#'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#'><i class='fa fa-search-plus'></i>Historial</a></li><li><a href='#'><i class='fa fa-share-square'></i>Reenviar</a></li></ul></div></td></tr>");
      			}      			
      		}
    	},
    	error: function (data) {		        
    	}	        
  	});    
}
function atras_adelante(inicio,fin){
  $.ajax({        
    type: "POST",
    dataType: 'json',        
    url: "../varios.php?tipo=0&id=0&tam=11&fun=17&inicio="+inicio+"&fin="+fin,            
    success: function(data, status) {
      if(data['cuerpo'].length > 0){              
        $("#tabla_inbox tbody").html("");
        $("label[name$='tot']").html("");
        $("label[name$='tot']").append((inicio+1) + ' - '+ fin + ' de ' + total_registros);          
        for (var i = 0; i < (registros * 11); i=i+11) {            
          if((data['cuerpo'].length / 11) > (i / 11)){
        if(data['cuerpo'][i + 10] == ''){
              adjunto = "<i class=''></i>";
            }else{
              adjunto = "<i class='fa fa-paperclip'></i>";
            }                         
            $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id="+data['cuerpo'][i]+"' target='_blank'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='#'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#'><i class='fa fa-search-plus'></i>Historial</a></li><li><a href='#'><i class='fa fa-share-square'></i>Reenviar</a></li></ul></div></td></tr>");
          }           
        }
      }
    },
    error: function (data) {            
    }         
  });     
}
function total_registro(){
  $.ajax({        
    type: "POST",
    dataType: 'json',        
    url: "../varios.php?tipo=0&id=0&tam=11&fun=18",      
    success: function(data, status) {
      total_registros = data;
      $("#total_inbox").html(total_registros);
    },
    error: function (data) {            
    }           
  });     
}
function cargar_datos_correo(id){
  if(id){
    $.ajax({        
      type: "POST",
      dataType: 'json',        
      url: "../varios.php?tipo=0&id="+id.id+"&tam=6&fun=20",        
      success: function(data, status) {  
        $("#subject").html("");
        $("#subject").html(data['cuerpo'][2]);
        $("#from_mail").html("");
        $("#from_mail").html("De: "+data['cuerpo'][5]);
        $("#cuerpo_mail").html("");
        $("#cuerpo_mail").html(data['cuerpo'][3]);
        $("#date_mail").html("");
        $("#date_mail").html(data['cuerpo'][1]);
      }, 
      error: function (data) {            
      }         
    }); 

  }  
}

function cargar_enviados(){}
function cargar_no_deseados(){}
