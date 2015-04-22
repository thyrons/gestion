<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

$id = id($conexion,'categorias','id_categoria');
$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {    
    $repetidos = repetidos($conexion, "codigo_categoria", strtoupper($_POST['txt_1']), "categorias", "g", "", "", "","");
    if ($repetidos == 'true') {
        $data = "1"; /// este código ya existe;
    }else{
        $repetidos = repetidos($conexion, "nombre_categoria", ucwords(strtolower($_POST['txt_2'])), "categorias", "g", "", "", "","");
        if ($repetidos == 'true') {
            $data = "2"; /// este nombre ya existe;
        } else {
            $sql = "insert into categorias values ('".$id."','" . ucwords(strtolower($_POST['txt_2'])) . "','" . strtoupper($_POST['txt_1']) . "','0')";
            $guardar = guardarSql($conexion, $sql);
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_categoria,nombre_categoria,codigo_categoria,estado) from categorias where id_categoria = '$id'";        
                $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                auditoria_sistema($conexion,'categorias',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla categorias');
                $data = "3";//guardado    
            }else{
                $data = "4"; ///error al guardar
            }            
        }            
    }    
}else {
    if ($_POST['tipo'] == "m") {        
        $repetidos = repetidos($conexion, "codigo_categoria", strtoupper($_POST['txt_1']), "categorias", "m", $_POST['txt_0'], 'id_categoria', "", "");                    
        if ($repetidos == 'true') {
            $data = "1"; /// este codigo ya existe;
        }else{
            $repetidos = repetidos($conexion, "nombre_categoria", ucwords(strtolower($_POST['txt_2'])), "categorias", "m", $_POST['txt_0'], 'id_categoria', "", "");                    
            if ($repetidos == 'true') {
                $data = "2"; /// este dato ya existe;
            } else {            
                $sql_anterior = "select (id_categoria,nombre_categoria,codigo_categoria,estado) from categorias where id_categoria = '".$_POST['txt_0']."'";        
                $sql_anterior = sql_array($conexion,$sql_anterior);
                $sql = "update categorias set codigo_categoria = '" . strtoupper($_POST['txt_1']) . "', nombre_categoria= '" . ucwords(strtolower($_POST['txt_2'])) . "' where id_categoria = '".$_POST['txt_0']."'";            
                $guardar = guardarSql($conexion, $sql);            
                if($guardar == 'true'){                
                    $sql_nuevo = "select (id_categoria,nombre_categoria,codigo_categoria,estado) from categorias where id_categoria = '".$_POST['txt_0']."'";      
                    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                    auditoria_sistema($conexion,'categorias',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla categorias");                        
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

