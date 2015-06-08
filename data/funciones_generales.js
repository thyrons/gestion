// $.gritter.add({
//     title: 'This is a regular notice!',
//     text: 'This will fade out after a certain amount of time.',
//     image: '../../dist/img/advertencia.fw.png',
//     class_name: 'dc_ok'
//   });
//   // error
//   $.gritter.add({
//     title: 'This is a regular notice!',
//     text: 'This will fade out after a certain amount of time.',
//     image: '../../dist/img/error.fw.png',
//     class_name: 'dc_ok'
//   });
//   // ok
//   $.gritter.add({
//     title: 'This is a regular notice!',
//     text: 'This will fade out after a certain amount of time.',
//     image: '../../dist/img/ok.fw.png',
//     sticky: false, 
//     class_name: 'dc_ok'
//   });
var keyStr = "ABCDEFGHIJKLMNOP" +
   "QRSTUVWXYZabcdef" +
   "ghijklmnopqrstuv" +
   "wxyz0123456789+/" +
   "=";

function encode64(input) {
    input = escape(input);
    var output = "";
    var chr1, chr2, chr3 = "";
    var enc1, enc2, enc3, enc4 = "";
    var i = 0;
    do {
        chr1 = input.charCodeAt(i++);
        chr2 = input.charCodeAt(i++);
        chr3 = input.charCodeAt(i++);

        enc1 = chr1 >> 2;
        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
        enc4 = chr3 & 63;

        if (isNaN(chr2)) {
           enc3 = enc4 = 64;
        } else if (isNaN(chr3)) {
           enc4 = 64;
        }

        output = output +
        keyStr.charAt(enc1) +
        keyStr.charAt(enc2) +
        keyStr.charAt(enc3) +
        keyStr.charAt(enc4);
        chr1 = chr2 = chr3 = "";
        enc1 = enc2 = enc3 = enc4 = "";
    } while (i < input.length);
    return output;
}

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
            if(form == "form_provincia"){            
                $("#btn_1").html('');
                $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
            }else{       
                if(form == "form_ciudad"){            
                    $("#btn_1").html('');
                    $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
                }else{       
                    if(form == "form_categoria"){            
                        $("#btn_1").html('');
                        $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
                    }else{       
                        if(form == "form_departamentos"){            
                            $("#btn_1").html('');
                            $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
                        }else{       
                            if(form == "form_tipo_documento"){            
                                $("#btn_1").html('');
                                $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
                            }else{       
                                if(form == "form_medio_recepcion"){            
                                    $("#btn_1").html('');
                                    $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
                                }else{       
                                    if(form == "form_tipo_usuario"){            
                                        $("#btn_1").html('');
                                        $("#btn_1").append("<span class='glyphicon glyphicon-save'></span> Guardar");                        
                                    }else{       
                                        
                                    }       
                                }    
                            }        
                        }    
                    }
                }                
            }
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



function carga_ubicaciones(pais,provincia,ciudad){
    $.ajax({        
        type: "POST",
        dataType: 'json',        
        url: "../varios.php?tipo=0&id=0&fun=1&tam=2",        
        success: function(response) {         
            for (var i = 0; i < response.length; i=i+2) {       
                if(response[i+1] == 'Ecuador'){
                    $("#"+pais).append("<option value ="+response[i]+" selected>"+response[i+1]+"</option>");                                                                                                                                           
                }
                else{
                    $("#"+pais).append("<option value ="+response[i]+">"+response[i+1]+"</option>");                                                                                                                                            
                }                        
            }   
            $("#"+pais).trigger("chosen:updated");                              
            $.ajax({       /*cargar el select provincia*/        
                type: "POST",
                dataType: 'json',        
                url: "../varios.php?tipo=0&id="+$("#"+pais).val()+"&fun=5&tam=2",        
                success: function(response) {         
                    for (var i = 0; i < response.length; i=i+2) {               
                        $("#"+provincia).append("<option value ="+response[i]+">"+response[i+1]+"</option>");                                                                                                                                           
                    }   
                    $("#"+provincia).trigger("chosen:updated");      
                    $.ajax({      /*cargar el select ciudades*/         
                        type: "POST",
                        dataType: 'json',        
                        url: "../varios.php?tipo=0&id="+$("#"+provincia).val()+"&fun=11&tam=2",        
                        success: function(response) {         
                            for (var i = 0; i < response.length; i=i+2) {               
                                $("#"+ciudad).append("<option value ="+response[i]+">"+response[i+1]+"</option>");                                                                                                                                           
                            }   
                            $("#"+ciudad).trigger("chosen:updated");                              
                        }                   
                    });                        
                }                   
            });
        }                   
    }); 
}
function change_pais(pais,provincia,ciudad){    
    $.ajax({       /*cargar el select provincia*/        
        type: "POST",
        dataType: 'json',        
        url: "../varios.php?tipo=0&id="+$("#"+pais).val()+"&fun=5&tam=2",        
        success: function(response) {         
            $("#"+provincia).html("");            
            $("#"+ciudad).html("");            
            $("#"+ciudad).trigger("chosen:updated");      
            for (var i = 0; i < response.length; i=i+2) {               
                $("#"+provincia).append("<option value ="+response[i]+">"+response[i+1]+"</option>");                                                                                                                                           
            }   
            $("#"+provincia).trigger("chosen:updated");      
            $.ajax({      /*cargar el select ciudades*/         
                type: "POST",
                dataType: 'json',        
                url: "../varios.php?tipo=0&id="+$("#"+provincia).val()+"&fun=11&tam=2",        
                success: function(response) {  
                    $("#"+ciudad).html("");       
                    for (var i = 0; i < response.length; i=i+2) {               
                        $("#"+ciudad).append("<option value ="+response[i]+">"+response[i+1]+"</option>");                                                                                                                                           
                    }   
                    $("#"+ciudad).trigger("chosen:updated");                              
                }                   
            });                        
        }                   
    });    
}
function change_provincia(pais,provincia,ciudad){    
    $.ajax({       /*cargar el select provincia*/        
        type: "POST",
        dataType: 'json',        
        url: "../varios.php?tipo=0&id="+$("#"+provincia).val()+"&fun=11&tam=2",        
        success: function(response) {         
            $("#"+ciudad).html("");
            for (var i = 0; i < response.length; i=i+2) {               
                $("#"+ciudad).append("<option value ="+response[i]+">"+response[i+1]+"</option>");                                                                                                                                           
            }   
            $("#"+ciudad).trigger("chosen:updated");                                      
        }                   
    });
}


function documentos(fun,txt_1,txt_2){
    if(fun == 0){
        $("#"+txt_2).val("");    
    }   
    $("#"+txt_2).focus();
    if($("#"+txt_1).val() == "Cédula"){                      
        $("#"+txt_2).prop("maxlength",10);
        $("#"+txt_2).attr("minlength",10);
        $("#"+txt_2).prop("pattern","[0-9]{10,10}");
    }else{
        if($("#"+txt_1).val() == "Ruc"){                             
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
function ci_ruc_pass(campo,valor,documento){
    var numero = valor;
    var suma = 0;      
    var residuo = 0;      
    var pri = false;      
    var pub = false;            
    var nat = false;                     
    var modulo = 11;
    var p1;
    var p2;
    var p3;
    var p4;
    var p5;
    var p6;
    var p7;
    var p8;            
    var p9; 
    var d1  = numero.substr(0,1);         
    var d2  = numero.substr(1,1);         
    var d3  = numero.substr(2,1);         
    var d4  = numero.substr(3,1);         
    var d5  = numero.substr(4,1);         
    var d6  = numero.substr(5,1);         
    var d7  = numero.substr(6,1);         
    var d8  = numero.substr(7,1);         
    var d9  = numero.substr(8,1);         
    var d10 = numero.substr(9,1);  

    if (d3 < 6){           
        nat = true;            
        p1 = d1 * 2;
        if (p1 >= 10) p1 -= 9;
        p2 = d2 * 1;
        if (p2 >= 10) p2 -= 9;
        p3 = d3 * 2;
        if (p3 >= 10) p3 -= 9;
        p4 = d4 * 1;
        if (p4 >= 10) p4 -= 9;
        p5 = d5 * 2;
        if (p5 >= 10) p5 -= 9;
        p6 = d6 * 1;
        if (p6 >= 10) p6 -= 9; 
        p7 = d7 * 2;
        if (p7 >= 10) p7 -= 9;
        p8 = d8 * 1;
        if (p8 >= 10) p8 -= 9;
        p9 = d9 * 2;
        if (p9 >= 10) p9 -= 9;             
        modulo = 10;
    } else if(d3 == 6){           
        pub = true;             
        p1 = d1 * 3;
        p2 = d2 * 2;
        p3 = d3 * 7;
        p4 = d4 * 6;
        p5 = d5 * 5;
        p6 = d6 * 4;
        p7 = d7 * 3;
        p8 = d8 * 2;            
        p9 = 0;            
    } else if(d3 == 9) {          
        pri = true;                                   
        p1 = d1 * 4;
        p2 = d2 * 3;
        p3 = d3 * 2;
        p4 = d4 * 7;
        p5 = d5 * 6;
        p6 = d6 * 5;
        p7 = d7 * 4;
        p8 = d8 * 3;
        p9 = d9 * 2;            
    }
    suma = p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9;                
    residuo = suma % modulo;                                         
    var digitoVerificador = residuo==0 ? 0: modulo - residuo; 
    ////////////verificamos del tipo cedula o ruc////////////////////
    if (documento == "Cédula") {
        if (numero.length === 10) {
            if(nat == true){
                if (digitoVerificador != d10){                          
                    $.gritter.add({                         
                        title: 'Datos Enviados..!',                         
                        text: 'El número de cédula es incorrecto.',
                        image: '../../img/error.png',                           
                        sticky: false,                          
                        time: 1000,                                 
                        class_name: 'light',                                
                         
                        after_open: function(){
                            $("#"+campo).val("");
                        },         

                    });                     
                    
                }else{                    
                    $.gritter.add({                         
                        title: 'Datos Enviados..!',                         
                        text: 'El número de cédula es correcto.',
                        image: '../../img/confirm.png',                           
                        sticky: false,                          
                        time: 1000,                                 
                        class_name: 'light',                                                        
                    });                                         
                }
            }
        }
    }else{
        if (documento === "Ruc") {
            var ruc = numero.substr(10,13);
            var digito3 = numero.substring(2,3);
            if(ruc == "001" ){
                if(digito3 < 6){ 
                    if(nat == true){
                        if (digitoVerificador != d10){  
                            $.gritter.add({                         
                                title: 'Datos Enviados..!',                         
                                text: 'El ruc persona natural es incorrecto.',
                                image: '../../img/error.png',                           
                                sticky: false,                          
                                time: 1000,                                 
                                class_name: 'light',                                
                                after_close: function(){
                                    $("#"+campo).val("");
                                },                          
                            });                                                     
                        }else{
                            $.gritter.add({                         
                                title: 'Datos Enviados..!',                         
                                text: 'El ruc persona natural es correcto.',
                                image: '../../img/confirm.png',                           
                                sticky: false,                          
                                time: 1000,                                 
                                class_name: 'light',                                                                
                            });                                                                                 
                        } 
                    }
                }else{
                    if(digito3 == 6){ 
                        if (pub==true){  
                            if (digitoVerificador != d9){             
                                $.gritter.add({                         
                                    title: 'Datos Enviados..!',                         
                                    text: 'El ruc público es incorrecto.',
                                    image: '../../img/error.png',                           
                                    sticky: false,                          
                                    time: 1000,                                 
                                    class_name: 'light',                                
                                    after_close: function(){
                                        $("#"+campo).val("");
                                    },                          
                                });                                             
                                
                            }else{
                                $.gritter.add({                         
                                    title: 'Datos Enviados..!',                         
                                    text: 'El ruc público es correcto.',
                                    image: '../../img/confirm.png',                           
                                    sticky: false,                          
                                    time: 1000,                                 
                                    class_name: 'light',                                                                
                                });                                       
                            } 
                        }
                    }else{
                        if(digito3 == 9){
                            if(pri == true){
                                if (digitoVerificador != d10){                          
                                    $.gritter.add({                         
                                        title: 'Datos Enviados..!',                         
                                        text: 'El ruc privado es incorrecto.',
                                        image: '../../img/error.png',                           
                                        sticky: false,                          
                                        time: 1000,                                 
                                        class_name: 'light',                                
                                        after_close: function(){
                                            $("#"+campo).val("");
                                        },                          
                                    });                                       
                                }else{
                                    $.gritter.add({                         
                                        title: 'Datos Enviados..!',                         
                                        text: 'El ruc privado es correcto.',
                                        image: '../../img/confirm.png',                           
                                        sticky: false,                          
                                        time: 1000,                                 
                                        class_name: 'light',                                                                
                                    });                                        
                                } 
                            }
                        } 
                    }
                }
            }else{
                if(numero.length === 13){
                    $.gritter.add({                         
                        title: 'Datos Enviados..!',                         
                        text: 'El ruc es incorrecto.',
                        image: '../../img/error.png',                           
                        sticky: false,                          
                        time: 1000,                                 
                        class_name: 'light',                                
                        after_close: function(){
                            $("#"+campo).val("");
                        },                          
                    });                                         
                }
            }
        }else{

        }                    
    }         
}
function appendToChosen(id,value,text,extra,chosen,chosen1){            
    $('#'+chosen).append($("<option data-extra='"+extra+"'></option>").val(id).html(value)).trigger('chosen:updated');        
    var input = $("#"+chosen1).children().next().children(); 
    $(input).children().val(text);        
    //console.log($("#txt_1_chosen").children().children().next())        
}
function getGET(loc){   
   var getString = loc.split('?')[1];
   if(getString){
       var GET = getString.split('&');
       var get = {};//this object will be filled with the key-value pairs and returned.

       for(var i = 0, l = GET.length; i < l; i++){
          var tmp = GET[i].split('=');
          get[tmp[0]] = unescape(decodeURI(tmp[1]));
       }
       return get;
   }      
}