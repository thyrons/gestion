$(document).on("ready",inicio);    
$('#loading').ajaxStart(function() {
    $(this).show();
}).ajaxComplete(function() {
    $(this).hide();
});
var registros = 10;
var total_registros = 0;
var inicial = 0;
var fin = 0;
var cont_reg = 2;
var temp_reg = 0;
var loc = document.location.href;
var pathArray = window.location.pathname.split( '/' );
for (i = 0; i < pathArray.length; i++) {    
  pathArray[i];
}    
function inicio(){	          
  totalEnviados();
  total_registro();
  /*--------------*///obtener el url para cargar enviados,recibos, readMail, o buscar archivos
  ///////////////////////
  var id_get = getGET(loc);     
  if(pathArray[4] == 'enviados.php'){
    
  }else{
    if(pathArray[4] == '' || pathArray[4] == 'index.php'){
      
    }else{
      if(pathArray[4] == 'buscar_archivos.php'){        
        $("div[class$='mailbox-controls']").css("display","none");
        $("button[name$='adelante']").css("display","none");
        $("button[name$='atras']").css("display","none");   
        $("#buscar_tabla").css("display","none");
        $("#buscar_tabla").next().css("display","none");
      }else{
        if(pathArray[4] == 'read_mail.php'){
          if(id_get == undefined){    
            location.href = "../inbox";
          }else{    
            cargar_datos_correo(id_get);       
          }  
        }          
      }
    }   
  }   
  /*-------Buscar documentos texto------*/
  $("#btn_12").on("click",function(){
    buscar_archivos($("#txt_buscar").val(),$("#check_buscar").is(":checked"));
  });
  /*------------------------------------*/   
  $("button[name$='adelante']").on('click',function(){        
    $("#buscar_tabla").val("");
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
    $("#buscar_tabla").val("");
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
    var fun_re_ev = 0;
    if(pathArray[4] == 'enviados.php'){
      fun_re_ev = 28;
    }else{
      if(pathArray[4] == '' || pathArray[4] == 'index.php'){
        fun_re_ev = 19;
      }   
    }
    $("#tabla_inbox tbody").append('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');
    loadStart();
    $.ajax({        
      type: "POST",
      dataType: 'json',        
      url: "../varios.php?tipo=0&id=0&tam=11&fun="+fun_re_ev+"&inicio="+inicial+"&fin="+registros+"&txt="+$("#buscar_tabla").val(),            
      success: function(data, status) {
         loadStop(); 
        if(data['cuerpo'].length > 0){              
          $("#tabla_inbox tbody").html("");
          $("label[name$='tot']").html("");
          $("label[name$='tot']").append((inicial+1) + ' - '+ fin + ' de ' + total_registros);          
          for (var i = 0; i < (registros * 11); i=i+11) {            
            if((data['cuerpo'].length / 11) > (i / 11)){              
              if(data['cuerpo'][i + 7] == 0){
                leido = "color_fila";
              }else{
                leido = "";
              } 
              if(pathArray[4] == 'enviados.php'){                                
                if(data['cuerpo'][i + 10] == ''){
                  adjunto = "<i class=''></i>";            
                  $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");            
                }else{
                  adjunto = "<a onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",1)'><i class='fa fa-paperclip'></i></a>";
                  $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 2]+"&id_archivo="+data['cuerpo'][i + 1]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
                }    
              }else{
                if(pathArray[4] == '' || pathArray[4] == 'index.php'){                    
                  if(data['cuerpo'][i + 10] == ''){
                    adjunto = "<i class=''></i>";            
                    $("#tabla_inbox tbody").append("<tr class="+leido+"><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
                  }else{
                    adjunto = "<a onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",1)'><i class='fa fa-paperclip'></i></a>";
                    $("#tabla_inbox tbody").append("<tr class="+leido+"><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
                  }                              
                }   
              }                                                 
            }           
          }
        }else{
          //alert("No existen mas registros");
          $("#load").remove();
          $("#buscar_tabla").val("");
        }
      },
      error: function (data) {            
        loadStart();
      },   
      beforeSend: function(){
        loadStart();                
      },      
    });
  });
  $("button[name$='refresh_inbox']").on('click',function(){                          
    inicial = 0;
    fin = 0;
    cont_reg = 2;
    temp_reg = 0;
    if(pathArray[4] == 'enviados.php'){
      cargar_enviados();
    }else{
      if(pathArray[4] == '' || pathArray[4] == 'index.php'){
          cargar_recibidos();   
        }   
    }
  });
  /*-------------------*/
}
function cargar_recibidos(){  
  $("#tabla_inbox tbody").html('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');
	loadStart();
  $.ajax({        
  	type: "POST",
  	dataType: 'json',           
  	url: "../varios.php?tipo=0&id=0&tam=11&fun=17&inicio="+inicial+"&fin="+registros,        
  	success: function(data, status) {      				        
      loadStop();          
      if(registros > total_registros){
        registros = total_registros;
      }      
      fin = registros;
  		$("#tabla_inbox tbody").html("");
      $("label[name$='tot']").html("");          
  		$("label[name$='tot']").append((inicial+1) + ' - '+ registros + ' de ' + total_registros);      		                
  		for (var i = 0; i < (registros * 11); i=i+11) {      		              
        if((data['cuerpo'].length / 11) > (i / 11)){          			    
          if(data['cuerpo'][i + 7] == 0){
            leido = "color_fila";
          }else{
            leido = "";
          }              
          if(data['cuerpo'][i + 10] == ''){
            adjunto = "<i class=''></i>";            
            $("#tabla_inbox tbody").append("<tr class="+leido+"><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
          }else{
            adjunto = "<a onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",1)'><i class='fa fa-paperclip'></i></a>";
            $("#tabla_inbox tbody").append("<tr class="+leido+"><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
          }            
  			}      			
  		}    
      var div = Math.floor(registros/2);      
      if(div == 0){
        div = 1;
      }      
      $("#tabla_inbox tr:nth-child(n + "+(div+1)+")").each(function(){        
        var ss = $(this).children(":last");        
        ss.addClass('dropup');
      });
  	},
  	error: function (data) {            
      loadStart();
    },   
    beforeSend: function(){
      loadStart();                
    },
  });    
}
function cargar_enviados(){
  
  $("#tabla_inbox tbody").html('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');
  loadStart(); 
  $.ajax({        
    type: "POST",
    dataType: 'json',           
    url: "../varios.php?tipo=0&id=0&tam=11&fun=27&inicio="+inicial+"&fin="+registros,        
    success: function(data, status) {                                 
      loadStop();          
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
          if(data['cuerpo'][i + 10] == ''){
            adjunto = "<i class=''></i>";            
            $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");            
          }else{
            adjunto = "<a onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",1)'><i class='fa fa-paperclip'></i></a>";
            $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 2]+"&id_archivo="+data['cuerpo'][i + 1]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
          }

        }           
      }    
      var div = Math.floor(registros/2);      
      if(div == 0){
        div = 1;
      }      
      $("#tabla_inbox tr:nth-child(n + "+(div+1)+")").each(function(){        
        var ss = $(this).children(":last");        
        ss.addClass('dropup');
      });
    },
    error: function (data) {            
      loadStart();
    },   
    beforeSend: function(){
      loadStart();                
    },
  });    
}
function atras_adelante(inicio,fin){ 
  $("#tabla_inbox tbody").append('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');
  if(inicio < total_registros ){    
    loadStart();   
    var fun_re_ev = 0;
    if(pathArray[4] == 'enviados.php'){
      fun_re_ev = 27;
    }else{
      if(pathArray[4] == '' || pathArray[4] == 'index.php'){
          fun_re_ev = 17;
        }   
    }
    $.ajax({        
      type: "POST",
      dataType: 'json',        
      url: "../varios.php?tipo=0&id=0&tam=11&fun="+fun_re_ev+"&inicio="+inicio+"&fin="+fin,            
      success: function(data, status) {
        if(data['cuerpo'].length > 0){              
          $("#tabla_inbox tbody").html("");
          $("label[name$='tot']").html("");
          $("label[name$='tot']").append((inicio+1) + ' - '+ fin + ' de ' + total_registros);          
          for (var i = 0; i < (registros * 11); i=i+11) {            
            if((data['cuerpo'].length / 11) > (i / 11)){               
              if(data['cuerpo'][i + 7] == 0){
                leido = "color_fila";
              }else{
                leido = "";
              }       
              if(pathArray[4] == 'enviados.php'){                                
                if(data['cuerpo'][i + 10] == ''){
                  adjunto = "<i class=''></i>";            
                  $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");            
                }else{
                  adjunto = "<a onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",1)'><i class='fa fa-paperclip'></i></a>";
                  $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_envio="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 2]+"&id_archivo="+data['cuerpo'][i + 1]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
                }    
              }else{
                if(pathArray[4] == '' || pathArray[4] == 'index.php'){                    
                  if(data['cuerpo'][i + 10] == ''){
                    adjunto = "<i class=''></i>";            
                    $("#tabla_inbox tbody").append("<tr class="+leido+"><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
                  }else{
                    adjunto = "<a onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",1)'><i class='fa fa-paperclip'></i></a>";
                    $("#tabla_inbox tbody").append("<tr class="+leido+"><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='read_mail.php?id_mail="+data['cuerpo'][i]+"'><i class='fa fa-files-o'></i>Ver Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 1]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data['cuerpo'][i + 2]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data['cuerpo'][i + 1]+"&id_archivo="+data['cuerpo'][i + 2]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");
                  }                                 
                }   
              }                                       
            }           
          }
          var div = Math.floor(registros/2);      
          if(div == 0){
            div = 1;
          }      
          $("#tabla_inbox tr:nth-child(n + "+(div+1)+")").each(function(){        
            var ss = $(this).children(":last");        
            ss.addClass('dropup');
          });
        }else{
          alert("No existen mas registros");
          $("#load").remove();
        }
      },     
      error: function (data) {            
        loadStart();
      },   
      beforeSend: function(){
        loadStart();                
      },         
    });     
  }else{
    alert("No existen mas registros");
    $("#load").remove();
  }  
}
function total_registro(){
  $.ajax({        
    type: "POST",
    dataType: 'json',        
    url: "../varios.php?tipo=0&id=0&tam=11&fun=18",      
    success: function(data, status) {      
      if(pathArray[4] == '' || pathArray[4] == 'index.php'){
        cargar_recibidos(); 
        total_registros = data;      
      }
      $.ajax({        
        type: "POST",
        dataType: 'json',        
        url: "../varios.php?tipo=0&id=0&tam=11&fun=30",      
        success: function(data, status) {          
          $("#total_inbox").html(data);          
          
        },
        error: function (data) {            
        }           
      });         
    },
    error: function (data) {            
    }           
  });     
}
function totalEnviados(){
  $.ajax({        
    type: "POST",
    dataType: 'json',        
    url: "../varios.php?tipo=0&id=0&tam=9&fun=26",      
    success: function(data, status) {
      total_enviados = data;
      $("#total_enviados").html(total_enviados);            
      if(pathArray[4] == 'enviados.php'){
        cargar_enviados(); 
        total_registros = data;      
      }            
    },
    error: function (data) {            
    }           
  });     
}
function cargar_datos_correo(id){    
  var id_correo = 0;     
  $("#cuerpo_mail").html('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');
  if(id){
    if(id['id_mail'] != undefined){
      id_correo = id['id_mail']      
      $.ajax({        ////////////cambiar estado correo
        type: "POST",      
        url:'inbox.php?tipo=mc&id='+id_correo,
        success: function(data, status) {      
          if(data == 0){
            $("#total_enviados").html("");
            $("#total_enviados").html(total_enviados);                          
          }else{
          }        
        },
        error: function (data) {            
        }           
      });     
      //////////////////
      $.ajax({        
        type: "POST",
        dataType: 'json',                      
        url: "../varios.php?tipo=0&id="+id_correo+"&tam=8&fun=20",        
        success: function(data, status) {          
          //console.log(data);
          data = data;               
          loadStop();                    
          $("#subject").html("");
          $("#subject").html(data['cuerpo'][2]);
          $("#from_mail").html("");
          $("#from_mail").html("De: "+data['cuerpo'][5]);
          $("#cuerpo_mail").html("");
          $("#cuerpo_mail").html(data['cuerpo'][3]);
          $("#date_mail").html("");
          $("#date_mail").html(data['cuerpo'][1]);
          if(data['cuerpo'][4] == ''){
          }else{
            $("#footer_mail").append('<li><span class="mailbox-attachment-icon"><i class="fa fa-file-archive-o"></i></span><div class="mailbox-attachment-info"><a href="#" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> '+data['cuerpo'][4]+'</a><span class="mailbox-attachment-size">'+data['cuerpo'][6]+' Kb<a href="#" onclick="return descargar_archivo('+data['cuerpo'][7]+',1)" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a></span></div></li>');
          } 
          $("#btn_reenviar").attr('href','reenviar.php?id='+data['cuerpo'][7]);    ///envio id bitacora           
        }, 
        error: function (data) {            
          loadStart();
        },   
        beforeSend: function(){
          loadStart();                
        },     
      }); 
    }else{
      if(id['id_envio'] != undefined){
        id_correo = id['id_envio'];
        $.ajax({        
          type: "POST",
          dataType: 'json',              
          timeout: 60000,            
          url: "../varios.php?tipo=0&id="+id_correo+"&tam=8&fun=31",        
          success: function(data, status) {                   
            data = data;               
            loadStop();                    
            $("#subject").html("");
            $("#subject").html(data['cuerpo'][2]);
            $("#from_mail").html("");
            $("#from_mail").html("De: "+data['cuerpo'][5]);
            $("#cuerpo_mail").html("");
            $("#cuerpo_mail").html(data['cuerpo'][3]);
            $("#date_mail").html("");
            $("#date_mail").html(data['cuerpo'][1]);
            if(data['cuerpo'][4] == ''){
            }else{
              $("#footer_mail").append('<li><span class="mailbox-attachment-icon"><i class="fa fa-file-archive-o"></i></span><div class="mailbox-attachment-info"><a href="#" class="mailbox-attachment-name"><i class="fa fa-paperclip"></i> '+data['cuerpo'][4]+'</a><span class="mailbox-attachment-size">'+data['cuerpo'][6]+' Kb<a href="#" onclick="return descargar_archivo('+data['cuerpo'][7]+',1)" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a></span></div></li>');                            
            }
            $("#footer_mail").append('<li class="pull-right"><span class=""><label for="txt_usuarios" class="">Para los Usuarios:</label><select disabled="disabled" class="chosen-select form-control" id="txt_usuarios" name="txt_usuarios" data-placeholder="Tipo de Documento" multiple></select></span></li>');
            $.ajax({        
              type: "POST",
              dataType: 'json',        
              url: "../varios.php?tipo=0&id="+data['cuerpo'][7]+"&tam=1&fun=32",        
              success: function(data, status) {         
                //console.log(data);
                  $('#txt_usuarios').html("");           
                  for (var i = 0; i < data.length; i=i+1) {                                                             
                        $("#txt_usuarios").append("<option value ="+data[i]+" selected>"+data[i]+"</option>"); 
                  } 
                  $("#txt_usuarios").trigger("chosen:updated");                                      
              },
              error: function (data) {            
              },
              async: false,         
            });
            $("#txt_usuarios").chosen();              
            $("#btn_reenviar").attr('href','reenviar.php?id='+data['cuerpo'][7]);////id bitacora

          }, 
          error: function (data) {            
            loadStart();
          },   
          beforeSend: function(){
            loadStart();                
          },     
        });                  
      } 
    }        
  }    
}
function loadStart() { 
  $('#load').show();
}
function loadStop() {  
  $('#load').hide();  
}
function descargar_archivo (id,fn){      
  window.open("descarga.php?id="+id+"&fn="+fn,'_blank');   
}
function buscar_archivos(text,check){
  if(text.length > 0){
    $("#tabla_inbox tbody").html('<div id="load" class="loading"><div class="contenedor"><div class="content"><div class="ball"></div><div class="ball1"></div></div></div></div>');  
    $.ajax({        
      type: "POST",
      dataType: 'json',           
      url: "../varios.php?tipo=0&id=0&tam=0&fun=34&sub="+check+"&txt="+$("#txt_buscar").val(),        
      success: function(data, status) {          
        loadStop();
        for (var i = 0; i < data.length; i=i+10) {                           
          adjunto = "<a onclick='return descargar_archivo("+data[i + 3]+",1)'><i class='fa fa-paperclip'></i></a>";      
          if(data[i + 9] == '0'){
            estado = "En Revisión";    
          }else{
            estado = "Finalizado";    
          }
          


          $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data[i + 3]+"</td><td class='mailbox-name'>"+estado+"</td><td class='mailbox-subject'><b>"+data[i + 7]+"</b></td><td class='mailbox-subject'>"+data[i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data[i + 8], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='#' onclick='return descargar_archivo("+data[i + 3]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data[i + 3]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data[i + 3]+"&id_archivo="+data[i]+"'><i class='fa fa-search-plus'></i>Historial</a></li></ul></div></td></tr>");                                                                    
        }  
        var div = Math.floor((data.length)/2);      
        if(div == 0){
          div = 1;
        }      
        $("#tabla_inbox tr:nth-child(n + "+(div+1)+")").each(function(){        
          var ss = $(this).children(":last");        
          ss.addClass('dropup');
        });                                
      },
      error: function (data) {            
        loadStart();
      },   
      beforeSend: function(){
        loadStart();                
      },
    }); 
  }else{
    $.gritter.add({                         
      title: 'Datos Enviados..!',             
      text: "Indique una palabra antes de continuar....",
      image: '../../img/error.png',             
      sticky: false,              
      time: 2000,                 
      class_name: 'light',                    
      after_close: function(){
          $("#txt_buscar").val("");
          $("#txt_buscar").focus();                          
      },              
    });       
  }
}