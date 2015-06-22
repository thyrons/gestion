<?php
	include '../conexion.php';
	include '../funciones_generales.php';		
	$conexion = conectarse();
	//session_start();
	date_default_timezone_set('America/Guayaquil');
    $fecha=date('Y-m-d H:i:s', time()); 
    $fecha_larga = date('His', time()); 
	$sql = "";					
	//$id_user = id($conexion,'usuario','id_usuario');
	$data = existe($conexion,strtolower($_POST['txt_1']), strtolower($_POST['txt_2']));	
	//print_r($_SESSION);
	if( $data == '0'){				
		$id_session = sesion_activa();
    	auditoria_sistema($conexion,'usuario',$id_session,'Login','',$fecha_larga,$fecha,'','',"Ingreso al sistema por el usuario ".$_SESSION['usuario_gestion']."");		    	
	}	
	echo $data;
	

?>