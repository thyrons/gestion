<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

$id = id($conexion,'tipo_documento','id_tipo_documento');
$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {    
    $repetidos = repetidos($conexion, "codigo_doc", strtoupper($_POST['txt_1']), "tipo_documento", "g", "", "", "","");
    if ($repetidos == 'true') {
        $data = "1"; /// este código ya existe;
    }else{
        $repetidos = repetidos($conexion, "nombre_doc", ucwords(strtolower($_POST['txt_2'])), "tipo_documento", "g", "", "", "","");
        if ($repetidos == 'true') {
            $data = "2"; /// este nombre ya existe;
        } else {
            $sql = "insert into tipo_documento values ('".$id."', '" . strtoupper($_POST['txt_1']) . "' ,'" . ucwords(strtolower($_POST['txt_2'])) . "','0')";
            $guardar = guardarSql($conexion, $sql);
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_tipo_documento,codigo_doc,nombre_doc,estado_doc) from tipo_documento where id_tipo_documento = '$id'";        
                $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                auditoria_sistema($conexion,'tipo_documento',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla tipo_documento');
                $data = "3";//guardado    
            }else{
                $data = "4"; ///error al guardar
            }            
        }            
    }    
}else {
    if ($_POST['tipo'] == "m") {        
        $repetidos = repetidos($conexion, "codigo_doc", strtoupper($_POST['txt_1']), "tipo_documento", "m", $_POST['txt_0'], 'id_tipo_documento', "", "");                    
        if ($repetidos == 'true') {
            $data = "1"; /// este codigo ya existe;
        }else{
            $repetidos = repetidos($conexion, "nombre_doc", ucwords(strtolower($_POST['txt_2'])), "tipo_documento", "m", $_POST['txt_0'], 'id_tipo_documento', "", "");                    
            if ($repetidos == 'true') {
                $data = "2"; /// este dato ya existe;
            } else {            
                $sql_anterior = "select (id_tipo_documento,codigo_doc,nombre_doc,estado_doc) from tipo_documento where id_tipo_documento = '".$_POST['txt_0']."'";        
                $sql_anterior = sql_array($conexion,$sql_anterior);
                $sql = "update tipo_documento set codigo_doc = '" . strtoupper($_POST['txt_1']) . "', nombre_doc= '" . ucwords(strtolower($_POST['txt_2'])) . "' where id_tipo_documento = '".$_POST['txt_0']."'";            
                $guardar = guardarSql($conexion, $sql);            
                if($guardar == 'true'){                
                    $sql_nuevo = "select (id_tipo_documento,codigo_doc,nombre_doc,estado_doc) from tipo_documento where id_tipo_documento = '".$_POST['txt_0']."'";      
                    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                    auditoria_sistema($conexion,'tipo_documento',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla tipo_documento");                        
                    $data = "3";
                }else{
                    $data = '4';
                }            
            }
        }        
    }
}
echo $data;
?>

