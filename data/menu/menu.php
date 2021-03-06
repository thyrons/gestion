<?php 
session_start();

if (!isset($_SESSION["id_gestion"])) {
    header("Location: ../login");  
}

// pie de pagina
function footer(){
	print' <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.0
        </div>
        <strong>Uniandes - Ibarra 2014-2015 Willi Narváez</strong>
      </footer>';
}
// banner o cabecera
function banner(){
	print'
	<header class="main-header">
        <!-- Logo -->
        <a href="index.php" class="logo">UNIANDES</a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">                                                                    
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="../../dist/img/avatar5.png" class="user-image" alt="User Image"/>
                  <span class="hidden-xs">'.$_SESSION['nombres_gestion'].'</span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img src="../../dist/img/avatar5.png" class="img-circle" alt="User Image" />
                    <p>
                      '.$_SESSION['nombres_gestion'].'
                      <small>Miembro desde '.$_SESSION['fecha_gestion'].'</small>
                    </p>
                  </li>                  
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="col-sm-4 col-md-4 col-xs-4 col-lg-4">
                      <a href="#" id="mod_perfil" class="btn btn-default btn-flat">Perfil</a>
                    </div>
                    <div class="col-sm-4 col-md-4 col-xs-4 col-lg-4">
                      <a href="#" id="cambiar_clave" class="btn btn-default btn-flat">C. Clave</a>
                    </div>
                    <div class="col-sm-4 col-md-4 col-xs-4 col-lg-4">
                      <a href="../login/salir_session.php" class="btn btn-default btn-flat">Salir</a>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </header>
';
}
// menu principal lateral
function menu_lateral(){
  //error_reporting(0);
  $url = $_SERVER['PHP_SELF'];
  $acus = parse_url($url, PHP_URL_PATH);
  $acus = split ('/', $acus);  
  $array = $_SESSION['accesos'];
  //print_r($array);
  print'
    <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">            
          <img src="../../dist/img/avatar2.png" width="100%" height="180px" class="morph pic">
      </div>          
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">Menú Principal</li>';
        if($array[4] == 0 || $array[5] == 0 || $array[6] == 0 || $array[7] == 0 || $array[8] == 0 || $array[9] == 0 || $array[10] == 0 || $array[11] == 0){
          print '<li ';if ($acus[3]=='categorias' || $acus[3]=='departamentos' || $acus[3]=='medio_recepcion' || $acus[3]=='tipo_documento' || $acus[3]=='tipo_usuario'|| $acus[3]=='pais'|| $acus[3]=='provincia'|| $acus[3]=='tipo_producto'|| $acus[3]=='ciudad') {
            print('class="treeview active open"');
          }print'>       
            <a href="#">
              <i class="fa fa-desktop"></i> <span>Generales</span>
              <i class="fa fa-angle-left pull-right"></i>
            </a>              
            <ul class="treeview-menu">';
              if($array[4] == 0){
                print '<li ';if ($acus[3]=='categorias') {
                  print('class="active"');
                }print'>
                <a href="../categorias"><i class="fa fa-plus-square-o"></i>Categorías</a></li>';
              }
              if($array[5] == 0){
                print '<li ';if ($acus[3]=='departamentos') {
                  print('class="active"');
                }print'>
                <a href="../departamentos"><i class="fa fa-sitemap"></i>Departamentos</a></li>';
              }
              if($array[6] == 0){
                print '<li ';if ($acus[3]=='medio_recepcion') {
                  print('class="active"');
                }print'>
                <a href="../medio_recepcion"><i class="fa fa-folder-open-o"></i>Medio Recepción</a></li>';
              }
              if($array[7] == 0){
                print '<li ';if ($acus[3]=='tipo_documento') {
                  print('class="active"');
                }print'>  
                <a href="../tipo_documento"><i class="fa fa-file-text-o"></i>Tipo Documento</a></li>';
              }
              if($array[8] == 0){
                print '<li ';if ($acus[3]=='tipo_usuario') {
                  print('class="active"');
                }print'>  
                <a href="../tipo_usuario"><i class="fa fa-user"></i>Tipo Usuario</a></li>';                          
              }
              if($array[9] == 0 || $array[10] == 0 || $array[11] == 0){
                print '<li ';if ($acus[3]=='pais'|| $acus[3]=='provincia' || $acus[3]=='ciudad') {
                  print('class="active"');
                }print'>                   
                  <a href="#"><i class="fa fa-flag-o"></i> Direcciónes <i class="fa fa-angle-left pull-right"></i></a>
                  <ul class="treeview-menu">';
                    if($array[9] == 0){
                      print '<li ';if ($acus[3]=='pais') {
                        print('class="active"');
                      }print'>  
                      <a href="../pais"><i class="fa fa-flag-checkered"></i> Países</a></li>';
                    }
                    if($array[10] == 0){
                      print '<li ';if ($acus[3]=='provincia') {
                        print('class="active"');
                      }print'>  
                      <a href="../provincia"><i class="fa fa-flag-checkered"></i> Provincias</a></li>';
                    }
                    if($array[11] == 0){
                      print '<li ';if ($acus[3]=='ciudad') {
                        print('class="active"');
                      }print'>   
                        <a href="../ciudad"><i class="fa fa-flag-checkered"></i> Ciudades</a></li>';
                    }
                  print '</ul>              
                </li>';  
              }              
            print '</ul>
          </li>';
        }
        if($array[0] == 0 || $array[1] == 0 || $array[2] == 0 || $array[3] == 0 ){
          print '<li ';if ($acus[3]=='envio' || $acus[3]=='inbox' ) {
            print('class="treeview active open"');
          }print'>                                   
            <a href="#">
              <i class="fa fa-files-o"></i> <span>Gestión Documental</span>
              <i class="fa fa-angle-left pull-right"></i>
            </a>              
            <ul class="treeview-menu">';
              if($array[0] == 0){
                print '<li ';if ($acus[3]=='envio') {
                  print('class="active"');
                }print'>  
                <a href="../envio"><i class="fa fa-envelope-o"></i> Redactar</a></li>';  
              }
              if($array[1] == 0){
                print '<li ';if ($acus[3]=='inbox' && $acus[4]=='index.php') {              
                  print('class="active"');
                }print'>                        
                  <a href="../inbox"><i class="fa fa-mail-forward"></i> Bandeja de Entrada</a></li>';
              }
              if($array[2] == 0){
                print '<li ';if ($acus[4] == 'enviados.php') {
                  print('class="active"');
                }print'>  
                  <a href="../inbox/enviados.php"><i class="fa fa-mail-reply"></i> Enviados</a></li>';
              }
              if($array[3] == 0){
                print '<li ';if ($acus[4] == 'buscar_archivos.php') {
                  print('class="active"');
                }print'>    
                  <a href="../inbox/buscar_archivos.php"><i class="fa fa-search-plus"></i> Buscar Archivos</a></li>';                                            
              }
           print '</ul>
          </li>';      
        }       
        if($array[12] == 0 || $array[13] == 0){
          print '<li ';if ($acus[3]=='reportes_usuario') {
            print('class="treeview active open"');
          }print'>';                   
            print '<a href="#">
              <i class="fa fa-dashboard"></i> <span>Reportes</span>
              <i class="fa fa-angle-left pull-right"></i>
            </a>              
            <ul class="treeview-menu">';     
              if($array[12] == 0){                          
                print '<li ';if ($acus[4]=='usuario.php') {              
                  print('class="active"');
                }print'>  
                  <a href="../reportes_usuario/usuario.php"><i class="fa fa-dashboard"></i> Generales</a></li> '; 
              }
              if($array[13] == 0){                          
                print '<li ';if ($acus[4]=='dashboard.php') { 
                  print('class="active"');
                }print'>  
                  <a href="../reportes_usuario/dashboard.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>';            
              }
            print '</ul>
          </li>';       
        }         
        if($array[14] == 0 || $array[15] == 0 || $array[16] == 0 || $array[17] == 0 || $array[18] == 0 || $array[19] == 0){
          print '<li ';if ($acus[3]=='usuarios' || $acus[3]=='buscar_archivos' || $acus[3]=='reportes_generales' || $acus[3]=='permisos') {
            print('class="treeview active open"');
          }print'>                                  
            <a href="#">
              <i class="fa fa-gears"></i> <span>Administración</span>
              <i class="fa fa-angle-left pull-right"></i>
            </a>                                
            <ul class="treeview-menu">';            
              if($array[14] == 0){     
                print '<li ';if ($acus[3]=='usuarios') { 
                  print('class="active"');
                }print'>  
                <a href="../usuarios"><i class="fa fa-users"></i> Nuevos Usuarios</a></li>';
              }
              if($array[15] == 0){     
                print '<li ';if ($acus[3]=='permisos') {               
                  print('class="active"');
                }print'>  
                <a href="../permisos"><i class="fa fa-cogs"></i> Permisos Usuarios</a></li>';
              }
              if($array[16] == 0){     
                print '<li ';if ($acus[3]=='buscar_archivos') { 
                  print('class="active"');
                }print'>  
                <a href="../buscar_archivos"><i class="fa fa-search-plus"></i> Buscar Archivos</a></li>';
              }                
              if($array[17] == 0){     
                print '<li><a href="../backup.php"><i class="fa fa-download"></i> Backup</a></li>';            
              }
              if($array[18] == 0 || $array[19] == 0){
                print '<li ';if ($acus[4]=='dashboard.php' || $acus[4]=='generales.php') {
                  print('class="active"');
                }print'>                               
                  <a href="#"><i class="fa fa-dashboard"></i>Reportes Generales <i class="fa fa-angle-left pull-right"></i></a>
                  <ul class="treeview-menu">';
                    if($array[18] == 0){     
                      print '<li ';if ($acus[4]=='dashboard.php') { 
                        print('class="active"');
                      }print'>  
                      <a href="../reportes_generales/dashboard.php"><i class="fa fa-bar-chart-o"></i> Estadisticas Generales</a></li>';
                    }
                    if($array[19] == 0){     
                      print '<li ';if ($acus[4]=='generales.php') { 
                        print('class="active"');
                      }print'>  
                      <a href="../reportes_generales/generales.php"><i class="fa fa-book"></i> Reportes Generales</a>';
                    }
                    print '</li>
                  </ul>
                </li>';
              }
            print '</ul>
          </li>';  
        }
        print '</ul>
      </section>
    <!-- /.sidebar -->
  </aside>
  ';
 
}
?>
