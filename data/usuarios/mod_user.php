<?php
include '../conexion.php';
include '../funciones_generales.php';
$conexion = conectarse();
date_default_timezone_set('America/Guayaquil');
$fecha = date('Y-m-d H:i:s', time());
$fecha_larga = date('His', time());
$sql = "";

//echo base64_encode("admin");
$data = 0;
if ($_POST['name'] == "txt_1_mod") {                    
    $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
    $sql_anterior = sql_array($conexion,$sql_anterior);
    $sql = "update usuario set nro_documento = '" . $_POST['value'] ."' where id_usuario = '".$_GET['id']."'";
    $guardar = guardarSql($conexion, $sql);     
    if($guardar == 'true'){     
        $data = '1';
    }else{
        $data = '2';
    }
    $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
    auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                       
}else{
    if ($_POST['name'] == "txt_2_mod") {                    
        $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
        $sql_anterior = sql_array($conexion,$sql_anterior);
        $sql = "update usuario set tipo_documento = '" . $_POST['value'] ."' where id_usuario = '".$_GET['id']."'";
        $guardar = guardarSql($conexion, $sql);     
        if($guardar == 'true'){     
            $data = '1';
        }else{
            $data = '2';
        }
        $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
        $sql_nuevo = sql_array($conexion,$sql_nuevo); 
        auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                       
    }else{
        if ($_POST['name'] == "txt_3_mod") {                    
            $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
            $sql_anterior = sql_array($conexion,$sql_anterior);
            $sql = "update usuario set nombres_usuario = '" . $_POST['value'] ."' where id_usuario = '".$_GET['id']."'";
            $guardar = guardarSql($conexion, $sql); 
            if($guardar == 'true'){     
                $data = '1';
            }else{
                $data = '2';
            }
            $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
            $sql_nuevo = sql_array($conexion,$sql_nuevo); 
            auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                       
        }else{
            if ($_POST['name'] == "txt_4_mod") { 
                $repetidos = repetidos($conexion, "usuario", strtolower($_POST['value']), "usuario", "m", $_GET['id'], 'id_usuario', "", "");                    
                if ($repetidos == 'true') {
                    $data = "3"; /// este usuario ya existe;
                }else{                               
                    $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                    $sql_anterior = sql_array($conexion,$sql_anterior);
                    $sql = "update usuario set usuario = '" . $_POST['value'] ."' where id_usuario = '".$_GET['id']."'";
                    $guardar = guardarSql($conexion, $sql); 
                    if($guardar == 'true'){     
                        $data = '1';
                    }else{
                        $data = '2';
                    }
                    $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                    auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                                           
                }
            }else{
                if ($_POST['name'] == "txt_5_mod") {                    
                    $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                    $sql_anterior = sql_array($conexion,$sql_anterior);
                    $sql = "update usuario set telefono_usuario = '" . $_POST['value'] ."' where id_usuario = '".$_GET['id']."'";
                    $guardar = guardarSql($conexion, $sql);     
                    if($guardar == 'true'){     
                        $data = '1';
                    }else{
                        $data = '2';
                    }
                    $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                    auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                       
                }else{
                    if ($_POST['name'] == "txt_6_mod") {                    
                        $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                        $sql_anterior = sql_array($conexion,$sql_anterior);
                        $sql = "update usuario set celular_usuario = '" . $_POST['value'] ."' where id_usuario = '".$_GET['id']."'";
                        $guardar = guardarSql($conexion, $sql);     
                        if($guardar == 'true'){     
                            $data = '1';
                        }else{
                            $data = '2';
                        }
                        $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                        $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                        auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                       
                    }else{
                        if ($_POST['name'] == "txt_9_mod") {               
                            $arr = $_POST['value'];     
                            $ciudad = $arr['building'];
                            if($ciudad != ""){
                                $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                                $sql_anterior = sql_array($conexion,$sql_anterior);
                                $sql = "update usuario set id_ciudad = '" . $ciudad ."' where id_usuario = '".$_GET['id']."'";
                                $guardar = guardarSql($conexion, $sql);     
                                if($guardar == 'true'){     
                                    $data = '1';
                                }else{
                                    $data = '2';
                                }
                                $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                                $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                                auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                                                   
                            }else{
                                $data = '3';
                            }    
                        }else{
                            if ($_POST['name'] == "txt_10_mod") {                    
                                $sql_anterior = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                                $sql_anterior = sql_array($conexion,$sql_anterior);
                                $sql = "update usuario set direccion_usuario = '" . $_POST['value'] ."' where id_usuario = '".$_GET['id']."'";
                                $guardar = guardarSql($conexion, $sql); 
                                if($guardar == 'true'){     
                                    $data = '1';
                                }else{
                                    $data = '2';
                                }
                                $sql_nuevo = "select (id_usuario,cod_usuario,nombres_usuario,direccion_usuario,id_ciudad,telefono_usuario,celular_usuario,email_usuario,id_tipo_user,usuario,institucion,id_categoria,id_departamento,fecha,tipo_documento,nro_documento) from usuario where id_usuario = '".$_GET['id']."'";                
                                $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                                auditoria_sistema($conexion,'usuario',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla usuario");                                       
                            }else{
                                if ($_POST['name'] == "txt_1_clave") {                    
                                    echo $_POST['value_1'];
                                    $sql_anterior = "select (id_clave,clave,usuario) from clave where usuario = '".$_GET['id']."'";                
                                    $sql_anterior = sql_array($conexion,$sql_anterior);
                                    $sql = "update clave set clave = '" . $_POST['value_2'] ."' where usuario = '".$_GET['id']."'";                                    
                                    $guardar = guardarSql($conexion, $sql); 
                                    if($guardar == 'true'){     
                                        $data = '1';
                                    }else{
                                        $data = '2';
                                    }
                                    $sql_anterior = "select (id_clave,clave,usuario) from clave where usuario = '".$_GET['id']."'";                
                                    $sql_nuevo = sql_array($conexion,$sql_nuevo); 
                                    auditoria_sistema($conexion,'clave',$_GET['id'],'Update',$_GET['id'],$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,"Modificación del registro ".$_GET['id']." la tabla clave");                                       
                                }else{

                                }
                            }
                        }                                                     
                    }
                }
            }
        }
    }
}
echo $data;
?>

