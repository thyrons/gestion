<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>.:INGRESO AL SISTEMA:.</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="../../web/assets/favicon.ico" rel="Shortcut Icon" />
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="../../font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../../dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="../../plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>
  <body class="login-page">
    <div class="login-box">      
      <div class="login-box-body" align="center">
        <img src="img/logo2.fw.png" width="100%">
        <p class="login-box-msg">Ingrese los datos para iniciar session</p>
        <form action="" id="form_login" name="form_login" method="post">
          <div class="form-group has-feedback">
            <input type="text" class="form-control" placeholder="Usuario" id="txt_1" name="txt_1" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9 ]{1,}" />
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type="password" class="form-control" placeholder="Password" id="txt_2"  name="txt_2" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9 ]{1,}" />
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="row">
            <div class="col-xs-4">    
              
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button type="submit" class="btn btn-primary btn-block btn-flat" id="btn_1">Ingreso</button>
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button type="button" class="btn btn-primary btn-block btn-flat" id="btn_2">Limpiar</button>
            </div><!-- /.col -->
          </div>
        </form>

        <img src="img/logo.png" width="100%">

        <!--<a href="#">Olvido su contraseña</a><br>
        <a href="register.html" class="text-center">Registrar Nuevo Usuario</a>-->

      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

    <!-- jQuery 2.1.3 -->
    <script src="../../plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="../../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <script src="../../plugins/iCheck/icheck.min.js" type="text/javascript"></script>  
    <script src="../../dist/js/bootbox.js"></script>  

    <script src="login.js" type="text/javascript"></script>    
    <script src="../funciones_generales.js"></script>        
  </body>
</html>