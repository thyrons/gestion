<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

$id = id($conexion,'ciudad','id_ciudad');
$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {                                
    $repetidos = repetidos($conexion, "nombre_ciudad", ucwords(strtolower($_POST['txt_3'])), "ciudad", "gr", "", "", "id_provincia", $_POST['txt_2']);
    if ($repetidos == 'true') {
        $data = "2"; /// este nombre ya existe;
    } else {
        $sql = "insert into ciudad values ('".$id."','" . ucwords(strtolower($_POST['txt_3'])) . "','".$_POST['txt_2']."')";
        $guardar = guardarSql($conexion, $sql);
        if($guardar == 'true'){                
            $sql_nuevo = "select (id_ciudad,nombre_ciudad,id_provincia) from ciudad where id_ciudad = '" .$id. "'";        
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'ciudad',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla ciudad');
            $data = "3";//guardado    
        }else{
            $data = "4"; ///error al guardar
        }
        
    }            
} else {
    if ($_POST['tipo'] == "m") {        
        $repetidos = repetidos($conexion, "nombre_ciudad", ucwords(strtolower($_POST['txt_3'])), "ciudad", "m", $_POST['txt_0'], 'id_ciudad' , "id_provincia", $_POST['txt_2']);                    
        if ($repetidos == 'true') {
            $data = "2"; /// este dato ya existe;
        } else {            
            $sql_anterior = "select (id_ciudad,nombre_ciudad,id_provincia) from ciudad where id_ciudad = '".$_POST['txt_0']."'";
            $sql_anterior = sql_array($conexion,$sql_anterior);
            $sql = "update ciudad set nombre_ciudad= '" . ucwords(strtolower($_POST['txt_3'])) . "', id_provincia = '" . $_POST['txt_2'] . "' where id_ciudad = '".$_POST['txt_0']."'";            
            $guardar = guardarSql($conexion, $sql);            
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_ciudad,nombre_ciudad,id_provincia) from ciudad where id_ciudad = '".$_POST['txt_0']."'";      
                $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                auditoria_sistema($conexion,'ciudad',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla ciudad");                        
                $data = "3";
            }else{
                $data = '4';
            }            
        }
    }
}
echo $data;
?>

