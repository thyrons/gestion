<?php
include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

//echo base64_encode("admin");


$id = id($conexion,'usuario','id_usuario');
$id_clave = id($conexion,'clave','id_clave');

$user_adm = array();
$user_reg = array();
$permisos = array();
$user_adm =  array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
$user_reg =  array(0,0,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1);


$id_user = sesion_activa();
if ($_POST['tipo'] == "g") {    
    $codigo=$_POST['txt_3']{0}."".$_POST['txt_11']{0}."".$_POST['txt_12']{0}."".$id;
    $repetidos = repetidos($conexion, "usuario", strtolower($_POST['txt_13']), "usuario", "g", "", "", "","");
    if ($repetidos == 'true') {
        $data = "1"; /// este USUARIO ya existe;
    }else{                
        $sql = "insert into usuario values ('".$id."','".  strtoupper($codigo) ."','" . ucwords(strtolower($_POST['txt_3'])) . "','". $_POST['txt_9'] ."', '". $_POST['txt_6'] ."', '". $_POST['txt_7'] ."','". $_POST['txt_8'] ."','". $_POST['txt_17'] ."','". $_POST['txt_10'] ."','". strtolower($_POST['txt_13']) ."','". $_POST['txt_16'] ."','". $_POST['txt_11'] ."','". $_POST['txt_12'] ."','". $fecha ."','". $_POST['txt_1'] ."', '". $_POST['txt_2'] ."')";
        $guardar = guardarSql($conexion, $sql);
        if($guardar == 'true'){     
            $sql = "insert into clave values ('".$id."','". base64_encode($_POST['txt_14']) ."','". $id ."')";            
            $guardar = guardarSql($conexion, $sql);
            $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '$id'";                    
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'usuario',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla usuario');
            
            ////////////////
            $sql_nuevo = "select (id_clave,clave,usuario) from clave where id_clave = '$id_clave'";        
            $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
            auditoria_sistema($conexion,'clave',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Inserción de datos en la tabla usuario');            
            $data = "3";//guardado    
            ////////////////permisos del usaurio///
            if($_POST["txt_10"] == 1){
                $permisos = $user_adm;
            }else{
                $permisos = $user_reg;
            }
            for($i = 0; $i < sizeof($permisos); $i++){    
                $id_acceso = id($conexion,'accesos','id_acceso');            
                $sql = "insert into accesos values ('".$id_acceso."','". $id ."','". ($i + 1) ."','".$permisos[$i]."')";                
                $guardar = guardarSql($conexion, $sql);
                $sql_nuevo = "select (id_acceso,id_usuario,id_aplicacion,estado) from accesos where id_acceso = '$id_acceso'";                    
                $sql_nuevo = sql_array($conexion,$sql_nuevo);                                  
                auditoria_sistema($conexion,'accesos',$id_user,'Insert',$id,$fecha_larga,$fecha,$sql_nuevo,'','Creacion de los permisos para el usuario');

            }
            //////////////////////////////////////            
        }else{
            $data = "4"; ///error al guardar
        }                                
    }    
}else {
    if ($_POST['tipo'] == "m") {                
        $repetidos = repetidos($conexion, "usuario", strtolower($_POST['txt_13']), "usuario", "m", $_POST['txt_0'], 'id_usuario', "", "");                    
        if ($repetidos == 'true') {
            $data = "1"; /// este codigo ya existe;
        }else{            
            $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_POST['txt_0']."'";                
            $sql_anterior = sql_array($conexion,$sql_anterior);
            $sql = "update usuario set nombres_usuario = '" . ucwords(strtolower($_POST['txt_3'])) ."',direccion_usuario = '" . $_POST['txt_9'] ."',id_ciudad = '" . $_POST['txt_6'] ."',telefono_usuario = '" . $_POST['txt_7'] ."',celular_usuario = '" . $_POST['txt_8'] ."',email_usuario = '" . $_POST['txt_17'] ."',id_tipo_user = '" . $_POST['txt_10'] ."',usuario = '" . strtolower($_POST['txt_13']) ."',institucion = '" . $_POST['txt_16'] ."',id_categoria = '" . $_POST['txt_11'] ."',id_departamento = '" . $_POST['txt_12'] ."',tipo_documento = '" . $_POST['txt_1'] ."',nro_documento = '" . $_POST['txt_2'] ."' where id_usuario = '".$_POST['txt_0']."'";
            $guardar = guardarSql($conexion, $sql);            
            if($guardar == 'true'){                
                $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_POST['txt_0']."'";                
                $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                auditoria_sistema($conexion,'usuario',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla usuario");                        
                ////////////////////////

                if(is_base64($_POST['txt_14']) == 1){

                }else{                    
                    $sql_nuevo = "select (id_clave,clave,usuario) from clave where usuario = '". $_POST['txt_0'] ."'";                            
                    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                    $sql = "update clave set clave = '". base64_encode($_POST['txt_14'])."' where usuario = '".$_POST['txt_0']."'";                    
                    $guardar = guardarSql($conexion, $sql);                                                    
                    $sql_anterior = "select (id_clave,clave,usuario) from clave where usuario = '". $_POST['txt_0'] ."'";                    
                    $sql_anterior = sql_array($conexion,$sql_anterior); 
                    auditoria_sistema($conexion,'clave',$id_user,'Update',$id,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_POST['txt_0']." la tabla clave");                        
                }
                
                $data = "3";
            }else{
                $data = '4';            
            }
        }
    }
}
echo $data;
?>

