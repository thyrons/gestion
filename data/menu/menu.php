<?php 
session_start();
// pie de pagina
function footer(){
	print' <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.0
        </div>
        <strong>Copyright &copy; 2014-2015 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights reserved.
      </footer>';
}
// banner o cabecera
function banner(){
	print'
	<header class="main-header">
        <!-- Logo -->
        <a href="index.php" class="logo"><b></b></a>
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
                      <a href="#" class="btn btn-default btn-flat">Salir</a>
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
print'
<aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          <div class="user-panel">            
            <div class="pull-left info">
              <p>SGD</p>              
            </div>
          </div>          
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
            <li class="header">Menú Principal</li>                                    
            <li class="treeview">
              <a href="#">
                <i class="fa fa-share"></i> <span>Multilevel</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
                <li>
                  <a href="#"><i class="fa fa-circle-o"></i> Level One <i class="fa fa-angle-left pull-right"></i></a>
                  <ul class="treeview-menu">
                    <li><a href="#"><i class="fa fa-circle-o"></i> Level Two</a></li>
                    <li>
                      <a href="#"><i class="fa fa-circle-o"></i> Level Two <i class="fa fa-angle-left pull-right"></i></a>
                      <ul class="treeview-menu">
                        <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
                        <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
                      </ul>
                    </li>
                  </ul>
                </li>
                <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
              </ul>
            </li>            
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>

	';
}
?>