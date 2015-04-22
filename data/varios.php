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
						if($_GET['fun'] == "6"){//para categorias
							if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
								$sql = "select id_categoria,codigo_categoria,nombre_categoria from categorias order by id_categoria asc";
								cargarSelect($conexion,$sql,$_GET['tam']);
							}else{
								
							}
						}else{
							if($_GET['fun'] == "7"){//para departamentos
								if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
									$sql = "select id_departamento,codigo_departamento,nombre_departamento from departamento order by id_departamento asc";
									cargarSelect($conexion,$sql,$_GET['tam']);
								}else{
									
								}
							}else{
								if($_GET['fun'] == "8"){//para tipo_documento
									if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
										$sql = "select id_tipo_documento,codigo_doc,nombre_doc from tipo_documento order by id_tipo_documento asc";
										cargarSelect($conexion,$sql,$_GET['tam']);
									}else{
										
									}
								}else{
									if($_GET['fun'] == "9"){//para medio recepcion
										if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
											$sql = "select id_medio,codigo_medio,nombre_medio from medio_recepcion  order by id_medio asc";
											cargarSelect($conexion,$sql,$_GET['tam']);
										}else{
											
										}
									}else{
										if($_GET['fun'] == "10"){//para ususarios general
											if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
												$sql = "select id_tipo_usuario,nombre_tipo from tipo_usuario order by id_tipo_usuario asc";
												cargarSelect($conexion,$sql,$_GET['tam']);
											}else{
												
											}
										}else{
											if($_GET['fun'] == "11"){//para ciudad con id
												if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
													$sql = "select id_ciudad, nombre_ciudad from ciudad, provincias, pais where ciudad.id_provincia = provincias.id_provincia and provincias.id_pais = pais.id_pais and provincias.id_provincia = '".$_GET['id']."' order by id_ciudad asc";
													cargarSelect($conexion,$sql,$_GET['tam']);
												}else{
													
												}
											}else{
												if($_GET['fun'] == "12"){//para ciudad con id
													if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
														$sql = "select id_categoria,nombre_categoria from categorias order by id_categoria asc";
														cargarSelect($conexion,$sql,$_GET['tam']);
													}else{
														
													}
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
			}
		}
	}
?>