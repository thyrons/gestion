<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

$id = id($conexion,'tipo_usuario','id_tipo_usuario');
$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {        
    $repetidos = repetidos($conexion, "nombre_tipo", ucwords(strtolower($_POST['txt_1'])), "tipo_usuario", "g", "", "", "","");
    if ($repetidos == 'true') {
        $data = "2"; /// este nombre ya existe;
    } else {
        $sql = "insert into tipo_usuario values ('".$id."','" . ucwords(strtolower($_POST['txt_1'])) . "','1')";
        $guardar = guardarSql($conexion, $sql);
        if($guardar == 'true'){                
            $sql_nuevo = "select (id_tipo_usuario,nombre_tipo,estado) from tipo_usuario where id_tipo_usuario = '$id'";        
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'tipo_usuario',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla tipo_usuario');
            $data = "3";//guardado    
        }else{
            $data = "4"; ///error al guardar
        }            
    }                
}else {
    if ($_POST['tipo'] == "m") {                
        $repetidos = repetidos($conexion, "nombre_tipo", ucwords(strtolower($_POST['txt_1'])), "tipo_usuario", "m", $_POST['txt_0'], 'id_tipo_usuario', "", "");                    
        if ($repetidos == 'true') {
            $data = "2"; /// este dato ya existe;
        } else {            
            $sql_anterior = "select (id_tipo_usuario,nombre_tipo,estado) from tipo_usuario where id_tipo_usuario = '".$_POST['txt_0']."'";        
            $sql_anterior = sql_array($conexion,$sql_anterior);
            $sql = "update tipo_usuario set nombre_tipo= '" . ucwords(strtolower($_POST['txt_1'])) . "' where id_tipo_usuario = '".$_POST['txt_0']."'";            
            $guardar = guardarSql($conexion, $sql);            
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_tipo_usuario,nombre_tipo,estado) from tipo_usuario where id_tipo_usuario = '".$_POST['txt_0']."'";      
                $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                auditoria_sistema($conexion,'tipo_usuario',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla tipo_usuario");                        
                $data = "3";
            }else{
                $data = '4';
            }            
        }                
    }
}
echo $data;
?>

