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
  /*--------------*///obtener el url para cargar enviados,recibos, readMail, o buscar archivos
  ///////////////////////
  var id_get = getGET(loc);        
  /*-------Buscar documentos texto------*/
  $("#btn_12").on("click",function(){
    buscar_archivos($("#txt_buscar").val(),$("#check_buscar").is(":checked"));
  });
  /*------------------------------------*/       
  
}
function loadStart() { 
  $('#load').show();
}
function loadStop() {  
  $('#load').hide();  
}
function descargar_archivo (id,fn){      
  window.open("../inbox/descarga.php?id="+id+"&fn="+fn,'_blank');   
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
          $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data[i + 3]+"</td><td class='mailbox-name'>"+estado+"</td><td class='mailbox-subject'><b>"+data[i + 7]+"</b></td><td class='mailbox-subject'>"+data[i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data[i + 8], "YYYYMMDD, h:mm:ss").fromNow()+" </td><td style='overflow:visible;'><div class='btn-group'><button type='button' class='btn btn-primary dropdown-toggle'data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Desplegar menú</span></button><ul class='dropdown-menu  pull-right menu_inbox' role='menu'><li><a href='#'><i class='fa fa-file-text-o'></i>Hoja de Ruta</a></li><li><a href='#' onclick='return descargar_archivo("+data[i + 3]+",1)'><i class='fa fa-paperclip'></i>Descargar Archivo</a></li><li><a href='#' onclick='return descargar_archivo("+data[i + 3]+",2)'><i class='fa fa-paperclip'></i>Descargar Última Versión</a></li><li><a href='historial.php?id="+data[i + 3]+"&id_archivo="+data[i]+"'><i class='fa fa-search-plus'></i>Historial</a></li><li><a href='#' onclick='return reestablecer("+data[i]+",1)' ><i class='fa fa-check'></i>Reestablecer</a></li></ul></div></td></tr>");                                                                    
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
function reestablecer(id,fun){  
  loadStart();  
  $.ajax({        
      type: "POST",
      dataType: 'json',           
      url: "reestablecer.php?id="+id+"&fn="+fun,        
      success: function(data, status) {          
        loadStop();         
        buscar_archivos($("#txt_buscar").val(),$("#check_buscar").is(":checked"));       
        $.gritter.add({                         
        title: 'Datos Enviados..!',             
        text: "Documento Reestablecido",
        image: '../../img/confirm.png',             
        sticky: false,              
        time: 1000,                 
        class_name: 'light',                    
        after_close: function(){          
          $("#txt_buscar").val("");
          $("#txt_buscar").focus();                          
        },              
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