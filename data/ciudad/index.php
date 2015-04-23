<?php include('../menu/menu.php'); ?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>PRINCIPAL</title>
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
            Ingreso de Ciudades            
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
            <li class="active">Ingresos</li>
            <li class="active">Ciudades</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <!-- left column -->
            <div class="col-md-6">
              <!-- general form elements -->
              <div class="box box-primary">
                <div class="box-header">
                  <h3 class="box-title">Formularios Ciudades</h3>
                </div><!-- /.box-header -->
                <!-- form start -->
                <form role="form" id="form_ciudad" class="form-horizontal" method="POST" action="">                
                  <div class="box-body col-md-12">                                                                             
                    <div class="form-group">                            
                      <label for="txt_1" class="col-md-3">Nombre País</label>
                      <div class="col-md-9">
                        <select class="chosen-select form-control" id="txt_1" name="txt_1" data-placeholder="Seleccione un país">
                          
                        </select>   
                        <input type="hidden" id="txt_0" name="txt_0" />        
                      </div>
                    </div>        
                    <div class="form-group">                            
                      <label for="txt_2" class="col-md-3"> Provincia</label>
                      <div class="col-md-9">
                        <select class="chosen-select form-control" id="txt_2" name="txt_2" data-placeholder="Seleccione un país">
                          
                        </select>                           
                      </div>
                    </div>        
                    <div class="form-group">                            
                      <label for="txt_3" class="col-md-3">Ciudad</label>
                      <div class="col-md-9">
                        <input type="text" class="form-control" id="txt_3" name="txt_3" placeholder="Nombre Ciudad" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">
                      </div>
                    </div>                                                                                                  
                  </div><!-- /.box-body -->
                  <div class="box-footer">                    
                    <button type="submit" class="btn btn-primary"  id="btn_1">
                      <span class="glyphicon glyphicon-save"></span> Guardar
                    </button>                    
                    <button type="button" class="btn btn-primary" id="btn_2">
                    <span class="glyphicon glyphicon-paperclip"></span> Limpiar
                    </button>                    
                  </div>
                </form>
              </div><!-- /.box -->              
                                 
            </div><!--/.col (left) -->
            <!-- right column -->
            <div class="col-md-6">
              <!-- general form elements disabled -->
              <div class="box box-primary">
                <div class="box-header">
                  <h3 class="box-title">Tabla Ciudades</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <table id="tabla_ciudad" class="table table-bordered table-hover">
                    <thead>
                      <th>ID</th>
                      <th>Ciudad</th>
                      <th>id_provincia</th>
                      <th>Provincia/Estado</th>
                      <th>id_pais</th>
                      <th>País</th>                      
                    </thead>
                    <tbody>                      
                    </tbody>
                  </table>
                </div>
              </div><!-- /.box -->
            </div><!--/.col (right) -->
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

    <script src="../../plugins/jchosen/chosen.jquery.js" type="text/javascript"></script>
    <script src="ciudad.js" type="text/javascript"></script>
    <script src="../funciones_generales.js" type="text/javascript"></script>
    
    
  </body>
</html>