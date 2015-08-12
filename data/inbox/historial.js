$(document).on("ready",inicio);
var dataTable_historial = jQuery('#tabla_historial').DataTable({
    "bAutoWidth": false,	    
    "sScrollY": "100%",
    "sScrollX": "100%",
    "sScrollXInner": "100%",
    "paging": true,
    "aaSorting": [[ 2, 'asc' ]],         
    "aoColumnDefs": [
        { "bSearchable": false, "bVisible": false, "aTargets": [ 0 ], "sWidth": "null" },        
        { "bSearchable": true, "bVisible": false, "aTargets": [ 1 ] , "sWidth": "15%"},        
        { "bSearchable": true, "bVisible": false, "aTargets": [ 2 ] , "sWidth": "15%"},        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 3 ] , "sWidth": "15%"},        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 4 ] , "sWidth": "15%"},        
        { "bSearchable": false, "bVisible": true, "aTargets": [ 5 ] , "sWidth": "null"},        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 6 ] , "sWidth": "15%"},                
        { "bSearchable": true, "bVisible": false, "aTargets": [ 7 ] , "sWidth": "15%"},                
        { "bSearchable": true, "bVisible": true, "aTargets": [ 8 ] , "sWidth": "20%"},                       
        { "bSearchable": false, "bVisible": false, "aTargets": [ 9 ] , "sWidth": "null"},                       
        { "bSearchable": true, "bVisible": true, "aTargets": [ 10 ] , "sWidth": "20%"},                                                    
    ],    

  	"bPaginate": true,
  	"bLengthChange": true,
  	"bFilter": true,
  	"bSort": true,
  	"bInfo": true,  	
  	'iDisplayLength': 10,
  	responsive: true             
});         
function inicio(){					
	var id_hist = getGET(loc);
	cargar_tabla_historial(id_hist.id_archivo);
}

function cargar_tabla_historial(id){
	$.ajax({
        type: "POST",
        url: "../varios.php?tipo=0&fun=33&tam=11&id="+id,          
        dataType: 'json',
        success: function(response) {                
        	dataTable_historial.fnClearTable();        	
        	for (var i = 0; i < response.length; i=i+11) {            		
        		if(response[i + 8] == '1'){
    					response[i + 8] = 'Finalizado';
    				}else{
    					response[i + 8] = 'En Revisión';
    				}
            if(response[i + 5] != ''){
              response[i + 5] = "<a onclick='return descargar_archivo("+response[i]+",1)'><i class='fa fa-paperclip'></i></a>";                                 
            }else{
              response[i + 5] = '';
            }
        		dataTable_historial.fnAddData([
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
	           	]);                    
            }                            
        }        
    });        
}