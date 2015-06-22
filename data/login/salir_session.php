<?php
	//Lo primero es iniciar la sesión antes de enviar nada, pero
	//estableciendo el modo con cookies por si estuviera desactivado
	ini_set("session.use_cookies", 1);
	ini_set("session.use_only_cookies", 1);
	session_start();
	//Primero destruimos las variables de sesión, en nuestro ejemplo "color-fondo"
	$_SESSION = array();
	//A continuación envíamos una cookie con tiempo negativo, lo que supone que
	//el navegador eliminará la cookie en su sistema.
	//Esto lo podemos hacer sólo si el php.ini está configurado para usar
	//cookies, aunque por defecto es que sí.
	if (ini_get("session.use_cookies")) {
	    $params = session_get_cookie_params();
	    setcookie(session_name(), '', time() - 42000,
	        $params["path"], $params["domain"],
	        $params["secure"], $params["httponly"]
	    );
	}
	//Por último destruimos la sesión
	session_destroy();
	header('Location: index.php');
?>