<?php

    include '../conexion.php';
    include '../funciones_generales.php';
    $conexion = conectarse();
    date_default_timezone_set('America/Guayaquil');
    $fecha = date('Y-m-d H:i:s', time());
    $fecha_doc = date('Y-m-d', time());
    $fecha_larga = date('His', time());
    $sql = "";

    $id_user = sesion_activa();
    $ruta = '../../archivos/';
    $sql = "select archivo.id_archivo,bitacora.id_bitacora,codigo_archivo,referencia from archivo,bitacora where archivo.id_archivo = bitacora.id_archivo and id_bitacora = '".$_GET['id_reenvio']."'";
    $sql = pg_query($conexion, $sql);
    while($row = pg_fetch_row($sql)){
        $id_archivo = $row[0];        
        $referencia = $row[3];    
        $codigo_archivo = $row[2];
    }
    
    $sql = "select id_bitacora,referencia,peso,tipo,estado from bitacora where id_archivo = '".$id_archivo."' order by id_bitacora desc limit 1" ;
    $sql = pg_query($conexion, $sql);
    while($row = pg_fetch_row($sql)){
        $referencia = $row[1];
        $peso = $row[2];
        $tipo = $row[3];
        $estado = $row[4];
    }
    ///////////////verificar el archivo///////////  
    $sql_anterior = "select (id_archivo,nombre_archivo,codigo_archivo,origen,fuente_usuario,fecha_creacion,estado) from archivo where id_archivo = '".$id_archivo."'";         
    $sql_anterior = sql_array($conexion,$sql_anterior);                                      
    
    $sql = "update archivo set estado = '".$_GET['txt_7']."' where id_archivo = '".$id_archivo."'";    
    $guardar = guardarSql($conexion, $sql);
    
    $sql_nuevo = "select (id_archivo,nombre_archivo,codigo_archivo,origen,fuente_usuario,fecha_creacion,estado) from archivo where id_archivo = '".$id_archivo."'";         
    $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
    auditoria_sistema($conexion,'archivo',$id_user,'Update',$id_archivo,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,'Modificación del estado del archivo');

    ///id bitacora///
    $id_bitacora = id($conexion,'bitacora','id_bitacora');    

    if ($_GET['tipo'] == "m") {
        //sin documento archivo SD    
        ////////////proceso bitacora //////////////
        $sql = "insert into bitacora values ('".$id_bitacora."','".$id_archivo."','".$fecha."','".$_GET['txt_3']."','".$_SESSION['id_gestion']."','".$_GET['txt_6']."','".$_GET['txt_5']."','".''."','".$_GET['txt_10']."','".$peso."','".$referencia."','".$tipo."','".$_GET['txt_7']."')";
        $guardar = guardarSql($conexion, $sql);
        if($guardar == 'true'){                
            $sql_nuevo = "select (id_bitacora,id_archivo,fecha_cambios,asunto_cambio,id_usuario,id_tipo_documento,id_medio_recepcion,observaciones,peso,referencia,tipo,estado) from bitacora where id_bitacora = '".$id_bitacora."'";
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'bitacora',$id_user,'Insert',$id_bitacora,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla bitacora');
            $data = "1";//guardado                                        
            ///////proceso envio////////                                                        
            $array = explode(",", $_GET['user']);
            for($i = 0; $i < count($array); $i++){
                $id_envio = id($conexion,'enviados','id_envio');                                
                $sql = "insert into enviados values('".$id_envio."','".$id_archivo."','".$id_bitacora."','".$fecha."','0','0','".$array[$i]."')";                                
                $guardar = guardarSql($conexion, $sql);
                $sql_nuevo = "select (id_envio,id_archivo,id_bitacora,fecha,estado,leido,id_usuario) from enviados where id_envio = '".$id_envio."'";
                $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                auditoria_sistema($conexion,'enviados',$id_user,'Insert',$id_envio,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla enviados. Reenvió del documento a los respectivos usuarios');
                $data = '1';
            }                            
            ////////////////////////////
            ////////proceso recibido////
            $aa = "array['".$_GET['user']."']";                                                                
            $id_recibido = id($conexion,'recibidos','id_recibido');
            $sql = "insert into recibidos values ('".$id_recibido."','".$id_archivo."','".$id_bitacora."','".$fecha."','".$_SESSION['id_gestion']."',$aa)";                            
            $guardar = guardarSql($conexion, $sql);
            $sql_nuevo = "select (id_recibido,id_archivo,id_bitacora,fecha,id_usuario,usuarios) from recibidos where id_recibido = '".$id_recibido."'";
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'recibidos',$id_user,'Insert',$id_recibido,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo');
            $data = '1';        
        }else{
            $data = "2"; ///error al guardar                    
        }                                
        
    } else {    
        if ($_GET['tipo'] == "sm") {        
            foreach ($_FILES as $key) {         
                if($key['error'] == UPLOAD_ERR_OK){
                    $nombre_original = $key['name'];
                    $temporal = $key['tmp_name'];                    
                    $extension = explode(".", $key['name']); 
                    $extension = end($extension);                    
                    $type = $extension;                    
                    $size = $key["size"];                    
                    $nombre = basename($key["name"],".".$extension);
                    $codigo_documento=$nombre{0}."-".$fecha_doc."-".$extension."-".$id_archivo."-".$id_bitacora;                      
                    $nombre = basename($key["name"],".".$extension);
                    $nombre=$nombre.$fecha_larga.$id_archivo.".".$extension;
                    $destino = $ruta.$nombre;
                    $root = getcwd();
                    ////////////////
                    $bytea = '';
                    /////////////
                    move_uploaded_file($temporal, $root.$destino);                    
                    
                    ////////////proceso bitacora //////////////
                    $sql = "insert into bitacora values ('".$id_bitacora."','".$id_archivo."','".$fecha."','".$_GET['txt_3']."','".$_SESSION['id_gestion']."','".$_GET['txt_6']."','".$_GET['txt_5']."','".$bytea."','".$_GET['txt_10']."','".$size."','".$nombre."','".$extension."','".$_GET['txt_7']."')";
                    $guardar = guardarSql($conexion, $sql);
                    if($guardar == 'true'){                
                        $sql_nuevo = "select (id_bitacora,id_archivo,fecha_cambios,asunto_cambio,id_usuario,id_tipo_documento,id_medio_recepcion,observaciones,peso,referencia,tipo,estado) from bitacora where id_bitacora = '".$id_bitacora."'";
                        $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                        auditoria_sistema($conexion,'bitacora',$id_user,'Insert',$id_bitacora,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla bitacora');
                        $data = "1";//guardado    
                        ////////////proceso metas//////////
                        $id_meta = id($conexion,'metas','id_meta');
                        $sql = "insert into metas values('".$id_meta."','nombre','".$nombre_original."','".$id_archivo."')";
                        $guardar = guardarSql($conexion, $sql);
                        $sql_nuevo = "select (id_meta,nombre_meta,descripcion_meta,id_archivo) from metas where id_meta = '".$id_archivo."'";
                        $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                        auditoria_sistema($conexion,'metas',$id_user,'Insert',$id_meta,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla meta');

                        $id_meta = id($conexion,'metas','id_meta');
                        $sql = "insert into metas values('".$id_meta."','tipo','".$type."','".$id_archivo."')";
                        $guardar = guardarSql($conexion, $sql);
                        $sql_nuevo = "select (id_meta,nombre_meta,descripcion_meta,id_archivo) from metas where id_meta = '".$id_archivo."'";
                        $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                        auditoria_sistema($conexion,'metas',$id_user,'Insert',$id_meta,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla meta');

                        $id_meta = id($conexion,'metas','id_meta');
                        $sql = "insert into metas values('".$id_meta."','tamaño','".$size."','".$id_archivo."')";
                        $guardar = guardarSql($conexion, $sql);
                        $sql_nuevo = "select (id_meta,nombre_meta,descripcion_meta,id_archivo) from metas where id_meta = '".$id_archivo."'";
                        $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                        auditoria_sistema($conexion,'metas',$id_user,'Insert',$id_meta,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla meta');
                        ///////////////////////////////

                        ///////proceso envio////////                                                        
                        $array = explode(",", $_GET['user']);
                        for($i = 0; $i < count($array); $i++){
                            $id_envio = id($conexion,'enviados','id_envio');                                
                            $sql = "insert into enviados values('".$id_envio."','".$id_archivo."','".$id_bitacora."','".$fecha."','0','0','".$array[$i]."')";                                
                            $guardar = guardarSql($conexion, $sql);
                            $sql_nuevo = "select (id_envio,id_archivo,id_bitacora,fecha,estado,leido,id_usuario) from enviados where id_envio = '".$id_envio."'";
                            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                            auditoria_sistema($conexion,'enviados',$id_user,'Insert',$id_envio,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla enviados. Renvió del documento a los respectivos usuarios');
                            $data = '1';
                        }                            
                        ////////////////////////////
                        ////////proceso recibido////
                        $aa = "array['".$_GET['user']."']";                                                                
                        $id_recibido = id($conexion,'recibidos','id_recibido');
                        $sql = "insert into recibidos values ('".$id_recibido."','".$id_archivo."','".$id_bitacora."','".$fecha."','".$_SESSION['id_gestion']."',$aa)";                            
                        $guardar = guardarSql($conexion, $sql);
                        $sql_nuevo = "select (id_recibido,id_archivo,id_bitacora,fecha,id_usuario,usuarios) from recibidos where id_recibido = '".$id_recibido."'";
                        $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                        auditoria_sistema($conexion,'recibidos',$id_user,'Insert',$id_recibido,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla recibidos. Usuarios a los que se reenvio el archivo');
                        $data = '1';
                        
                    }else{
                        $data = "2"; ///error al guardar                    
                    }
                }
                if($key['error'] == ''){        
                    $data = "1";
                }else{
                    if($key['error'] != ''){
                        $data = 'No se puedo subir el archivo '.$nombre_original.' debido al siguiente error '.$key['error'];            
                    }
                }       
            }
        }else{
           if ($_GET['tipo'] == "mc") {        ////acutalizar el nro de correos
                $sql_anterior = "select (id_envio,id_archivo,id_bitacora,fecha,estado,leido,id_usuario) from enviados where id_envio = '".$_GET['id']."'";
                $sql_anterior = sql_array($conexion,$sql_anterior);                                                      
                
                $sql = "update enviados set leido = '1' where id_envio = '".$_GET['id']."'";
                $guardar = guardarSql($conexion, $sql);
                
                $sql_nuevo = "select (id_envio,id_archivo,id_bitacora,fecha,estado,leido,id_usuario) from enviados where id_envio = '".$_GET['id']."'";
                $sql_nuevo = sql_array($conexion,$sql_nuevo);           
                
                auditoria_sistema($conexion,'enviados',$id_user,'Update',$id_archivo,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,'Archivo visto por el usuario correspondiente');
                        
                $guardar = guardarSql($conexion, $sql);
                if($guardar == 'true'){                       
                    $data = '0';
                }else{
                    $data = '1';
                } 
           } 
        }    
    }
    echo $data;
?>

