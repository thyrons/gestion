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
            Ingreso de Usuarios            
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
            <li class="active">Ingresos</li>
            <li class="active">Usuarios</li>
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
                  <h3 class="box-title">Ingreso de Usuarios</h3>
                </div><!-- /.box-header -->
                <!-- form start -->
                <form role="form" id="form_usuarios" class="" method="POST" action="">                
                  <div class="box-body">                                         
                    <div class="form-group col-md-4">                    
                      <label for="txt_1" class="">T. Documento</label>                      
                      <select class="chosen-select form-control" id="txt_1" name="txt_1" data-placeholder="Seleccione un tipo de documento">
                        <option value="Cédula">Cédula</option>
                        <option value="Ruc">Ruc</option>
                        <option value="Pasaporte">Pasaporte</option>
                      </select>     
                      <input type="hidden" id="txt_0" name="txt_0" />                                         
                    </div>                  
                    <div class="form-group col-md-4">
                      <label for="txt_2" class="">Número Documento</label>
                      <input type="text" class="form-control" id="txt_2" name="txt_2" placeholder="Nro. documento" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">                      
                    </div>
                    <div class="form-group col-md-4">
                      <label for="txt_3" class="">Nombres Completos</label>                      
                      <input type="text" class="form-control" id="txt_3" name="txt_3" placeholder="Nombres Completos" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">                      
                    </div>     
                    <div class="form-group col-md-4">                            
                      <label for="txt_4" class="">País</label>                      
                      <select class="chosen-select form-control" id="txt_4" name="txt_4" data-placeholder="Seleccione un País">
                      </select>                      
                    </div>              
                    <div class="form-group col-md-4">                            
                      <label for="txt_5" class="">Provincia/Estado</label>                      
                      <select class="chosen-select form-control" id="txt_5" name="txt_5" data-placeholder="Seleccione una Provincia">
                      </select>                      
                    </div>              
                    <div class="form-group col-md-4">                            
                      <label for="txt_6" class="">Ciudades</label>                      
                      <select class="chosen-select form-control" id="txt_6" name="txt_6" data-placeholder="Seleccione una ciudad">
                      </select>                      
                    </div>                            
                    <div class="form-group col-md-4">
                      <label  class="" for="txt_7">Nro. Teléfono</label>                      
                      <div class="input-group">
                        <div class="input-group-addon">
                          <i class="fa fa-phone"></i>
                        </div>
                        <input type="text" class="form-control" data-inputmask='"mask": "(999) 999-999"' data-mask id="txt_7" name="txt_7" />
                      </div><!-- /.input group -->                      
                    </div><!-- /.form group -->  
                    <div class="form-group col-md-4">
                      <label  class="" for="txt_8">Nro. Celular</label>                      
                      <div class="input-group">
                        <div class="input-group-addon">
                          <i class="fa fa-phone"></i>
                        </div>
                        <input type="text" class="form-control" data-inputmask='"mask": "(99) 99999999"' data-mask id="txt_8" name="txt_8" />
                      </div><!-- /.input group -->                      
                    </div><!-- /.form group -->  
                    <div class="form-group col-md-4">                            
                      <label for="txt_9" class="">Dirección</label>                      
                      <input type="text" class="form-control" id="txt_9" name="txt_9" placeholder="Dirección del usuario" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">
                    </div>                                                                                                         
                    <div class="form-group col-md-4">                            
                      <label for="txt_10" class="">Tipo Usuario</label>                      
                      <select class="chosen-select form-control" id="txt_10" name="txt_10" data-placeholder="Seleccione un Tipo de Usuario">
                      </select>                      
                    </div>     
                    <div class="form-group col-md-4">                            
                      <label for="txt_11" class="">Categoría Usuario</label>                      
                      <select class="chosen-select form-control" id="txt_11" name="txt_11" data-placeholder="Seleccione una categoría de Usuario">
                      </select>                      
                    </div>                                                       
                    <div class="form-group col-md-4">                            
                      <label for="txt_12" class="">Departamento</label>                      
                      <select class="chosen-select form-control" id="txt_12" name="txt_12" data-placeholder="Seleccione una Departamento Administrativo">
                      </select>                      
                    </div>  
                    <div class="form-group col-md-4">                            
                      <label for="txt_13" class="">Nombre Usuario</label>                      
                      <input type="text" class="form-control" id="txt_13" name="txt_13" placeholder="Nombre del Usuario" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">
                    </div>  
                    <div class="form-group col-md-4">                            
                      <label for="txt_14" class="">Clave</label>                      
                      <input type="password" class="form-control" id="txt_14" name="txt_14" placeholder="Clave del usuario" required pattern="[=/*+A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">
                    </div>  
                    <div class="form-group col-md-4">                            
                      <label for="txt_15" class="">Repetir Clave</label>                      
                      <input type="password" class="form-control" id="txt_15" name="txt_15" placeholder="Repetir clave del usuario" required pattern="[=/*+A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}">
                    </div>
                    <div class="form-group col-md-8">                            
                      <label for="txt_16" class="">Institución</label>                      
                      <input type="text" class="form-control" id="txt_16" name="txt_16" placeholder="Institución a la que pertenece" required pattern="[A-Za-záéíóúÁÉÍÓÚñÑ0-9. ]{1,}" value="Uniandes Ibarra">
                    </div>  
                    <div class="form-group col-md-4">                            
                      <label for="txt_17" class="">E-mail</label>                      
                      <input type="text" class="form-control" id="txt_17" name="txt_17" placeholder="Cuenta de correo electróncio">
                    </div>  
                  </div>                  
                  <div class="box-footer">                       
                    <button type="submit" class="btn btn-primary "  id="btn_1">
                      <span class="glyphicon glyphicon-save"></span> Guardar
                    </button>                    
                    <button type="button" class="btn btn-primary" id="btn_2">
                      <span class="glyphicon glyphicon-paperclip"></span> Limpiar
                    </button>                    
                    <button type="button" class="btn btn-primary" id="btn_3">
                      <span class="glyphicon glyphicon-arrow-left"></span> Atras 
                    </button>                    
                    <button type="button" class="btn btn-primary" id="btn_4">
                      Adelante <span class="glyphicon glyphicon-arrow-right"></span>
                    </button>                                                            
                    <button type="button" class="btn btn-primary" id="btn_5" data-toggle="modal" data-target="#modal_usuarios">
                      <span class="glyphicon glyphicon-search"></span> Buscar
                    </button>                                        
                  </div>                  
                </form>
              </div><!-- /.box -->              
                                 
            </div><!--/.col (left) -->
            <!-- right column -->            
          </div>   <!-- /.row -->
        </section>
        <div class="modal fade" id="modal_usuarios">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Búsqueda de Usuarios</h4>
              </div>
              <div class="modal-body">              
                  
                  <table id="tabla_usuarios" class="table table-striped table-bordered" cellspacing="0" width="100%">
                  <thead>
                    <th>ID</th>
                    <th>CODÍGO</th>
                    <th>NOMBRES</th>
                    <th>DIRECCIÓN</th>
                    <th>id_ciudad</th>                     
                    <th>CIUDAD</th>
                    <th>id_provincia</th>                     
                    <th>PROVINCIA</th>
                    <th>id_pais</th>                     
                    <th>PAIS</th>
                    <th>TELÉFONO</th>                     
                    <th>CELULAR</th>
                    <th>E-MAIL</th>                     
                    <th>id_tipo_user</th>
                    <th>TIPO USUARIO</th>                     
                    <th>USUARIO</th>
                    <th>INSTITUCIÓN</th>                     
                    <th>id_categoria</th>
                    <th>CATEGORÍA</th>                     
                    <th>id_departamento</th>
                    <th>DEPARTAMENTO</th>                     
                    <th>FECHA</th>
                    <th>T. DOC.</th>                     
                    <th>DOCUMENTO</th>
                    <th>CLAVE</th>
                  </thead>
                  <tbody>                      
                  </tbody>
                  </table>                                        
              </div>
              
              <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cerrar</button>                
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
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

    <script src="../../plugins/input-mask/jquery.inputmask.js" type="text/javascript"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.extensions.js" type="text/javascript"></script>

    
    <script src="../../plugins/bootstrap-editable/bootstrap3-editable/js/bootstrap-editable.min.js"></script>    
    <script src="../../plugins/bootstrap-editable/bootstrap3-editable/js/address.js"></script>    
    <script src="../../plugins/jchosen/chosen.jquery.js" type="text/javascript"></script>
    <script src="../../plugins/gritter-master/js/jquery.gritter.min.js" type="text/javascript"></script>

    <script src="usuarios.js" type="text/javascript"></script>
    <script src="../mod_user.js" type="text/javascript"></script>
    <script src="../funciones_generales.js" type="text/javascript"></script>
    
    
  </body>
</html>