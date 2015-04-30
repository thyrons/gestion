<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_doc = date('Y-m-d', time());
$fecha_larga = date('His', time());
$sql = "";

$ruta = '../../archivos/';

$id_archivo = id($conexion,'archivo','id_archivo');
$id_bitacora = id($conexion,'bitacora','id_bitacora');
$id_user = sesion_activa();
if ($_GET['tipo'] == "g") {                                
    
} else {
    if ($_GET['tipo'] == "m") {        
        
    }else{
        if ($_GET['tipo'] == "s") {        
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
                    $sql = "insert into archivo values ('".$id_archivo."','".$_GET['txt_2']."','".$codigo_documento."','".$_SESSION['departamento']."','".$_SESSION['id_gestion']."','".$fecha."','".$_GET['txt_7']."')";
                    $guardar = guardarSql($conexion, $sql);
                    if($guardar == 'true'){                
                        //////////proceso archivo//////
                        $sql_nuevo = "select (id_archivo,nombre_archivo,codigo_archivo,origen,fuente_usuario,fecha_creacion,estado) from archivo where id_archivo = '".$id_archivo."'";        
                        $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                        auditoria_sistema($conexion,'archivo',$id_user,'Insert',$id_archivo,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla archivo');
                        $data = "1";//guardado    
                        ////////////////
                        ////////////proceso bitacora //////////////
                        $sql = "insert into bitacora values ('".$id_bitacora."','".$id_archivo."','".$fecha."','".$_GET['txt_3']."','".$_SESSION['id_gestion']."','".$_GET['txt_6']."','".$_GET['txt_5']."','".$bytea."','".$_GET['txt_8']."','".$size."','".$nombre."','".$extension."','0')";
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
                                
                            }
                            
                            ////////////////////////////
                            ////////proceso recibido////
                            ///////////////////////////


                        }else{
                            $data = "2";
                        }
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
        }
    }
}
echo $data;
?>

