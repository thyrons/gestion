<?php
include '../conexion.php';
include '../funciones_generales.php';		
 $conexion = conectarse();
$consulta = pg_query("select id_pais,codigo_pais,nombre_pais from pais order by nombre_pais asc");
while ($row = pg_fetch_row($consulta)) {
    $lista[] = $row[0];
    $lista[] = $row[1];
    $lista[] = $row[2];   
}
echo $lista = json_encode($lista);



// $consulta = pg_query("select * from pais order by id_pais asc ");
// $temp = '';
// while($row = pg_fetch_row($consulta)){
// 	$list = (split('[()]', $row[1]));		

// 	//echo "update pais set codigo_pais = '(".$list[1].")',nombre_pais = '".$list[0]."' where id_pais= '".$row[0]."'";
// 	pg_query("update pais set codigo_pais = '(".$list[1].")',nombre_pais = '".$list[0]."' where id_pais= '".$row[0]."'");
// }


?>