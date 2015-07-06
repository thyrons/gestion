<?php

    include '../conexion.php';
    include '../funciones_generales.php';
    $conexion = conectarse();
    date_default_timezone_set('America/Guayaquil');
    $fecha = date('Y-m-d H:i:s', time());
    $fecha_doc = date('Y-m-d', time());
    $fecha_larga = date('His', time());
    $sql = "";
    $data = 0;
    $id_user = sesion_activa();        
    if($_GET['fn'] == '1'){        
        $sql_anterior = "select (id_archivo,nombre_archivo,codigo_archivo,origen,fuente_usuario,fecha_creacion,estado) from archivo where id_archivo = '".$_GET['id']."'";
        $sql_anterior = sql_array($conexion,$sql_anterior);
        $sql = "update archivo set estado = 0 where id_archivo = '".$_GET['id']."'";        
    }
    $guardar = guardarSql($conexion, $sql);
     if($guardar == 'true'){            
        $sql_nuevo = "select (id_archivo,nombre_archivo,codigo_archivo,origen,fuente_usuario,fecha_creacion,estado) from archivo where id_archivo = '".$_GET['id']."'";
        $sql_nuevo = sql_array($conexion,$sql_nuevo); 
        auditoria_sistema($conexion,'archivo',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." de la tabla archivo realizado por el administrador");                        
                        
        $data = 0;
    }else{
        $data = 1;
    }        
    echo $data;    
?>

