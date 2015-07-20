<?php include('../menu/menu.php'); 
//echo bcadd($a, $b, 4);  // 6.2340
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>.:REPORTES GENERALES:.</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="../../web/assets/favicon.ico" rel="Shortcut Icon" />
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />    
    <link href="../../font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/icon/ionicons.min.css" rel="stylesheet" type="text/css" />    
    <link href="../../dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="../../dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/iCheck/all.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/morris/morris.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />    
    <link href="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />      
    <link href="../../plugins/jchosen/chosen.min.css" rel="stylesheet" type="text/css" />    

    <link href="../../plugins/sistema/cambios.css" rel="stylesheet" type="text/css" /> 
    <link href="../../plugins/bootstrap-editable/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet">   
    <link href="../../plugins/bootstrap-editable/bootstrap3-editable/css/address.css" rel="stylesheet">   
    <link href="../../plugins/gritter-master/css/jquery.gritter.css" rel="stylesheet" type="text/css" />    
  </head>
  <body class="skin-blue">
    <div class="wrapper">
      
      <?php banner(); ?>
      <!-- Left side column. contains the logo and sidebar -->
      <?php menu_lateral(); ?>
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">          
          <h1>
            Permisos Usuario
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
            <li class="active">Adminsitración</li>
            <li class="active">Permisos</li>            
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <!-- left column -->
            <div class="col-md-12">
              <!-- general form elements -->
              <div class="box box-primary">
                <div class="box-header">                  
                </div><!-- /.box-header -->
                <!-- form start -->
                <form role="form" id="form_envio" class="" method="POST" action="">                
                  <div class="box-body">
                    <div class="form-group col-md-12">                      
                      <label for="txt_1" class="">Ususario: </label>                      
                      <select class="chosen-select form-control" id="txt_1" name="txt_1" data-placeholder="Seleccione un Usuario">                        
                      </select>
                    </div>
                    <div class="form-group col-md-12">                  
                      <div class="box box-primary">                        
                        <div class="box-body">                                                    
                          <div class="form-group col-md-3">
                            <label>INGRESOS GENERALES</label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_1" class="flat-red"  />
                              Categorías&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_2" class="flat-red"  />
                              Departamentos&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_3" class="flat-red"  />
                              Medios de Recepción &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_4" class="flat-red"  />
                              Tipos de Documentos&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                            </label>
                            <label class="checks_gestion">                                                        
                              <input type="checkbox" id="ck_5" class="flat-red"  />
                              Tipos de usuarios&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                            </label>
                            <label class="checks_gestion">                                                        
                              <input type="checkbox" id="ck_6" class="flat-red"  />
                              Países&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </label>
                            <label class="checks_gestion">                                                        
                              <input type="checkbox" id="ck_7" class="flat-red"  />
                              Provincias&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </label>
                            <label class="checks_gestion">                                                        
                              <input type="checkbox" id="ck_8" class="flat-red"  />
                              Ciudades&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </label>
                          </div>
                          <div class="form-group col-md-3">                                         
                            <label>GESTIÓN DOCUMENTAL</label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_9" class="flat-red"  />
                              Envío Documentos
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_10" class="flat-red"  />
                              Documentos Recibidos
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_11" class="flat-red"  />
                              Documentos Enviados
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_12" class="flat-red"  />
                              Buscar Palabras
                            </label>
                          </div>
                          <div class="form-group col-md-3">                                         
                            <label>REPORTES USUARIOS</label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_13" class="flat-red"  />
                              Dashboard Usuario
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_14" class="flat-red"  />
                              Reportes Usuarios
                            </label>
                          </div>
                          <div class="form-group col-md-3">                                         
                            <label>ADMINSITRACIÓN SISTEMA</label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_15" class="flat-red"  />
                              Nuevos Usuarios
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_16" class="flat-red"  />
                              Permisos Usuarios
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_17" class="flat-red"  />
                              Buscar Documentos
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_18" class="flat-red"  />
                              Respaldos Base de datos
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_19" class="flat-red"  />
                              Reportes Generales
                            </label>
                            <label class="checks_gestion">
                              <input type="checkbox" id="ck_20" class="flat-red"  />
                              Dashboard General
                            </label>
                          </div>
                        </div><!-- /.box-body -->                
                        <div class="box-footer">           
                          <label> </label>
                          <br />
                          <br>
                        </div>
                      </div><!-- /.box -->  
                    </div>
                  </div>                                    
                  <div class="box-footer">                       
                    <button type="submit" class="btn btn-primary "  id="btn_1">
                      <span class="glyphicon glyphicon-save"></span> Modificar Permisos
                    </button>                    
                    <button type="button" class="btn btn-primary" id="btn_2">
                      <span class="glyphicon glyphicon-paperclip"></span> Limpiar
                    </button>                                                            
                  </div>                  
                </form>
              </div><!-- /.box -->              
                                 
            </div><!--/.col (left) -->
            <!-- right column -->

          </div>   <!-- /.row -->
        </section>
        <!-- /.content -->
      </div><!-- /.content-wrapper -->
      <?php footer(); ?>
    </div><!-- ./wrapper -->

    <script src="../../plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <script src="../../plugins/jQueryUI/jquery-ui.min.js" type="text/javascript"></script>    
    <script>
      $.widget.bridge('uibutton', $.ui.button);
    </script>
    <script src="../../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>    
    <script src="../../plugins/raphael/raphael-min.js"></script>    
    <script src="../../plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="../../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
    <script src="../../plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
    <script src="../../plugins/knob/jquery.knob.js" type="text/javascript"></script>
    <script src="../../plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
    <script src="../../plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
    <script src="../../plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script src="../../plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='../../plugins/fastclick/fastclick.min.js'></script>    
    <script src="../../dist/js/app.min.js" type="text/javascript"></script>    
    <script src="../../plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../../plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>    

    <script src="../../plugins/bootstrap-editable/bootstrap3-editable/js/bootstrap-editable.min.js"></script>    
    <script src="../../plugins/bootstrap-editable/bootstrap3-editable/js/address.js"></script>        
    <script src="../../plugins/gritter-master/js/jquery.gritter.min.js" type="text/javascript"></script>    
    <script src="../mod_user.js" type="text/javascript"></script>

    <script src="../../plugins/jchosen/chosen.jquery.js" type="text/javascript"></script>
    <script src="permisos.js" type="text/javascript"></script>
    <script src="../funciones_generales.js" type="text/javascript"></script>
    
    <script type="text/javascript">            
        $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
          checkboxClass: 'icheckbox_flat-blue',
          radioClass: 'iradio_flat-blue'
        });
    </script>
  </body>
</html>