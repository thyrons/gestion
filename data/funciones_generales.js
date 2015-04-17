function fecha_actual (input){
    var d = new Date();
    var strDate = d.getFullYear() + "-" + (d.getMonth()+1) + "-" + d.getDate();
    $("#"+input).text(strDate);    
}
function mostrar(input) {///funcion para mostrar la hora se necesita un nombre de campo como parametro
    var Digital = new Date();
    var hours = Digital.getHours();
    var minutes = Digital.getMinutes();
    var seconds = Digital.getSeconds();
    var dn = "AM";    
    if (hours > 12) {
        dn = "PM";
        hours = hours - 12;
    }
    if (hours === 0)
        hours = 12;
    if (minutes <= 9)
        minutes = "0" + minutes;
    if (seconds <= 9)
        seconds = "0" + seconds;
    $("#"+input).text(hours + ":" + minutes + ":" + seconds + " " + dn);
    //$("#"+input).val(hours + ":" + minutes + ":" + seconds + " " + dn);    
    setTimeout("mostrar('"+input+"')", 1000);    
}
function comprobarCamposRequired(form){
    var correcto=true;

    var campos_text=$('#'+form+' input:required');        
    $(campos_text).each(function() {        
        var pattern = new RegExp("^" + $(this)[0].pattern + "$");                  
        if($(this).val() != '' && pattern.test($(this).val())){                    
            $(this).parent().removeClass('has-error');                               
        }else{
            correcto=false;
            $(this).parent().addClass('has-error');
        }   
    });
    if(correcto == true){
        $("#btn_1").attr("disabled", false);
    }else{
        $("#btn_1").attr("disabled", true);
    }
    return correcto; 
}

function actualizar_form(){    
    setTimeout(function() {
      location.reload();
    }, 2000);
    
}
function limpiar_form(e){
    if(e != undefined){        
        var form;
        if(e.type == "click"){///mediante el click del boton
            $("#"+e.currentTarget.form.id+" input").val("");
            comprobarCamposRequired(e.currentTarget.form.id);       
            form = e.currentTarget.form.id;
        }else{//form por el evento submit
            if(e.type == "submit"){
                $("#"+e.target.id+" input").val("");
                comprobarCamposRequired(e.target.id);       
                form = e.target.id
            }else{///id directo del form                
                $("#"+e+" input").val("");
                comprobarCamposRequired(e);     
                form = e;
            }
        }
        if(form == "form_pais"){            
            $("#btn_1").html('');
            $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
        }else{       
        }
        $("input:not([readonly='readonly']):text:visible:first").focus();   
    }
}

function punto(e){                
    if(e.keyCode == 46){        
        var texto = $(this).val();     
        var buscar = '.';      
        var contador = 0;    
        while (texto.indexOf(buscar) > -1) {        
            texto = texto.substr(texto.indexOf(buscar)+buscar.length,texto.length);
            contador++; 
        }
        //console.log(contador)
        if(contador <1 ){
            return true;
        } else{
            return false;
        }
    }    
}

function validarNumeros(e) { // 1    
    tecla = (document.all) ? e.keyCode : e.which; // 2
    //console.log(e.keyCode)
    if (tecla==8) return true; // backspace
    if (tecla==13) return true; // enter
    if (tecla==9) return true; // tab
    if (tecla==116) return true; // f5
    //if (tecla==109) return true; // menos
    if (tecla==110) return true; // punto
    //if (tecla==189) return true; // guion
    if (tecla==39) return true; // atras
    if (tecla==37) return true; // adelante
    if (e.ctrlKey && tecla==86) { return true}; //Ctrl v
    if (e.ctrlKey && tecla==67) { return true}; //Ctrl c
    if (e.ctrlKey && tecla==88) { return true}; //Ctrl x
    if (tecla>=96 && tecla<=105) { return true;} //numpad

    patron = /[0-9]/; // patron

    te = String.fromCharCode(tecla); 
    return patron.test(te); // prueba
}

function atras(id,carpeta,archivo){
    var url = '';    
    //url = "../secuencia.php?id="+id+"&fn=0";    
    url = "../"+carpeta+"/"+archivo+"?id="+id+"&fn=0"; 
    var resp = "";    
    $.ajax({                
        type: "POST",
        dataType: 'json',       
        url: url, 
        async:false,          
        success: function(data) {               
            resp = data;
        }
    });     
    return resp;
}

function adelante(id,carpeta,archivo){
    var url = '';    
    //url = "../secuencia.php?id="+id+"&fn=1";    
    url = "../"+carpeta+"/"+archivo+"?id="+id+"&fn=1"; 
    var resp = "";    
    $.ajax({                
        type: "POST",
        dataType: 'json',       
        url: url, 
        async:false,          
        success: function(data) {               
            resp = data;
        }
    });     
    return resp;
}





function documentos(fun,txt_1,txt_2){
    if(fun == 0){
        $("#"+txt_2).val("");    
    }   
    $("#"+txt_2).focus();
    if($("#"+txt_1).val() == "Cedula"){                      
        $("#"+txt_2).prop("maxlength",10);
        $("#"+txt_2).attr("minlength",10);
        $("#"+txt_2).prop("pattern","[0-9]{10,10}");
    }else{
        if($("#"+txt_1).val() == "RUC"){                             
            $("#"+txt_2).prop("maxlength",13);
            $("#"+txt_2).attr("minlength",13);
            $("#"+txt_2).prop("pattern","[0-9]{13,13}");
        }else{          
            $("#"+txt_2).removeAttr("maxlength");            
            $("#"+txt_2).attr("minlength",1);
            $("#"+txt_2).prop("pattern","[0-9]{1,}");
        }
    }
}


