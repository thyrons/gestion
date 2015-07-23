<?php

include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";
$cont = 0;
$id_user = sesion_activa();
$data = 0;
$permisos = explode(",", $_POST['permisos']);

$sql = "select id_acceso,estado from accesos where id_usuario = '".$_POST['user']."' order by id_acceso asc";
$sql = pg_query($conexion, $sql);
while($row = pg_fetch_row($sql)){
    $sql_1 = "update accesos set estado = '".$permisos[$cont]."' where id_acceso = '".$row[0]."'";        
    $guardar = guardarSql($conexion, $sql_1);
    $sql_nuevo = "select (id_acceso,id_usuario,id_aplicacion,estado) from accesos where id_acceso = '".$row[0]."'";                   
    $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
    auditoria_sistema($conexion,'accesos',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,'','Modificación del permiso del usuario');
    $data = 1;
    $cont++;
}
echo $data;
?>

