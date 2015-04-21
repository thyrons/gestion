<?php
	include 'conexion.php';
	include 'funciones_generales.php';		
	$conexion = conectarse();
	$sql = "";
	if($_GET['fun'] == "1"){//para paises
		if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
			$sql = "select id_pais,nombre_pais from pais";
			cargarSelect($conexion,$sql,$_GET['tam']);
		}else{

		}
	}else{
		if($_GET['fun'] == "2"){//para paises
			if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
				$sql = "select id_pais,codigo_pais,nombre_pais from pais order by nombre_pais asc";
				cargarSelect($conexion,$sql,$_GET['tam']);
			}else{
				
			}
		}else{
			if($_GET['fun'] == "3"){//para provincas paises
				if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
					$sql = "select id_provincia,nombre_provincia,pais.id_pais,nombre_pais from provincias,pais where provincias.id_pais = pais.id_pais order by id_provincia asc";
					cargarSelect($conexion,$sql,$_GET['tam']);
				}else{
					
				}
			}else{
				if($_GET['fun'] == "4"){//para ciudades provinas pais
					if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
						$sql = "select id_ciudad, nombre_ciudad, provincias.id_provincia, nombre_provincia, pais.id_pais, nombre_pais from ciudad, provincias, pais where ciudad.id_provincia = provincias.id_provincia and provincias.id_pais = pais.id_pais order by id_ciudad asc";
						cargarSelect($conexion,$sql,$_GET['tam']);
					}else{
						
					}
				}else{
					if($_GET['fun'] == "5"){//para provincas con pais id
						if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
							$sql = "select id_provincia, nombre_provincia from provincias where id_pais = '".$_GET['id']."' order by id_provincia asc";
							cargarSelect($conexion,$sql,$_GET['tam']);
						}else{
							
						}
					}else{

					}
				}
			}
		}
	}
?>