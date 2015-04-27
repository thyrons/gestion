<?php
    function conectarse()
    {
    	$conexion = null;
        try{                                     
            $conexion = pg_connect("host=localhost dbname=gestion port=5432 user=postgres password=rootdow");
            if( $conexion == false )
                throw new Exception( "Error PostgreSQL ".pg_last_error() );         
        }
        catch( Exception $e ){
            throw $e;
        }
        return $conexion;
    }
?>