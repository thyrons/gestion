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
    <link href="../../plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />
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
            Reportes Generales
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
            <li class="active">Adminsitración</li>
            <li class="active">Reportes Generales</li>
            <li class="active">Reportes Generales</li>
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
                  <h3 class="box-title">Formulario Reportes</h3>
                </div><!-- /.box-header -->
                <!-- form start -->
                <form role="form" id="form_pais" class="form-horizontal" method="POST" action="">                
                  <div class="box-body col-md-12">                                                            
                    <div class="form-group">                                          
                      <div class="col-md-12">
                        <div class="form-group row">
                          <label for="" class="col-md-2 control-label">Reporte Fechas</label>
                          <div class="col-md-4">
                            <input type="text" class="form-control" id="txt_1" placeholder="Fecha Inicial">
                          </div>                            
                          <div class="col-md-4">
                            <input type="text" class="form-control" id="txt_2" placeholder="Fecha Fin">
                          </div>
                          <div class="col-md-2">
                            <button type="button" class="btn btn-primary"  id="btn_1">
                              <span class="glyphicon glyphicon-save"></span> Imprimir Reporte
                            </button>        
                          </div>
                        </div>
                      </div>  
                      <div class="col-md-12">
                        <div class="form-group row">
                          <label for="" class="col-md-2 control-label">Reporte Peso</label>
                          <div class="col-md-4">
                            <input type="text" class="form-control" id="txt_1" placeholder="Fecha Inicial">
                          </div>                            
                          <div class="col-md-4">
                            <input type="text" class="form-control" id="txt_2" placeholder="Fecha Fin">
                          </div>
                          <div class="col-md-2">
                            <button type="button" class="btn btn-primary"  id="btn_1">
                              <span class="glyphicon glyphicon-save"></span> Imprimir Reporte
                            </button>        
                          </div>
                        </div>
                      </div>                                                                                                     
                      <div class="col-md-12">
                        <div class="form-group row">
                          <label for="" class="col-md-2 control-label">Reporte Por dia</label>
                          <div class="col-md-8">
                            <input type="text" class="form-control" id="txt_1" placeholder="Fecha Inicial">
                          </div>                                                      
                          <div class="col-md-2">
                            <button type="button" class="btn btn-primary"  id="btn_1">
                              <span class="glyphicon glyphicon-save"></span> Imprimir Reporte
                            </button>        
                          </div>
                        </div>
                      </div>    
                      <div class="col-md-12">
                        <div class="form-group row">
                          <label for="" class="col-md-2 control-label">Reporte Tipo Documento</label>
                          <div class="col-md-8">
                            <select  class="form-control" id="txt_1">
                            </select>
                          </div>                                                      
                          <div class="col-md-2">
                            <button type="button" class="btn btn-primary"  id="btn_1">
                              <span class="glyphicon glyphicon-save"></span> Imprimir Reporte
                            </button>        
                          </div>
                        </div>
                      </div>    
                      <div class="col-md-12">
                        <div class="form-group row">
                          <label for="" class="col-md-2 control-label">Tipos de documentos</label>
                          <div class="col-md-8">
                            <select id="tipo" class="form-control">
                              <option value="application/pdf"> Archivos PDF </option>
                              <option value="application/octet-stream"> Aplicaciones ejecutables </option>
                              <option value="application/zip"> Aplicaciones ZIP </option>
                              <option value="application/msword"> Archivos de word 2003 </option>
                              <option value="application/vnd.ms-excel"> Archivos de excel 2003 </option>
                              <option value="application/vnd.ms-powerpoint"> Archivos de power point 2003 </option>
                              <option value="image/gif"> Imágenes gif </option>
                              <option value="image/png"> Imágenes png (image/png) </option>
                              <option value="image/jpg"> Imágenes jpeg (image/jpg) </option>
                              <option value="image/jpg"> Imágenes jpg (image/jpg) </option>
                              <option value="application/vnd.openxmlformats-officedocument.wordprocessingml.document"> Microsoft Office Word 2013 </option>
                              <option value="application/vnd.openxmlformats-officedocument.wordprocessingml.template"> Microsoft Office Plantillas 2013 </option>
                              <option value="application/vnd.openxmlformats-officedocument.presentationml.presentation"> Microsoft Office Power Point 2013 </option>
                              <option value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"> Microsoft Office Excel 2013 </option>
                            </select>
                          </div>
                          <div class="col-md-2">
                            <button type="button" class="btn btn-primary"  id="btn_1">
                              <span class="glyphicon glyphicon-save"></span> Imprimir Reporte
                            </button>        
                          </div>
                        </div>
                      </div>                                                                                                      
                    </div>
                  </div><!-- /.box-body -->
                  <div class="box-footer">                    
                    <label></label>                    
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
    <script src="reportes_generales.js" type="text/javascript"></script>
    <script src="../funciones_generales.js" type="text/javascript"></script>
    
    
  </body>
</html>