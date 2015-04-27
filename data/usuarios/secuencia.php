<?php
	include '../conexion.php';
	include '../funciones_generales.php';		
	$conexion = conectarse();
	$sql = "";
	$lista1 = array();
	$id_tabla = '';
	if($_GET['fn'] == '0'){//function atras
		if($_GET['id'] == ''){///si exsite un id previo
			$sql = "select id_usuario from usuario order by id_usuario desc limit 1";
			$id_tabla = obtener_id($conexion, $sql);			
		}else{
			$sql = "select id_usuario from usuario where id_usuario not in (select id_usuario from usuario where id_usuario >= '". $_GET['id'] ."' order by id_usuario desc) order by id_usuario desc limit 1";
			$id_tabla = obtener_id($conexion, $sql);			
		}
		$sql = "select id_usuario,cod_usuario,nombres_usuario,direccion_usuario,usuario.id_ciudad, nombre_ciudad, provincias.id_provincia, nombre_provincia, pais.id_pais, nombre_pais,telefono_usuario,celular_usuario,email_usuario,usuario.id_tipo_user,nombre_tipo,usuario.usuario,institucion,usuario.id_categoria,nombre_categoria,usuario.id_departamento,nombre_departamento,fecha,tipo_documento,nro_documento,clave from usuario,ciudad,provincias,pais,tipo_usuario,categorias,departamento,clave where usuario.id_ciudad = ciudad.id_ciudad and provincias.id_provincia = ciudad.id_provincia and provincias.id_pais = pais.id_pais and tipo_usuario.id_tipo_usuario = usuario.id_tipo_user and usuario.id_categoria = categorias.id_categoria and departamento.id_departamento = usuario.id_departamento and usuario.id_usuario = clave.usuario and usuario.id_usuario = '". $id_tabla ."'";			
		$lista1=array(atras_adelente($conexion,$sql)); 		
		$data = (json_encode($lista1));
		echo $data;
	}else{
		if($_GET['fn'] == '1'){//function adelante
			if($_GET['id'] == ''){///si exsite un id previo
				$sql = "select id_usuario from usuario order by id_usuario desc limit 1";				
				$id_tabla = obtener_id($conexion, $sql);			
			}else{
				$sql = "select id_usuario from usuario where id_usuario not in (select id_usuario from usuario where id_usuario <= '". $_GET['id'] ."' order by id_usuario asc) order by id_usuario asc limit 1";				
				$id_tabla = obtener_id($conexion, $sql);			
			}
			$sql = "select id_usuario,cod_usuario,nombres_usuario,direccion_usuario,usuario.id_ciudad, nombre_ciudad, provincias.id_provincia, nombre_provincia, pais.id_pais, nombre_pais,telefono_usuario,celular_usuario,email_usuario,usuario.id_tipo_user,nombre_tipo,usuario.usuario,institucion,usuario.id_categoria,nombre_categoria,usuario.id_departamento,nombre_departamento,fecha,tipo_documento,nro_documento,clave from usuario,ciudad,provincias,pais,tipo_usuario,categorias,departamento,clave where usuario.id_ciudad = ciudad.id_ciudad and provincias.id_provincia = ciudad.id_provincia and provincias.id_pais = pais.id_pais and tipo_usuario.id_tipo_usuario = usuario.id_tipo_user and usuario.id_categoria = categorias.id_categoria and departamento.id_departamento = usuario.id_departamento and usuario.id_usuario = clave.usuario and usuario.id_usuario = '". $id_tabla ."'";			
			$lista1=array(atras_adelente($conexion,$sql)); 		
			$data = (json_encode($lista1));
			echo $data;
		}	
	}

?>