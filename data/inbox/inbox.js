$(document).on("ready",inicio);    
var registros = 3;
var limite = 3;
var first = 0;
var temp = 0;
var total_registros = 0;
function inicio(){	
  total_registro();
	cargar_recibidos();		
  ////
  $("button[name$='adelante']").on('click',function(){
    first =  limite;    
    if(total_registros < (limite + registros)){
      temp = limite + registros;
      limite = total_registros;      
    }else{
      limite = limite + registros;  
    }    
    siguiente(first,limite);  
  });

  $("button[name$='atras']").on('click',function(){      
    if((first - registros) <= 0){
      first =  0;  
      limite = registros; 
    }else{
      first = temp - registros;
      limite = limite - registros;
      temp = temp - registros;
    }            
    atras_f(first,limite);  
  });
}
function cargar_recibidos(){  
	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id=0&tam=11&fun=17&inicio="+first+"&fin="+registros,        
    	success: function(data, status) {      				        
          if(limite > total_registros){
            limite = total_registros;
          }
      		$("#tabla_inbox tbody").html("");
      		$("label[name$='tot']").append((first+1) + ' - '+ limite + ' / ' + total_registros);      		
      		for (var i = 0; i < (limite * 11); i=i+11) {      			
      			if((data['cuerpo'].length / 11) > (i / 11)){
					if(data['cuerpo'][i + 10] == ''){
	      				adjunto = "<i class=''></i>";
	      			}else{
	      				adjunto = "<i class='fa fa-paperclip'></i>";
	      			}	      			
	      			$("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href=''>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+"</td></tr>");
      			}      			
      		}
    	},
    	error: function (data) {		        
    	}	        
  	});    
}
function siguiente(inicio,fin){
  $.ajax({        
    type: "POST",
    dataType: 'json',        
    url: "../varios.php?tipo=0&id=0&tam=11&fun=17&inicio="+first+"&fin="+registros,            
    success: function(data, status) {
      if(data['cuerpo'].length > 0){              
        $("#tabla_inbox tbody").html("");
        $("label[name$='tot']").html("");
        $("label[name$='tot']").append((first+1) + ' - '+ limite + ' / ' + total_registros);          
        for (var i = 0; i < (limite * 11); i=i+11) {            
          if((data['cuerpo'].length / 11) > (i / 11)){
        if(data['cuerpo'][i + 10] == ''){
              adjunto = "<i class=''></i>";
            }else{
              adjunto = "<i class='fa fa-paperclip'></i>";
            }             
            $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href=''>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+"</td></tr>");
          }           
        }
      }
    },
    error: function (data) {            
    }         
  });     
}
function atras_f(inicio,fin){
  $.ajax({        
    type: "POST",
    dataType: 'json',        
    url: "../varios.php?tipo=0&id=0&tam=11&fun=17&inicio="+first+"&fin="+registros,            
    success: function(data, status) {
      if(data['cuerpo'].length > 0){              
        $("#tabla_inbox tbody").html("");
        $("label[name$='tot']").html("");
        $("label[name$='tot']").append((first + 1 ) + ' - '+ limite + ' / ' + total_registros);          
        for (var i = 0; i < (limite * 11); i=i+11) {            
          if((data['cuerpo'].length / 11) > (i / 11)){
        if(data['cuerpo'][i + 10] == ''){
              adjunto = "<i class=''></i>";
            }else{
              adjunto = "<i class='fa fa-paperclip'></i>";
            }             
            $("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href=''>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b></td><td class='mailbox-subject'>"+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+"</td></tr>");
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
    },
    error: function (data) {            
    }         
  });     
}
function cargar_enviados(){}
function cargar_no_deseados(){}
