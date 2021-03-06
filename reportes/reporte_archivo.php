<?php
    require('../fpdf/fpdf.php');
    include '../data/conexion.php';    
    include '../data/funciones_generales.php';    
    conectarse();    
    date_default_timezone_set('America/Guayaquil'); 
    session_start()   ;
    class PDF extends FPDF{   
        var $widths;
        var $aligns;       
        function SetWidths($w){            
            $this->widths=$w;
        }                       
        function Header(){                         
            $this->AddFont('Amble-Regular','','Amble-Regular.php');
            $this->SetFont('Amble-Regular','',10);        
            $fecha = date('Y-m-d', time());
            $this->SetX(1);
            $this->SetY(1);
            $this->Cell(20, 5, $fecha, 0,0, 'C', 0);                                                 
            $this->Cell(150, 5, "CLIENTE", 0,1, 'R', 0);                  
            
            $this->Image('../img/logo_uniandes.png',5,8,40,20);
            $this->SetFont('Arial','B',16);                                                                

            $this->SetX(90);            
            $this->Cell(190, 8, "UNIANDES IBARRA", 0,1, 'L',0);                                
            $this->SetFont('Amble-Regular','',10);                             
            $this->SetX(50);            
            $this->Cell(145, 5, "Solicitante: ".maxCaracter(utf8_decode($_SESSION['nombres_gestion']),50),0,1, 'C',0);

            $this->SetX(50);            
            $this->Cell(70, 5, "Cargo: ".maxCaracter(utf8_decode($_SESSION['cargo']),30),0,0, 'R',0);                                
            $this->Cell(70, 5, "Usuario: ".maxCaracter(utf8_decode($_SESSION['usuario_gestion']),30),0,1, 'L',0);
            $this->SetDrawColor(0,0,0);
            $this->SetLineWidth(0.4);            
            $this->Line(1,30,210,30);            
            $this->SetFont('Arial','B',12);                                                                            
            $this->SetX(50);            
            $this->Cell(190, 5, utf8_decode("REPORTE POR TIPOS DE ARCHIVOS " . maxCaracter(strtoupper($_GET['val']),28)),0,1, 'L',0);                                                                                                                            
            $this->SetFont('Amble-Regular','',10);        
            $this->Ln(3);
            $this->SetFillColor(255,255,225);            
            $this->SetLineWidth(0.2);                                        
        }
        function Footer(){            
            $this->SetY(-15);            
            $this->SetFont('Arial','I',8);            
            $this->Cell(0,10,'Pag. '.$this->PageNo().'/{nb}',0,0,'C');
        }               
    }
    $pdf = new PDF('P','mm','a4');
    $pdf->AddPage();
    $pdf->SetMargins(0,0,0,0);
    $pdf->AliasNbPages();
    $pdf->AddFont('Amble-Regular','','Amble-Regular.php');
    $pdf->SetFont('Amble-Regular','',10);       
    $pdf->SetFont('Arial','B',9);   
    $pdf->SetX(5);    
    $pdf->SetFont('Amble-Regular','',9); 
    
    $temp1=$_GET['inicio']." "."00:00:00";
    $temp2=$_GET['fin']." "."23:59:59";
    
    if($_SESSION['tipo_user'] == '1'){
        $sql = "select nombres_usuario,nombre_archivo,fecha_cambios,asunto_cambio,nombre_medio,nombre_doc,archivo.estado from archivo,bitacora,usuario,tipo_documento,medio_recepcion where archivo.id_archivo = bitacora.id_archivo and bitacora.id_tipo_documento =tipo_documento.id_tipo_documento and bitacora.id_medio_recepcion = medio_recepcion.id_medio and bitacora.id_usuario = usuario.id_usuario and bitacora.tipo = '".$_GET['tipo']."'";
    }else{
        $sql = "select nombres_usuario,nombre_archivo,fecha_cambios,asunto_cambio,nombre_medio,nombre_doc,archivo.estado from archivo,bitacora,usuario,tipo_documento,medio_recepcion where archivo.id_archivo = bitacora.id_archivo and bitacora.id_tipo_documento =tipo_documento.id_tipo_documento and bitacora.id_medio_recepcion = medio_recepcion.id_medio and bitacora.id_usuario = usuario.id_usuario and usuario.id_usuario = '".$_SESSION['id_gestion']."' and bitacora.tipo = '".$_GET['tipo']."'";    
    }
    $sql = pg_query($sql);
    $repetido = 0;

    $pdf->Ln(2);   
    $pdf->SetX(1);
    $pdf->SetFillColor(92, 146, 178);             
    $pdf->Cell(40, 6, utf8_decode('USUARIO'),1,0, 'C',1);                                     
    $pdf->Cell(43, 6, utf8_decode('ARCHIVO'),1,0, 'C',1);                                     
    $pdf->Cell(25, 6, utf8_decode('FECHA'),1,0, 'C',1);                                                             
    $pdf->Cell(45, 6, utf8_decode('ASUNTO'),1,0, 'C',1); 
    $pdf->Cell(34, 6, utf8_decode('MEDIO'),1,0, 'C',1);     
    $pdf->Cell(20, 6, utf8_decode('ESTADO'),1,1, 'C',1);    

    $total = 0;
    while($row=pg_fetch_row($sql)){                                                      
        $pdf->SetX(1); 
        $pdf->Cell(40, 6, maxCaracter(utf8_decode($row[0]),24),0,0, 'L',0);                                     
        $pdf->Cell(43, 6, maxCaracter(utf8_decode($row[1]),22),0,0, 'L',0);
        $pdf->Cell(25, 6, maxCaracter(utf8_decode($row[2]),10),0,0, 'C',0);
        $pdf->Cell(45, 6, maxCaracter(utf8_decode($row[3]),25),0,0, 'L',0);                        
        $pdf->Cell(34, 6, maxCaracter(utf8_decode($row[5]),20),0,0, 'L',0);
        if($row[6] == 0){
            $pdf->Cell(20, 6, utf8_decode('En revisión'),0,1, 'C',0);                
        }else{
            $pdf->Cell(20, 6, utf8_decode('Finalizado'),0,1, 'C',0);            
        }                                           
    }                       
    $pdf->Cell(220, 0,"",1,1, 'L',0);                                         
    $pdf->Output();
?>


