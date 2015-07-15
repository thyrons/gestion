<?php
	session_start();
	error_reporting(0);  
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
		$cargo = '';
		$depart = '';
		$sql = "select id_usuario,nombres_usuario,usuario,fecha,id_tipo_user,usuario.id_departamento,nombre_tipo,nombre_departamento from usuario,tipo_usuario,departamento where usuario.id_tipo_user = tipo_usuario.id_tipo_usuario and usuario.id_departamento = departamento.id_departamento and usuario = '".$usuario."'";
		$sql = pg_query($conexion,$sql);
		if(pg_num_rows($sql)){			
			while($row = pg_fetch_row($sql)){
				$id_user = $row[0];
				$nombres = $row[1];
				$user = $row[2];
				$fecha_login = $row[3];
				$tipo_user = $row[4];
				$departamento = $row[5];
				$cargo = $row[6];
				$depart = $row[7];

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
				if(isset($_SESSION['id_gestion'])){
					$resp = '3';///session existente
				}else{
					$_SESSION['id_gestion'] = $id_user;
					$_SESSION['nombres_gestion'] = $nombres;
					$_SESSION['usuario_gestion'] = $user;				
					$_SESSION['fecha_gestion'] = $fecha_login;	
					$_SESSION['tipo_user'] = $tipo_user;	
					$_SESSION['departamento'] = $departamento;	
					$_SESSION['cargo'] = $cargo;	
					$_SESSION['depart'] = $depart;	
				}				

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
	function buscador_texto($conexion,$sub,$texto){
		$lista = array();
		$t_user = $_SESSION['tipo_user'];		
		if($t_user == '1'){
			$sql = "select id_archivo,nombre_archivo,fecha_creacion,estado from archivo order by fecha_creacion asc";										
		}else{
			$sql = "select id_archivo,nombre_archivo,fecha_creacion from archivo where fuente_usuario = '".sesion_activa()."' order by fecha_creacion desc";				
		}
		$sql = pg_query($conexion, $sql);
		while($row = pg_fetch_row($sql)){
			if($sub == true){
				$sql_1 = "select bitacora.id_bitacora,bitacora.id_archivo,bitacora.fecha_cambios,fuente_usuario,nombres_usuario,nombre_archivo,asunto_cambio,referencia from archivo, bitacora, usuario where archivo.id_archivo = bitacora.id_archivo and archivo.fuente_usuario = usuario.id_usuario and archivo.id_archivo = '".$row[0]."' order by fecha_cambios desc";				
			}else{
				$sql_1 = "select bitacora.id_bitacora,bitacora.id_archivo,bitacora.fecha_cambios,fuente_usuario,nombres_usuario,nombre_archivo,asunto_cambio,referencia from archivo, bitacora, usuario where archivo.id_archivo = bitacora.id_archivo and archivo.fuente_usuario = usuario.id_usuario and archivo.id_archivo = '".$row[0]."' order by fecha_cambios desc limit 1";				
			}
			$sql_1 = pg_query($conexion, $sql_1);
			while($row_1 = pg_fetch_row($sql_1)){				
				if($row_1[7] == ''){

				}
				else{
					$document = "archivos/".$row_1[7];                     
		            $ext = end(explode('.', $document));                 	                	                	            
		            $resp=buscar_text($ext,$document);      	                      
		            if(preg_match("/".$texto."/i", $resp))     
		            {         
		                $lista[]=$row[0];  
		                $lista[]=$row[1];                       
		                $lista[]=$row[2];                                                    
		                $lista[]=$row_1[0];           
		                $lista[]=$row_1[4];         
		                $lista[]=$row_1[5];         
		                $lista[]=$row_1[7];         
		                $lista[]=$row_1[6];
		                $lista[]=$row_1[2];
		                $lista[]=$row[3];  
		            }	
				}
			}
		}
		echo $lista=json_encode($lista);  
	}
	function buscar_text($ext,$document){  			
	    if($ext=='doc'){
	        doc_to_text($document);
	         $data= doc_to_text($document);       
	    }
	    else{
	        if($ext=='odt'){            
	            odt_to_text($document);
	            $data=odt_to_text($document);
	        }
	        else{
	            if($ext=='docx'){                
	                docx_to_text($document);
	                $data=docx_to_text($document);
	            }
	            else{
	                if($ext=='xlsx'){
	                    xlsx_to_text($document);
	                     $data=xlsx_to_text($document);
	                }
	                else{
	                    if($ext=='pptx'){
	                        pptx_to_text($document);
	                        $data=pptx_to_text($document);
	                    }
	                    else{/// si la extension puede ser txt o otras diferentes
	                        if($ext=='txt'){	                        	
	                            $data = file_get_contents($document);	                            
	                        }
	                        else{
	                            if($ext=='pdf'){
	                                include 'pdf2text.php';
	                                $data = pdf2text ($document);                                
	                            }
	                            else{	                            	
	                                $data = file_get_contents($document);
	                            }
	                        }    
	                    }
	                }   
	            }
	   
	        }
	    }
	    return $data;
	} 
	function doc_to_text($input_file){
	    $file_handle = fopen($input_file, "r"); //open the file
	    $stream_text = @fread($file_handle, filesize($input_file));
	    $stream_line = explode(chr(0x0D),$stream_text);
	    $output_text = "";
	    foreach($stream_line as $single_line){
	        $line_pos = strpos($single_line, chr(0x00));
	        if(($line_pos !== FALSE) || (strlen($single_line)==0)){
	            $output_text .= "";
	        }else{
	            $output_text .= $single_line." ";
	        }
	    }
	    $output_text = preg_replace("/[^a-zA-Z0-9\s\,\.\-\n\r\t@\/\_\(\)]/", "", $output_text);
	    return $output_text;
	}
	function odt_to_text($input_file){
	    $xml_filename = "content.xml"; //content file name
	    $zip_handle = new ZipArchive;
	    $output_text = "";
	    if(true === $zip_handle->open($input_file)){
	        if(($xml_index = $zip_handle->locateName($xml_filename)) !== false){
	            $xml_datas = $zip_handle->getFromIndex($xml_index);
	            $xml_handle = DOMDocument::loadXML($xml_datas, LIBXML_NOENT | LIBXML_XINCLUDE | LIBXML_NOERROR | LIBXML_NOWARNING);
	            $output_text = strip_tags($xml_handle->saveXML());
	        }else{
	            $output_text .="";
	        }
	        $zip_handle->close();
	    }else{
	    $output_text .="";
	    }
	    return $output_text;
	}
	 
	function docx_to_text($input_file){
	    $xml_filename = "word/document.xml"; //content file name
	    $zip_handle = new ZipArchive;
	    $output_text = "";
	    if(true === $zip_handle->open($input_file)){
	        if(($xml_index = $zip_handle->locateName($xml_filename)) !== false){
	            $xml_datas = $zip_handle->getFromIndex($xml_index);
	            $xml_handle = DOMDocument::loadXML($xml_datas, LIBXML_NOENT | LIBXML_XINCLUDE | LIBXML_NOERROR | LIBXML_NOWARNING);
	            $output_text = strip_tags($xml_handle->saveXML());
	        }else{
	            $output_text .="";
	        }
	        $zip_handle->close();
	    }else{
	    $output_text .="";
	    }
	    return $output_text;
	}
	 
	function pptx_to_text($input_file){
	    $zip_handle = new ZipArchive;
	    $output_text = "";
	    if(true === $zip_handle->open($input_file)){
	        $slide_number = 1; //loop through slide files
	        while(($xml_index = $zip_handle->locateName("ppt/slides/slide".$slide_number.".xml")) !== false){
	            $xml_datas = $zip_handle->getFromIndex($xml_index);
	            $xml_handle = DOMDocument::loadXML($xml_datas, LIBXML_NOENT | LIBXML_XINCLUDE | LIBXML_NOERROR | LIBXML_NOWARNING);
	            $output_text .= strip_tags($xml_handle->saveXML());
	            $slide_number++;
	        }
	        if($slide_number == 1){
	            $output_text .="";
	        }
	        $zip_handle->close();
	    }else{
	    $output_text .="";
	    }
	    return $output_text;
	}

	function xlsx_to_text($input_file){
	    $xml_filename = "xl/sharedStrings.xml"; //content file name
	    $zip_handle = new ZipArchive;
	    $output_text = "";
	    if(true === $zip_handle->open($input_file)){
	        if(($xml_index = $zip_handle->locateName($xml_filename)) !== false){
	            $xml_datas = $zip_handle->getFromIndex($xml_index);
	            $xml_handle = DOMDocument::loadXML($xml_datas, LIBXML_NOENT | LIBXML_XINCLUDE | LIBXML_NOERROR | LIBXML_NOWARNING);
	            $output_text = strip_tags($xml_handle->saveXML());
	        }else{
	            $output_text .="";
	        }
	        $zip_handle->close();
	    }else{
	    $output_text .="";
	    }
	    return $output_text;
	}

	function total_meses($conexion){
		$lista = array();
		$lista[0] = 0;		
		$lista[1] = 0;
		$lista[2] = 0;
		$lista[3] = 0;
		$lista[4] = 0;
		$lista[5] = 0;
		$lista[6] = 0;
		$lista[7] = 0;
		$lista[8] = 0;
		$lista[9] = 0;
		$lista[10] = 0;
		$lista[11] = 0;		

		$t_user = $_SESSION['tipo_user'];		
		if($t_user == '1'){
			$sql = "select date_part('year', w.fecha_creacion) as anio, date_part('month':: text, w.fecha_creacion) as mes, count(w.id_archivo) as total_mes from archivo w group by date_part('year', w.fecha_creacion), date_part('month'::text, w.fecha_creacion) order by 1,2";
		}else{
			$sql = "select date_part('year', w.fecha_creacion) as anio, date_part('month':: text, w.fecha_creacion) as mes, count(w.id_archivo) as total_mes from archivo w where fuente_usuario = '".sesion_activa()."' group by date_part('year', w.fecha_creacion), date_part('month'::text, w.fecha_creacion) order by 1,2";
		}
		$sql = pg_query($conexion, $sql);
		while($row = pg_fetch_row($sql)){
			if($row[1] == 1){
				$lista[0] = $row[2];		
			}
			if($row[1] == 2){
				$lista[1] = $row[2];		
			}
			if($row[1] == 3){
				$lista[2] = $row[2];		
			}
			if($row[1] == 4){
				$lista[3] = $row[2];		
			}
			if($row[1] == 5){
				$lista[4] = $row[2];		
			}
			if($row[1] == 6){
				$lista[5] = $row[2];		
			}
			if($row[1] == 7){
				$lista[6] = $row[2];		
			}
			if($row[1] == 8){
				$lista[7] = $row[2];		
			}
			if($row[1] == 9){
				$lista[8] = $row[2];		
			}
			if($row[1] == 10){
				$lista[9] = $row[2];		
			}
			if($row[1] == 11){
				$lista[10] = $row[2];		
			}
			if($row[1] == 12){
				$lista[11] = $row[2];		
			}
		}
		echo $lista = json_encode($lista);		
	}
	function total_meses_kbp($conexion){
		$lista = array();
		$lista[0] = 0;		
		$lista[1] = 0;
		$lista[2] = 0;
		$lista[3] = 0;
		$lista[4] = 0;
		$lista[5] = 0;
		$lista[6] = 0;
		$lista[7] = 0;
		$lista[8] = 0;
		$lista[9] = 0;
		$lista[10] = 0;
		$lista[11] = 0;		

		$t_user = $_SESSION['tipo_user'];		
		if($t_user == '1'){
			$sql = "select date_part('year', w.fecha_creacion) as anio, date_part('month':: text, w.fecha_creacion) as mes, sum(b.peso::float) as total_mes from archivo w, bitacora b where w.id_archivo = b.id_archivo group by date_part('year', w.fecha_creacion), date_part('month'::text, w.fecha_creacion) order by 1,2";
		}else{
			$sql = "select date_part('year', w.fecha_creacion) as anio, date_part('month':: text, w.fecha_creacion) as mes, sum(b.peso::float) as total_mes from archivo w, bitacora b where fuente_usuario = '".sesion_activa()."' and w.id_archivo = b.id_archivo group by date_part('year', w.fecha_creacion), date_part('month'::text, w.fecha_creacion) order by 1,2";
		}
		$sql = pg_query($conexion, $sql);
		while($row = pg_fetch_row($sql)){
			if($row[1] == 1){
				$lista[0] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 2){
				$lista[1] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 3){
				$lista[2] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 4){
				$lista[3] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 5){
				$lista[4] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 6){
				$lista[5] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 7){
				$lista[6] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 8){
				$lista[7] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 9){
				$lista[8] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 10){
				$lista[9] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 11){
				$lista[10] = number_format(($row[2]/1024/1024),5);
			}
			if($row[1] == 12){
				$lista[11] = number_format(($row[2]/1024/1024),5);
			}
		}
		echo $lista = json_encode($lista);		
	}
	function total_documentos($conexion){
		$dep = array();		
		$lista = array();		
		$t_user = $_SESSION['tipo_user'];		
		if($t_user == '1'){
			$sql = "select sum(b.peso::float) as total_mes, nombre_doc from archivo w, bitacora b, tipo_documento td where w.id_archivo = b.id_archivo and b.id_tipo_documento = td.id_tipo_documento group by nombre_doc order by 1,2";
		}else{
			$sql = "select sum(b.peso::float) as total_mes, nombre_doc from archivo w, bitacora b, tipo_documento td where fuente_usuario = '".sesion_activa()."' and w.id_archivo = b.id_archivo and b.id_tipo_documento = td.id_tipo_documento group by nombre_doc order by 1,2";
		}
		$sql = pg_query($conexion, $sql);
		while($row = pg_fetch_row($sql)){			
			$dep[] = $row[1];			
			$lista[] = number_format(($row[0]/1024/1024),5);			
		}
		$lista=array("departamento" => $dep, "peso" => $lista);  
		echo $lista = json_encode($lista);		
	}
	function total_estados($conexion){		
		$lista = array();		
		$t_user = $_SESSION['tipo_user'];		
		if($t_user == '1'){
			$sql = "select count(w.id_archivo) as total_mes, w.estado from archivo as w where estado = 0 group by  w.estado order by estado asc";
		}else{
			$sql = "select count(w.id_archivo) as total_mes, w.estado from archivo as w where fuente_usuario = '".sesion_activa()."' and where estado = 0 group by  w.estado order by estado asc";
		}		
		$sql = pg_query($conexion, $sql);
		if(pg_num_rows($sql)){
			$row = pg_fetch_row($sql);
			$lista[] = $row[0];
		}else{
			$lista[] = 0;
		}		
		if($t_user == '1'){
			$sql = "select count(w.id_archivo) as total_mes, w.estado from archivo as w where estado = 1 group by  w.estado order by estado asc";
		}else{
			$sql = "select count(w.id_archivo) as total_mes, w.estado from archivo as w where fuente_usuario = '".sesion_activa()."' and where estado = 1 group by  w.estado order by estado asc";
		}		
		$sql = pg_query($conexion, $sql);
		if(pg_num_rows($sql)){			
			$row = pg_fetch_row($sql);
			$lista[] = $row[0];
		}else{
			$lista[] = 0;
		}
		
		echo $lista = json_encode($lista);		
	}
	function total_anios($conexion){
		$dep = array();		
		$lista = array();		
		$t_user = $_SESSION['tipo_user'];		
		if($t_user == '1'){
			$sql = "select date_part('year', w.fecha_creacion) as anio, sum(b.peso::float) as total_mes from archivo w, bitacora b where w.id_archivo = b.id_archivo group by date_part('year', w.fecha_creacion) order by 1,2";
		}else{
			$sql = "select date_part('year', w.fecha_creacion) as anio, sum(b.peso::float) as total_mes from archivo w, bitacora b where w.id_archivo = b.id_archivo group by date_part('year', w.fecha_creacion) order by 1,2";
		}
		$sql = pg_query($conexion, $sql);
		while($row = pg_fetch_row($sql)){			
			$anio[] = $row[0];			
			$lista[] = number_format(($row[1]/1024/1024),5);			
		}
		$lista=array("anio" => $anio, "peso" => $lista);  
		echo $lista = json_encode($lista);		
	}
?>
