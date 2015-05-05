$(document).on("ready",inicio);    
var limite = 50;
var first = 1;
function inicio(){	
	cargar_recibidos();		
}
function cargar_recibidos(){
	$.ajax({        
    	type: "POST",
    	dataType: 'json',        
    	url: "../varios.php?tipo=0&id=0&tam=11&fun=17",        
    	success: function(data, status) {
      		console.log(data)      		
      		$("#tabla_inbox tbody").html("");
      		$("#tot").append(first + ' - '+ limite + ' / ' + data['cont']);
      		$("#tot1").append(first + ' - '+ limite + ' / ' + data['cont']);      		
      		for (var i = 0; i < (limite * 11); i=i+11) {      			
      			if((data['cuerpo'].length / 11) > (i / 11)){
					if(data['cuerpo'][i + 10] == ''){
	      				adjunto = "<i class=''></i>";
	      			}else{
	      				adjunto = "<i class='fa fa-paperclip'></i>";
	      			}	      			
	      			$("#tabla_inbox tbody").append("<tr><td class='hidden'>"+data['cuerpo'][i]+"</td><td><input type='checkbox' /></td><td class='mailbox-name'><a href='read-mail.html'>"+data['cuerpo'][i+9]+"</a></td><td class='mailbox-subject'><b>"+data['cuerpo'][i+3]+"</b> - "+data['cuerpo'][i+4]+"</td><td class='mailbox-attachment'>"+adjunto+"</td><td class='mailbox-date'>"+moment(data['cuerpo'][i + 6], "YYYYMMDD, h:mm:ss").fromNow()+"</td></tr>");
      			}      			
      		}
    	},
    	error: function (data) {		        
    	}	        
  	});    
}
function cargar_enviados(){}
function cargar_no_deseados(){}