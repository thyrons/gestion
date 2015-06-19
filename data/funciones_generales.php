<?php
	session_start();  
	date_default_timezone_set('America/Guayaquil'); 
	$fecha = date('Y-m-d H:i:s', time());   
	$fecha_larga = date('His', time());	
	
	function sesion_activa(){	  		        
	    return $_SESSION['id_gestion'];
	}

	function cargarTablaUsusariosRecibidos($conexion, $sql,$tam){
		$lista = array();
		$nombres = array();
		$sql = pg_query($conexion, $sql);
		$cont = 0;
		while($row = pg_fetch_row($sql)){
			$usuarios =$row[0];				
		}	
		$usuarios = str_replace('{"', "", $usuarios);
		$usuarios = str_replace('"}', "", $usuarios);		
		$usuarios = str_replace('{', "", $usuarios);
		$usuarios = str_replace('}', "", $usuarios);		
		$lista = explode(",", $usuarios);												
		for($i = 0; $i < count($lista); $i++){			
			$sql = "select nombres_usuario from usuario where id_usuario = $lista[$i]";			
			$sql = pg_query($sql);
			while ($row = pg_fetch_row($sql)) {	        					
				$nombres[$cont] = $row[0];
				$cont++;
			}
		}			
		echo $nombres = json_encode($nombres);		
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
	function cargarTabla($conexion, $sql, $tam) {
	    $lista = array();
	    $data = 0;
	    $sql = pg_query($conexion, $sql);	    	    	    
	    if ($sql) {
	    	$cont = pg_num_rows($sql);
	        while ($row = pg_fetch_row($sql)) {
	            for($i = 0; $i < $tam; $i++){
	            	$lista[] = $row[$i];	            
	            }
	        }
	        $lista=array("cont" => $cont, "cuerpo" => $lista); 
	        echo $lista = json_encode($lista);
	    }
	}
	function datos_descarga($conexion, $sql, $tam) {
	    $lista = array();
	    $data = 0;
	    $sql = pg_query($conexion, $sql);	    	    	    
	    if ($sql) {
	    	$cont = pg_num_rows($sql);
	        while ($row = pg_fetch_row($sql)) {
	            for($i = 0; $i < $tam; $i++){
	            	$lista[] = $row[$i];	            
	            }
	        }	        
	        return $lista;
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
		$departamento = '';
		$sql = "select id_usuario,nombres_usuario,usuario,fecha,id_tipo_user,id_departamento from usuario where usuario = '".$usuario."'";
		$sql = pg_query($conexion,$sql);
		if(pg_num_rows($sql)){			
			while($row = pg_fetch_row($sql)){
				$id_user = $row[0];
				$nombres = $row[1];
				$user = $row[2];
				$fecha_login = $row[3];
				$tipo_user = $row[4];
				$departamento = $row[5];

			}
			$sql_1 = "select id_clave,clave from clave where usuario = '".$id_user."'";			
			$sql_1 = pg_query($conexion,$sql_1);			
			while($row_1 = pg_fetch_row($sql_1)){
				$pass = $row_1[1];
				$id_clave = $row_1[0];				
			}			
			if(base64_encode($clave) == $pass){
				$resp = '0'; ////ingreso				
				//session_start();        
				$_SESSION['id_gestion'] = $id_user;
				$_SESSION['nombres_gestion'] = $nombres;
				$_SESSION['usuario_gestion'] = $user;				
				$_SESSION['fecha_gestion'] = $fecha_login;	
				$_SESSION['tipo_user'] = $tipo_user;	
				$_SESSION['departamento'] = $departamento;	
			}else{
				$resp = '2'; ///clave incorrecta
			}
		}else{
			$resp = '1'; //no existe el usuario
		}
	return $resp;
	}

	function repetidos($conexion, $campo, $valor, $tabla, $tipo, $id, $id_campo, $id_extra, $valor_extra) {///conexion,campo a comparar,valor campo,tabla,tipo g o m id si tiene, id campo si tiene
	    $repetidos = 'true';
	    if ($tipo == "g") {
	        $sql = "select " . $campo . " from " . $tabla . " where " . $campo . " = '" . $valor . "'";
	        //echo $sql;
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
	            if ($tipo == "gr") {///comparar con campo especifico con relacion en otra tabla con valor
	            	$sql = "select " . $campo . " from " . $tabla . " where " . $campo . " = '" . $valor . "' and  " . $id_extra . " = '" . $valor_extra . "'";	            						
	                //echo $sql;
	                if (pg_num_rows(pg_query($conexion, $sql))) {
	                    $repetidos = 'true';
	                } else {
	                    $repetidos = 'false';
	                }
	            }else{
	                if ($tipo == "mr") {///comparar con campo especifico con relacion en otra tabla con valor
	                    $sql = "select " . $campo . " from " . $tabla . " where " . $campo . " = '" . $valor . "' and " . $id_campo . " not in ('$id') and " . $id_extra . " = ('".$valor_extra."');";	                    
	                    //echo $sql;
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
		//echo $sql;
	    $sql = pg_fetch_row(pg_query($sql));                                 
	    $sql = "array['".implode("', '", $sql)."']";   	    
	    return $sql;     
	}
	function atras_adelente($conexion,$sql){     
	    $sql = pg_query($sql);
	    $sql = pg_fetch_row($sql);
	    return $sql;
	}
	function is_base64($s){    
	    if (!preg_match('/^[a-zA-Z0-9\/\r\n+]*={0,2}$/', $s)) 
	        return false;
	    
	    $decoded = base64_decode($s, true);
	    if(false === $decoded) 
	        return false;
	    
	    if(base64_encode($decoded) != $s) 
	        return false;

	    return true;
	}
	function obtener_id($conexion, $sql) { //retorna el id de una consulta con solo un parametro de retorno en el sql
	    $id = 0;
	    $sql = pg_query($conexion, $sql);
	    while ($row = pg_fetch_row($sql)) {
	        $id = $row[0];
	    }
	    return $id;
	}
	function nro_rows($conexion, $sql) { //retorna el id de una consulta con solo un parametro de retorno en el sql
	    $total = 0;	    
	    $sql = pg_query($conexion, $sql);
	    $total = pg_num_rows($sql);
	    echo $total;
	}

	function download_file($archivo,$referencia,$peso,$tipo) {				
	    if (file_exists($archivo)) {	        
	        header("Cache-control: private");
			header("Content-type: $tipo");

			header("Content-Disposition: attachment; filename=\"$referencia\"");
			header("Content-length: $peso");
			header("Expires: ".gmdate("D, d M Y H:i:s", mktime(date("H")+2, date("i"), date("s"), date("m"), date("d"), date("Y")))." GMT");
			header("Last-Modified: ".gmdate("D, d M Y H:i:s")." GMT");
			header("Cache-Control: no-cache, must-revalidate");
			header("Pragma: no-cache");

	        ob_clean();
	        flush();
	        readfile($archivo);
	        exit;
	        $data = 0;
	    }
	}
?>
