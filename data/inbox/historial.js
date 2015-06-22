$(document).on("ready",inicio);
var dataTable_historial = jQuery('#tabla_historial').DataTable({
    "bAutoWidth": false,	
    "scrollY": "300px",
    "scrollX": "100%",
    "sScrollXInner": "200%",
    "paging": true,
     "aaSorting": [[ 2, 'asc' ]],
    "aoColumnDefs": [
        { "bSearchable": false, "bVisible": false, "aTargets": [ 0 ], "swidth": "20%" },        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 1 ] },        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 2 ] },        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 3 ] },        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 4 ] },        
        { "bSearchable": false, "bVisible": false, "aTargets": [ 5 ] },        
        { "bSearchable": true, "bVisible": true, "aTargets": [ 6 ] },                
        { "bSearchable": true, "bVisible": true, "aTargets": [ 7 ] },                
        { "bSearchable": true, "bVisible": true, "aTargets": [ 8 ] },                       
        { "bSearchable": false, "bVisible": false, "aTargets": [ 9 ] },                       
        { "bSearchable": true, "bVisible": true, "aTargets": [ 10 ] },                       
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