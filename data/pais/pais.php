<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

$id = id($conexion,'pais','id_pais');
$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {    
    $repetidos = repetidos($conexion, "nombre_pais", ucwords(strtolower($_POST['txt_2'])), "pais", "g", "", "", "","");
    if ($repetidos == 'true') {
        $data = "2"; /// este nombre ya existe;
    } else {
        $sql = "insert into pais values ('".$id."','" . $_POST['txt_1'] . "','" . ucwords(strtolower($_POST['txt_2'])) . "')";
        $guardar = guardarSql($conexion, $sql);
        if($guardar == 'true'){                
            $sql_nuevo = "select (id_pais,codigo_pais,nombre_pais) from pais where id_pais = '$id'";        
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'pais',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla pais');
            $data = "3";//guardado    
        }else{
            $data = "4"; ///error al guardar
        }
        
    }            
} else {
    if ($_POST['tipo'] == "m") {        
        $repetidos = repetidos($conexion, "nombre_pais", ucwords(strtolower($_POST['txt_2'])), "pais", "m", $_POST['txt_0'], 'id_pais', "", "");                    
        if ($repetidos == 'true') {
            $data = "2"; /// este dato ya existe;
        } else {            
            $sql_anterior = "select (id_pais,codigo_pais,nombre_pais) from pais where id_pais = '".$_POST['txt_0']."'";        
            $sql_anterior = sql_array($conexion,$sql_anterior);
            $sql = "update pais set codigo_pais = '" . $_POST['txt_1'] . "', nombre_pais= '" . ucwords(strtolower($_POST['txt_2'])) . "' where id_pais = '".$_POST['txt_0']."'";            
            $guardar = guardarSql($conexion, $sql);            
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_pais,codigo_pais,nombre_pais) from pais where id_pais = '".$_POST['txt_0']."'";      
                $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                auditoria_sistema($conexion,'pais',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla pais");                        
                $data = "3";
            }else{
                $data = '4';
            }            
        }
    }
}
echo $data;
?>

