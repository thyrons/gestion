<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

$id = id($conexion,'medio_recepcion','id_medio');
$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {    
    $repetidos = repetidos($conexion, "codigo_medio", strtoupper($_POST['txt_1']), "medio_recepcion", "g", "", "", "","");
    if ($repetidos == 'true') {
        $data = "1"; /// este código ya existe;
    }else{
        $repetidos = repetidos($conexion, "nombre_medio", ucwords(strtolower($_POST['txt_2'])), "medio_recepcion", "g", "", "", "","");
        if ($repetidos == 'true') {
            $data = "2"; /// este nombre ya existe;
        } else {
            $sql = "insert into medio_recepcion values ('".$id."', '" . strtoupper($_POST['txt_1']) . "' ,'" . ucwords(strtolower($_POST['txt_2'])) . "','0')";
            $guardar = guardarSql($conexion, $sql);
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_medio,codigo_medio,nombre_medio,estado) from medio_recepcion where id_medio = '$id'";        
                $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                auditoria_sistema($conexion,'medio_recepcion',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla medio_recepcion');
                $data = "3";//guardado    
            }else{
                $data = "4"; ///error al guardar
            }            
        }            
    }    
}else {
    if ($_POST['tipo'] == "m") {        
        $repetidos = repetidos($conexion, "codigo_medio", strtoupper($_POST['txt_1']), "medio_recepcion", "m", $_POST['txt_0'], 'id_medio', "", "");                    
        if ($repetidos == 'true') {
            $data = "1"; /// este codigo ya existe;
        }else{
            $repetidos = repetidos($conexion, "nombre_medio", ucwords(strtolower($_POST['txt_2'])), "medio_recepcion", "m", $_POST['txt_0'], 'id_medio', "", "");                    
            if ($repetidos == 'true') {
                $data = "2"; /// este dato ya existe;
            } else {            
                $sql_anterior = "select (id_medio,codigo_medio,nombre_medio,estado) from medio_recepcion where id_medio = '".$_POST['txt_0']."'";        
                $sql_anterior = sql_array($conexion,$sql_anterior);
                $sql = "update medio_recepcion set codigo_medio = '" . strtoupper($_POST['txt_1']) . "', nombre_medio= '" . ucwords(strtolower($_POST['txt_2'])) . "' where id_medio = '".$_POST['txt_0']."'";            
                $guardar = guardarSql($conexion, $sql);            
                if($guardar == 'true'){                
                    $sql_nuevo = "select (id_medio,codigo_medio,nombre_medio,estado) from medio_recepcion where id_medio = '".$_POST['txt_0']."'";      
                    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                    auditoria_sistema($conexion,'medio_recepcion',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla medio_recepcion");                        
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

