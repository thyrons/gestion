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
    if($_GET['fn'] == '1'){
        $sql = "select referencia,peso,tipo from bitacora where id_bitacora = '".$_GET['id']."'";        
    }else{
        $sql = "select referencia,peso,tipo from bitacora where id_archivo = '".$_GET['id']."' order by fecha_cambios desc limit 1";
    }
    
    $resp = datos_descarga($conexion,$sql,3);        
    print_r($resp);
    if($resp != ''){
        $ruta = '../archivos/'.$resp[0];                
        download_file($ruta, $resp[0],$resp[1],$resp[2]);
        $data = 0;
    }else{
        $data = 0;
    }    
?>

