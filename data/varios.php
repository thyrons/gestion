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
												if($_SESSION['tipo_user'] == '1'){
													$sql = "select id_tipo_usuario,nombre_tipo from tipo_usuario order by id_tipo_usuario asc";	
												}else{
													$sql = "select id_tipo_usuario,nombre_tipo from tipo_usuario where estado = '1' order by id_tipo_usuario asc";													
													
												}												
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
														if($_SESSION['tipo_user'] == '1'){
															$sql = "select id_categoria,nombre_categoria from categorias order by id_categoria asc";
														}else{
															$sql = "select id_categoria,nombre_categoria where estado = '1' from categorias order by id_categoria asc";
														}
														cargarSelect($conexion,$sql,$_GET['tam']);
													}else{
														
													}
												}else{
													if($_GET['fun'] == "13"){//para ciudad con id
														if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
															$sql = "select id_departamento,nombre_departamento from departamento order by id_departamento asc";
															cargarSelect($conexion,$sql,$_GET['tam']);
														}else{
															
														}
													}else{
														if($_GET['fun'] == "14"){//para ciudad con id
															if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
																$sql = "select id_usuario,cod_usuario,nombres_usuario,direccion_usuario,usuario.id_ciudad, nombre_ciudad, provincias.id_provincia, nombre_provincia, pais.id_pais, nombre_pais,telefono_usuario,celular_usuario,email_usuario,usuario.id_tipo_user,nombre_tipo,usuario.usuario,institucion,usuario.id_categoria,nombre_categoria,usuario.id_departamento,nombre_departamento,fecha,tipo_documento,nro_documento,clave from usuario,ciudad,provincias,pais,tipo_usuario,categorias,departamento,clave where usuario.id_ciudad = ciudad.id_ciudad and provincias.id_provincia = ciudad.id_provincia and provincias.id_pais = pais.id_pais and tipo_usuario.id_tipo_usuario = usuario.id_tipo_user and usuario.id_categoria = categorias.id_categoria and departamento.id_departamento = usuario.id_departamento and usuario.id_usuario = clave.usuario";
																cargarSelect($conexion,$sql,$_GET['tam']);
															}else{
																
															}
														}else{	
															if($_GET['fun'] == "15"){//para ciudad con id
																if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina
																	$sql = "select id_usuario,cod_usuario,nombres_usuario,direccion_usuario,usuario.id_ciudad, nombre_ciudad, provincias.id_provincia, nombre_provincia, pais.id_pais, nombre_pais,telefono_usuario,celular_usuario,email_usuario,usuario.id_tipo_user,nombre_tipo,usuario.usuario,institucion,usuario.id_categoria,nombre_categoria,usuario.id_departamento,nombre_departamento,fecha,tipo_documento,nro_documento,clave from usuario,ciudad,provincias,pais,tipo_usuario,categorias,departamento,clave where usuario.id_ciudad = ciudad.id_ciudad and provincias.id_provincia = ciudad.id_provincia and provincias.id_pais = pais.id_pais and tipo_usuario.id_tipo_usuario = usuario.id_tipo_user and usuario.id_categoria = categorias.id_categoria and departamento.id_departamento = usuario.id_departamento and usuario.id_usuario = clave.usuario and usuario.id_usuario = '".$_SESSION['id_gestion']."'";
																	cargarSelect($conexion,$sql,$_GET['tam']);
																}else{
																	
																}
															}else{															
																if($_GET['fun'] == "16"){//para ciudad con id
																	if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																		
																		//$sql = "select id_usuario,nombres_usuario,usuario from usuario where id_usuario not in ('". $_SESSION['id_gestion'] ."') order by id_usuario asc";																		
																		$sql = "select id_usuario,nombres_usuario,usuario from usuario order by id_usuario asc";																		
																		cargarSelect($conexion,$sql,$_GET['tam']);
																	}else{
																		
																	}
																}else{															
																	if($_GET['fun'] == "17"){//para ciudad con id
																		if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																			$sql = "select enviados.id_envio,bitacora.id_bitacora,archivo.id_archivo,nombre_archivo,asunto_cambio,observaciones,enviados.fecha,leido,bitacora.id_usuario,nombres_usuario,referencia from enviados,bitacora,archivo,usuario where enviados.id_bitacora = bitacora.id_bitacora and bitacora.id_archivo = archivo.id_archivo and bitacora.id_usuario = usuario.id_usuario and enviados.id_usuario = '".$_SESSION['id_gestion']."' order by enviados.fecha desc offset ".$_GET['inicio']." limit ".$_GET['fin']."";																			
																			cargarTabla($conexion,$sql,$_GET['tam']);
																		}else{
																			
																		}
																	}else{															
																		if($_GET['fun'] == "18"){//para ciudad con id
																			if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																				$sql = "select enviados.id_envio,bitacora.id_bitacora,archivo.id_archivo,nombre_archivo,asunto_cambio,observaciones,enviados.fecha,leido,bitacora.id_usuario,nombres_usuario,referencia from enviados,bitacora,archivo,usuario where enviados.id_bitacora = bitacora.id_bitacora and bitacora.id_archivo = archivo.id_archivo and bitacora.id_usuario = usuario.id_usuario and enviados.id_usuario = '".$_SESSION['id_gestion']."' order by enviados.fecha asc ";																			
																				nro_rows($conexion,$sql);
																			}else{
																				
																			}
																		}else{															
																			if($_GET['fun'] == "19"){//para ciudad con id
																				if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																					$sql = "select enviados.id_envio,bitacora.id_bitacora,archivo.id_archivo,nombre_archivo,asunto_cambio,observaciones,enviados.fecha,leido,bitacora.id_usuario,nombres_usuario,referencia from enviados,bitacora,archivo,usuario where enviados.id_bitacora = bitacora.id_bitacora and bitacora.id_archivo = archivo.id_archivo and bitacora.id_usuario = usuario.id_usuario and enviados.id_usuario = '".$_SESSION['id_gestion']."' and nombre_archivo like '".$_GET['txt']."%' order by enviados.fecha asc offset ".$_GET['inicio']." limit ".$_GET['fin']."";
																					cargarTabla($conexion,$sql,$_GET['tam']);
																				}else{
																					
																				}
																			}else{
																				if($_GET['fun'] == "20"){//para cargar el correo																					
																					if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																						$sql = "select id_envio,fecha_cambios,asunto_cambio,observaciones,referencia,nombres_usuario,peso,bitacora.id_bitacora from enviados,usuario,bitacora where enviados.id_bitacora = bitacora.id_bitacora and enviados.id_usuario = usuario.id_usuario and enviados.id_envio = '".$_GET['id']."'";																						
																						cargarTabla($conexion,$sql,$_GET['tam']);																							
																					}else{
																						
																					}																					
																				}else{
																					if($_GET['fun'] == "21"){//para cargar el correo																					
																						if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																							$sql = "select id_envio,fecha_cambios,asunto_cambio,observaciones,referencia,nombres_usuario,peso from enviados,usuario,bitacora where enviados.id_bitacora = bitacora.id_bitacora and enviados.id_usuario = usuario.id_usuario  and enviados.id_envio not in ('".$_GET['id']."')  order by id_envio asc limit 1";																						
																							cargarTabla($conexion,$sql,$_GET['tam']);																							
																						}else{																																													
																							
																						}
																					}else{
																						if($_GET['fun'] == "22"){//para cargar el correo																					
																							if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																								$sql = "select distinct usuario.id_usuario,nombres_usuario from enviados,usuario where enviados.id_usuario = usuario.id_usuario and id_archivo = '".$_GET['id']."'";
																								cargarSelect($conexion,$sql,$_GET['tam']);																							
																							}else{
																								
																							}																					
																						}else{
																							if($_GET['fun'] == "23"){//para cargar el correo																					
																								if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																									$sql = "select id_bitacora,fecha_cambios,asunto_cambio,bitacora.observaciones,bitacora.id_usuario,nombres_usuario from bitacora,usuario where bitacora.id_usuario = usuario.id_usuario and id_archivo = '".$_GET['id']."' order by fecha_cambios asc";																						
																									cargarSelect($conexion,$sql,$_GET['tam']);																							
																								}else{
																									
																								}																					
																							}else{
																								if($_GET['fun'] == "24"){//para cargar el correo																					
																									if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																										$sql = "select id_bitacora,archivo.id_archivo,bitacora.id_bitacora,fecha_cambios,asunto_cambio,bitacora.id_tipo_documento,bitacora.id_medio_recepcion,nombre_archivo,codigo_archivo,archivo.estado from bitacora, archivo,tipo_documento,medio_recepcion where bitacora.id_archivo = archivo.id_archivo and bitacora.id_tipo_documento = tipo_documento.id_tipo_documento and bitacora.id_medio_recepcion = medio_recepcion.id_medio and bitacora.id_bitacora = '".$_GET['id']."'";
																										cargarSelect($conexion,$sql,$_GET['tam']);																							
																									}else{
																										
																									}																					
																								}else{
																									if($_GET['fun'] == "25"){//para cargar el correo																					
																										if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																											$sql = "select id_archivo from bitacora where id_bitacora = '".$_GET['id']."'";
																											cargarSelect($conexion,$sql,$_GET['tam']);																							
																										}else{
																											
																										}																					
																									}else{
																										if($_GET['fun'] == "26"){//para cargar el correo																					
																											if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																												$sql = "select recibidos.id_recibido,recibidos.id_archivo,recibidos.id_bitacora,recibidos.fecha,recibidos.id_usuario,nombres_usuario,usuario,nombre_archivo,asunto_cambio from recibidos,usuario,archivo,bitacora where recibidos.id_usuario = '".$_SESSION['id_gestion']."' and recibidos.id_usuario = usuario.id_usuario and recibidos.id_archivo = archivo.id_archivo and recibidos.id_bitacora = bitacora.id_bitacora order by recibidos.fecha desc";																			
																												nro_rows($conexion,$sql);
																											}else{
																											}
																										}else{
																											if($_GET['fun'] == "27"){//para ciudad con id
																												if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																													$sql = "select recibidos.id_recibido,recibidos.id_archivo,recibidos.id_bitacora,nombre_archivo,asunto_cambio,recibidos.id_usuario,recibidos.fecha,usuario,peso,nombres_usuario,referencia from recibidos,usuario,archivo,bitacora where recibidos.id_usuario = '".$_SESSION['id_gestion']."' and recibidos.id_usuario = usuario.id_usuario and recibidos.id_archivo = archivo.id_archivo and recibidos.id_bitacora = bitacora.id_bitacora order by recibidos.fecha desc offset ".$_GET['inicio']." limit ".$_GET['fin']."";																			
																													cargarTabla($conexion,$sql,$_GET['tam']);
																												}else{
																													
																												}
																											}else{
																												if($_GET['fun'] == "28"){//para ciudad con id
																													if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																														$sql = "select recibidos.id_recibido,recibidos.id_archivo,recibidos.id_bitacora,nombre_archivo,asunto_cambio,recibidos.id_usuario,recibidos.fecha,usuario,peso,nombres_usuario,referencia from recibidos,usuario,archivo,bitacora where recibidos.id_usuario = '".$_SESSION['id_gestion']."' and recibidos.id_usuario = usuario.id_usuario and recibidos.id_archivo = archivo.id_archivo and recibidos.id_bitacora = bitacora.id_bitacora and nombre_archivo like '".$_GET['txt']."%' order by recibidos.fecha desc offset ".$_GET['inicio']." limit ".$_GET['fin']."";																			
																														cargarTabla($conexion,$sql,$_GET['tam']);
																													}else{
																														
																													}
																												}else{
																													if($_GET['fun'] == "29"){//para ciudad con id
																														if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																															$sql = "select recibidos.id_recibido,recibidos.id_archivo,recibidos.id_bitacora,nombre_archivo,asunto_cambio,recibidos.id_usuario,recibidos.fecha,usuario,peso,nombres_usuario,referencia from recibidos,usuario,archivo,bitacora where recibidos.id_usuario = '".$_SESSION['id_gestion']."' and recibidos.id_usuario = usuario.id_usuario and recibidos.id_archivo = archivo.id_archivo and recibidos.id_bitacora = bitacora.id_bitacora and nombre_archivo like '".$_GET['txt']."%' order by recibidos.fecha desc offset ".$_GET['inicio']." limit ".$_GET['fin']."";																			
																															cargarTabla($conexion,$sql,$_GET['tam']);
																														}else{
																															
																														}
																													}else{
																														if($_GET['fun'] == "30"){//para ciudad con id
																															if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																																$sql = "select enviados.id_envio,bitacora.id_bitacora,archivo.id_archivo,nombre_archivo,asunto_cambio,observaciones,enviados.fecha,leido,bitacora.id_usuario,nombres_usuario,referencia from enviados,bitacora,archivo,usuario where enviados.id_bitacora = bitacora.id_bitacora and bitacora.id_archivo = archivo.id_archivo and bitacora.id_usuario = usuario.id_usuario and enviados.id_usuario = '".$_SESSION['id_gestion']."' and leido = '0' order by enviados.fecha asc ";																			
																																nro_rows($conexion,$sql);
																															}else{
																																
																															}
																														}else{
																															if($_GET['fun'] == "31"){//para ciudad con id
																																if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																																	$sql = "select id_recibido,fecha_cambios,asunto_cambio,observaciones,referencia,nombres_usuario,peso,bitacora.id_bitacora from recibidos,usuario,bitacora,archivo where recibidos.id_bitacora = bitacora.id_bitacora and recibidos.id_usuario = usuario.id_usuario and recibidos.id_archivo = archivo.id_archivo and recibidos.id_recibido = '".$_GET['id']."'";
																																	cargarTabla($conexion,$sql,$_GET['tam']);
																																}else{
																																	
																																}
																															}else{
																																if($_GET['fun'] == "32"){//para ciudad con id
																																	if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																																		$sql = "select usuarios from recibidos where id_recibido = '".$_GET['id']."'";
																																		cargarTablaUsusariosRecibidos($conexion,$sql,$_GET['tam']);
																																	}else{
																																		
																																	}
																																}else{
																																	if($_GET['fun'] == "33"){//para ciudad con id
																																		if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																																			$sql = "select bitacora.id_bitacora,codigo_archivo,nombre_archivo,fecha_cambios, asunto_cambio, referencia,peso,tipo,bitacora.estado,bitacora.id_usuario, nombres_usuario from archivo,bitacora,usuario where bitacora.id_archivo = archivo.id_archivo and bitacora.id_usuario = usuario.id_usuario and archivo.id_archivo = '".$_GET['id']."' order by fecha_cambios desc";
																																			cargarSelect($conexion,$sql,$_GET['tam']);
																																		}else{
																																			
																																		}
																																	}else{
																																		if($_GET['fun'] == "34"){//para ciudad con id
																																			if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																																																									
																																				buscador_texto($conexion,$_GET['sub'],$_GET['txt']);
																																			}else{
																																				
																																			}
																																		}else{
																																			if($_GET['fun'] == "35"){//para ciudad con id
																																				if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																																																									
																																					total_meses($conexion);
																																				}else{
																																					
																																				}
																																			}else{
																																				if($_GET['fun'] == "36"){//para ciudad con id
																																					if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																																																									
																																						total_meses_kbp($conexion);
																																					}else{
																																						
																																					}
																																				}else{
																																					if($_GET['fun'] == "37"){//para ciudad con id
																																						if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																																																									
																																							total_documentos($conexion);
																																						}else{
																																							
																																						}
																																					}else{
																																						if($_GET['fun'] == "38"){//para ciudad con id
																																							if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																																																									
																																								total_estados($conexion);
																																							}else{
																																								
																																							}
																																						}else{
																																							if($_GET['fun'] == "39"){//para ciudad con id
																																								if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																																																									
																																									total_anios($conexion);
																																								}else{
																																									
																																								}
																																							}else{
																																								if($_GET['fun'] == "40"){//para ciudad con id
																																									if($_GET['tipo'] == "0"){//indica que se carga al inicio de la pagina																																					
																																										$sql = "select id_aplicacion,estado from accesos where id_usuario = '".$_GET['id']."' order by id_aplicacion asc";
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
				}
			}
		}
	}
?>