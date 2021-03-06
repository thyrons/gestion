<?php include('../menu/menu.php'); ?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>.:REENVÍO:.</title>
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
    <link href="../../plugins/sistema/cambios.css" rel="stylesheet" type="text/css" /> 
    <link href="../../plugins/bootstrap-editable/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet">   
    <link href="../../plugins/bootstrap-editable/bootstrap3-editable/css/address.css" rel="stylesheet">   
    <link href="../../plugins/jchosen/chosen.min.css" rel="stylesheet" type="text/css" />    
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
          Reenvío de Documentos
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
            <li class="active">Gestion Documental</li>
            <li class="active">Reenvio de Documentos</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <!-- left column -->
            <div class="col-md-12">
              <!-- general form elements -->
              <div class="box box-primary" id="background_reenvio">
                <div class="box-header">                  
                </div><!-- /.box-header -->
                <!-- form start -->
                <form role="form" id="form_reenvio" class="" method="POST" action="">                
                  <div class="box-body">
                    <div class="form-group col-md-12">                      
                      <label for="txt_1" class="">Para: </label>                      
                      <select class="chosen-select form-control" id="txt_1" name="txt_1" multiple="" data-placeholder="Indique los usuarios a enviar ">                        
                      </select>     
                    </div>                    
                    <div class="form-group col-md-4">                            
                      <input type="hidden" id="txt_0" name="txt_0" />
                      <label for="txt_2" class="">Nombre Documento</label>                      
                      <input type="text" class="form-control" id="txt_2" name="txt_2" disabled placeholder="Nombre del documento" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">
                    </div>                                    
                    <div class="form-group col-md-4">                            
                      <label for="txt_3" class="">Asunto</label>                      
                      <input type="text" class="form-control" id="txt_3" name="txt_3" placeholder="Asunto" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">
                    </div>                
                    <div class="form-group col-md-4">                            
                      <label for="txt_4" class="">Fecha Envió</label>                      
                      <input type="text" class="form-control" id="txt_4" name="txt_4" readonly="" required pattern="[0-9 -]{10}">
                    </div>                                                                                                         
                    <div class="form-group col-md-4">                            
                      <label for="txt_5" class="">Medio de Recepción</label>                      
                      <select class="chosen-select form-control" id="txt_5" name="txt_5" data-placeholder="Medio de Recepción del documento"></select>
                    </div>                                                                                                         
                    <div class="form-group col-md-4">                            
                      <label for="txt_6" class="">Tipo de documento</label>                      
                      <select class="chosen-select form-control" id="txt_6" name="txt_6" data-placeholder="Tipo de Documento"></select>
                    </div>                                                                                                         
                    <div class="form-group col-md-4">                            
                      <label for="txt_7" class="">Estado</label>                      
                      <select class="chosen-select form-control" id="txt_7" name="txt_7" data-placeholder="Estado del Documento">
                        <option value="0">En Revisón</option>
                        <option value="1">Finalizado</option>
                      </select>
                    </div>                          
                    <div class="form-group col-md-12">                            
                      <label for="txt_9" class="">Archivo</label>                      
                      <input type="file" class="form-control" id="txt_9" name="txt_9">
                      <p class="help-block">Seleccione el archivo a enviar.</p>
                    </div>  
                    <div class="form-group col-md-6 ">
                      <label for="txt_8" class="">Historial de Observaciones</label>                                            
                      <textarea id="txt_8" disabled="" name="txt_8" rows="80" cols="50">                                            
                      </textarea>                      
                    </div>                                                                                                         
                    <div class="form-group col-md-6 ">
                      <label for="txt_10" class="">Observaciones</label>                                            
                      <textarea id="txt_10" name="txt_10" rows="50" cols="50">                                            
                      </textarea>                      
                    </div>                                                                                                         
                  </div>                                    
                  <div class="box-footer">                       
                    <button type="submit" class="btn btn-primary "  id="btn_1">
                      <span class="glyphicon glyphicon-save"></span> Reenviar Documento
                    </button>                    
                    <a type="button" href="../inbox" class="btn btn-primary" id="btn_2">
                      <span class="glyphicon glyphicon-chevron-left"></span> Regresar
                    </a>                                                            
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
    <script src="../../plugins/ckeditor/ckeditor.js"></script>
    <script src="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
    <script src="../../plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script src="../../plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='../../plugins/fastclick/fastclick.min.js'></script>    
    <script src="../../dist/js/app.min.js" type="text/javascript"></script>    
    <script src="../../plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../../plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>        

    <script src="../../plugins/input-mask/jquery.inputmask.js" type="text/javascript"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.extensions.js" type="text/javascript"></script>

    
    <script src="../../plugins/bootstrap-editable/bootstrap3-editable/js/bootstrap-editable.min.js"></script>    
    <script src="../../plugins/bootstrap-editable/bootstrap3-editable/js/address.js"></script>    
    <script src="../../plugins/jchosen/chosen.jquery.js" type="text/javascript"></script>
    <script src="../../plugins/gritter-master/js/jquery.gritter.min.js" type="text/javascript"></script>

    <script src="reenviar.js" type="text/javascript"></script>
    <script src="../mod_user.js" type="text/javascript"></script>
    <script src="../funciones_generales.js" type="text/javascript"></script>
    
    
  </body>
</html>