<?php include('../menu/menu.php'); ?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>.:VISTA ARCHIVO:.</title>
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
          Gestión Documental 
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
            <li class="active">Gestion Documental</li>
            <li class="active">Vista Previa</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <div class="col-md-3">
              <a href="../envio/index.php" class="btn btn-primary btn-block margin-bottom">Enviar Correo</a>
              <div class="box box-solid">
                <div class="box-header with-border">
                  <h3 class="box-title">Carpetas</h3>
                </div>
                <div class="box-body no-padding">
                  <ul class="nav nav-pills nav-stacked">
                    <li><a href="../inbox"><i class="fa fa-inbox"></i> Recibidos <span class="label label-primary pull-right" id="total_inbox"></span></a></li>
                    <li class=""><a href="enviados.php" ><i class="fa fa-envelope-o"></i> Enviados <span class="label label-success pull-right" id="total_enviados"></span></a></li>       
                    <li class=""><a href="#"><i class="fa fa-list-alt"></i> Historial</a></li>  
                    <li class="active"><a href=""><i class="fa fa-folder-open-o"></i> Vista Previa</a></li>                                                                                                    
                    <li class=""><a href="buscar_archivos.php"><i class="fa fa-search-minus"></i> Búsqueda de Archivos</a></li>  
                  </ul>
                </div><!-- /.box-body -->
              </div><!-- /. box -->
              <div class="box box-solid">                                
              <!-- en caso de nuevas opciones -->
              </div><!-- /.box -->
            </div><!-- /.col -->
             <div class="col-md-9">
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Vista Documento</h3>
                  
                </div><!-- /.box-header -->
                <div class="box-body no-padding">
                  <div class="mailbox-read-info">
                    <h3 id="subject"></h3><!--asunto del mensaje-->
                    <span class="mailbox-read-time pull-right" id="date_mail"></span>
                    <h5 id="from_mail"></h5>
                  </div><!-- /.mailbox-read-info -->
                  
                  <div class="mailbox-read-message" id="cuerpo_mail" >
                    
                  </div><!-- /.mailbox-read-message -->
                </div><!-- /.box-body -->
                <div class="box-footer">
                  <ul class="mailbox-attachments clearfix" id="footer_mail">
                    
                  </ul>                   
                </div><!-- /.box-footer -->
                <div class="box-footer">                  
                  <a class="btn btn-primary" id="btn_reenviar"><i class="fa fa-edit"></i> Reenviar</a>
                  <button class="btn btn-primary"><i class="fa fa-print"></i> Imprimir</button>
                </div><!-- /.box-footer-->
              </div><!-- /. box -->
            </div><!-- /.col -->
          </div><!-- /.row -->  
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
    <script src="../../plugins/moment/moment-with-locales.js" type="text/javascript"></script>
    <script src="inbox.js" type="text/javascript"></script> 
    <script src="../mod_user.js" type="text/javascript"></script>
    <script src="../funciones_generales.js" type="text/javascript"></script>
    
    <script>
      $(function () {
        //Enable iCheck plugin for checkboxes
        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"]').iCheck({
          checkboxClass: 'icheckbox_flat-blue',
          radioClass: 'iradio_flat-blue'
        });

        //Enable check and uncheck all functionality
        $(".checkbox-toggle").click(function () {
          var clicks = $(this).data('clicks');
          if (clicks) {
            //Uncheck all checkboxes
            $("input[type='checkbox']", ".mailbox-messages").iCheck("uncheck");
          } else {
            //Check all checkboxes
            $("input[type='checkbox']", ".mailbox-messages").iCheck("check");
          }
          $(this).data("clicks", !clicks);
        });

        //Handle starring for glyphicon and font awesome
        $(".mailbox-star").click(function (e) {
          e.preventDefault();
          //detect type
          var $this = $(this).find("a > i");
          var glyph = $this.hasClass("glyphicon");
          var fa = $this.hasClass("fa");          

          //Switch states
          if (glyph) {
            $this.toggleClass("glyphicon-star");
            $this.toggleClass("glyphicon-star-empty");
          }

          if (fa) {
            $this.toggleClass("fa-star");
            $this.toggleClass("fa-star-o");
          }
        });
      });
    </script>
  </body>
</html>