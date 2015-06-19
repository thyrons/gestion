<?php
    function conectarse()
    {
    	$conexion = null;
        try{            
            $conexion = pg_connect("dbname=d7rda1uchr3ia9 host=ec2-107-20-152-139.compute-1.amazonaws.com port=5432 user=iqscewrptfboik password=nbeXzMBnCaDTRuMY-Smyd8pp3y sslmode=require");
            //$conexion = pg_connect("host=localhost dbname=gestion_documental port=5432 user=postgres password=rootdow");
            //$conexion = pg_connect("host=localhost dbname=gestion_documental port=5432 user=postgres password=rootdow");
            if( $conexion == false )
                throw new Exception( "Error PostgreSQL ".pg_last_error() );         
        }
        catch( Exception $e ){
            throw $e;
        }
        return $conexion;
    }
?>