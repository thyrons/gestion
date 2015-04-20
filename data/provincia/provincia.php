<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

$id = id($conexion,'provincias','id_provincia');
$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {                                
    $repetidos = repetidos($conexion, "nombre_provincia", ucwords(strtolower($_POST['txt_2'])), "provincia", "gr", "", "");
    if ($repetidos == 'true') {
        $data = "2"; /// este nombre ya existe;
    } else {
        $sql = "insert into provincia values ('".$id."','" . ucwords(strtolower($_POST['txt_2'])) . "','".$_POST['txt_1']."')";
        $guardar = guardarSql($conexion, $sql);
        if($guardar == 'true'){                
            $sql_nuevo = "select (id_provincia,nombre_provincia,id_pais) from provincia where id_provincia = '$id'";        
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'provincia',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla provincia');
            $data = "3";//guardado    
        }else{
            $data = "4"; ///error al guardar
        }
        
    }            
} else {
    if ($_POST['tipo'] == "m") {        
        $repetidos = repetidos($conexion, "nombre_provincia", ucwords(strtolower($_POST['txt_2'])), "provincia", "m", $_POST['txt_0'], 'id_provincia');                    
        if ($repetidos == 'true') {
            $data = "2"; /// este dato ya existe;
        } else {            
            $sql_anterior = "select (id_provincia,codigo_provincia,nombre_provincia) from provincia where id_provincia = '".$_POST['txt_0']."'";        
            $sql_anterior = sql_array($conexion,$sql_anterior);
            $sql = "update provincia set codigo_provincia = '" . $_POST['txt_1'] . "', nombre_provincia= '" . ucwords(strtolower($_POST['txt_2'])) . "' where id_provincia = '".$_POST['txt_0']."'";            
            $guardar = guardarSql($conexion, $sql);            
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_provincia,codigo_provincia,nombre_provincia) from provincia where id_provincia = '".$_POST['txt_0']."'";      
                $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                auditoria_sistema($conexion,'provincia',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla provincia");                        
                $data = "3";
            }else{
                $data = '4';
            }            
        }
    }
}
echo $data;
?>

