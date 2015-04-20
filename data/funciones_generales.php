<?php
	date_default_timezone_set('America/Guayaquil'); 
	$fecha = date('Y-m-d H:i:s', time());   
	$fecha_larga = date('His', time());

	function sesion_activa(){	  
		session_start();          
	    return $_SESSION['id_gestion'];
	}
	function guardarSql($conexion, $sql) {
	    $resp = true;    
	    if (pg_query($conexion, $sql)) {
	        $resp = 'true';
	    } else {
	        $resp = 'false';
	    }
	    return $resp;
	}
	function cargarSelect($conexion, $sql, $tam) {
	    $lista = array();
	    $data = 0;
	    $sql = pg_query($conexion, $sql);
	    if ($sql) {
	        while ($row = pg_fetch_row($sql)) {
	            for($i = 0; $i < $tam; $i++){
	            	$lista[] = $row[$i];	            
	            }
	        }
	        echo $lista = json_encode($lista);
	    }
	}


	function id ($conexion,$tabla,$id){
		$contador = 0;
		$sql = "select max(".$id.") from ".$tabla."";		
		$sql = pg_query($conexion,$sql);
		$contador = pg_fetch_result($sql, 0);		
		$contador = $contador + 1;
		return $contador;
	}

	function existe($conexion,$usuario,$clave){
		$resp = '0';
		$id_clave = '';
		$id_user = '';
		$user = '';
		$nombres = '';
		$pass = '';
		$fecha_login = '';
		$sql = "select id_usuario,nombres_usuario,usuario,fecha from usuario where usuario = '".$usuario."'";
		$sql = pg_query($conexion,$sql);
		if(pg_num_rows($sql)){			
			while($row = pg_fetch_row($sql)){
				$id_user = $row[0];
				$nombres = $row[1];
				$user = $row[2];
				$fecha_login = $row[3];
			}
			$sql_1 = "select id_clave,clave from clave where usuario = '".$id_user."'";			
			$sql_1 = pg_query($conexion,$sql_1);			
			while($row_1 = pg_fetch_row($sql_1)){
				$pass = $row_1[1];
				$id_clave = $row_1[0];				
			}			
			if(md5($clave) == $pass){
				$resp = '0'; ////ingreso				
				//session_start();        
				$_SESSION['id_gestion'] = $id_user;
				$_SESSION['nombres'] = $nombres;
				$_SESSION['usuario'] = $user;				
				$_SESSION['fecha'] = $fecha_login;	
			}else{
				$resp = '2'; ///clave incorrecta
			}
		}else{
			$resp = '1'; //no existe el usuario
		}
	return $resp;
	}

	function repetidos($conexion, $campo, $valor, $tabla, $tipo, $id, $id_campo, $id_extra) {///conexion,campo a comparar,valor campo,tabla,tipo g o m id si tiene, id campo si tiene
	    $repetidos = 'true';
	    if ($tipo == "g") {
	        $sql = "select " . $campo . " from " . $tabla . " where " . $campo . " = '" . $valor . "'";
	        if (pg_num_rows(pg_query($conexion, $sql))) {
	            $repetidos = 'true';
	        } else {
	            $repetidos = 'false';
	        }
	    } else {
	        if ($tipo == "m") {
	            $sql = "select " . $campo . " from " . $tabla . " where " . $campo . " = '" . $valor . "' and " . $id_campo . " not in ('$id') ";
	            if (pg_num_rows(pg_query($conexion, $sql))) {
	                $repetidos = 'true';
	            } else {
	                $repetidos = 'false';
	            }
	        } else {
	            if ($tipo == "gr") {///comparar con campo especifico
	                $sql = "select " . $campo . " from " . $tabla . " where " . $campo . " = '" . $valor . "' and codigo_barras != ''";
	                if (pg_num_rows(pg_query($conexion, $sql))) {
	                    $repetidos = 'true';
	                } else {
	                    $repetidos = 'false';
	                }
	            }else{
	                if ($tipo == "mr") {
	                    $sql = "select " . $campo . " from " . $tabla . " where " . $campo . " = '" . $valor . "' and codigo_barras != '' and " . $id_campo . " not in ('$id') " ;
	                    
	                    if (pg_num_rows(pg_query($conexion, $sql))) {
	                        $repetidos = 'true';
	                    } else {
	                        $repetidos = 'false';
	                    }
	                }
	            }    
	        }
	    }
	    return $repetidos;
	}

	function auditoria_sistema($conexion,$tabla,$id_user,$proceso,$id_registro,$fecha_larga,$fecha,$sql_nuevo,$sql_anterior,$comentario){
	    $cliente = $_SERVER['REMOTE_ADDR'];
	    $server = $_SERVER['SERVER_ADDR'];
	    $id_tabla = id($conexion,'auditoria_sistema','id_sistema');///
	    if($proceso == 'Insert'){                
	    	$consulta = "insert into auditoria_sistema values ('".$id_tabla."','".$id_user."','".$tabla."','".$proceso."',array[''],$sql_nuevo::text[],'".$id_registro."','".$cliente."','".$server."','".$fecha."','".$comentario."','0')";                       	            			            			        	        
	        pg_query($consulta);               
	    }else{
	        if($proceso == 'Update'){      
		        $consulta = "insert into auditoria_sistema values ('".$id_tabla."','".$id_user."','".$tabla."','".$proceso."',$sql_anterior::text[],$sql_nuevo::text[],'".$id_registro."','".$cliente."','".$server."','".$fecha."','".$comentario."','0')";                       	            			            			        	          	            
	            pg_query($consulta);       
	        }else{            
	            if($proceso == 'Backup'){        
	            }else{
	            	if($proceso == 'Login'){        
	            		$consulta = "insert into auditoria_sistema values ('".$id_tabla."','".$id_user."','".$tabla."','".$proceso."',array[''],array[''],'".$id_registro."','".$cliente."','".$server."','".$fecha."','".$comentario."','0')";                       	            			            		
	            		pg_query($consulta);       
	            	}
	            }               
	        }
	    }
	}
	function maxCaracter($texto, $cant){        
    	$texto = substr($texto, 0,$cant);
    	return $texto;
	}
	function sql_array($conexion,$sql){        
	    $sql = pg_fetch_row(pg_query($sql));                                 
	    $sql = "array['".implode("', '", $sql)."']";   
	    return $sql;     
	}
?>
