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
            $this->Cell(190, 5, utf8_decode("REPORTE POR FECHAS ".$_GET['inicio']." DESDE HASTA ".$_GET['fin'].""),0,1, 'L',0);                                                                                                                            
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
        $sql = "select id_archivo,nombre_archivo,codigo_archivo,fecha_creacion,estado from archivo where fecha_creacion between '".$temp1."' and '".$temp2."'  order by fecha_creacion asc";
    }else{
        $sql = "select id_archivo,nombre_archivo,codigo_archivo,fecha_creacion,estado from archivo where fecha_creacion between '".$temp1."' and '".$temp2."'  and fuente_usuario = '".$_SESSION['id_gestion']."' order by fecha_creacion asc";    
    }
    $sql = pg_query($sql);
    $repetido = 0;

    $pdf->Ln(2);   
    $pdf->SetX(1);
    $pdf->SetFillColor(92, 146, 178);             
    $pdf->Cell(68, 6, utf8_decode('ARCHIVO'),1,0, 'C',1);                                     
    $pdf->Cell(50, 6, utf8_decode('CODIGO '),1,0, 'C',1);                                     
    $pdf->Cell(50, 6, utf8_decode('FECHA CREACION'),1,0, 'C',1);                                                             
    $pdf->Cell(40, 6, utf8_decode('ESTADO'),1,1, 'C',1); 
    while($row=pg_fetch_row($sql)){                                                      
        $pdf->SetX(1); 
        $pdf->Cell(68, 6, maxCaracter(utf8_decode($row[1]),37),0,0, 'L',0);                                     
        $pdf->Cell(50, 6, maxCaracter(utf8_decode($row[2]),25),0,0, 'C',0);                                     
        $pdf->Cell(50, 6, utf8_decode($row[3]),0,0, 'C',0);                                                             
        if($row[4] == 0){
            $pdf->Cell(40, 6, utf8_decode('En revisión'),0,1, 'C',0);                
        }else{
            $pdf->Cell(40, 6, utf8_decode('Finalizado'),0,1, 'C',0);            
        }                    
        /////////////detalles de los envios
        // $sql_1 = "select nombres_usuario,bitacora.fecha_cambios,bitacora.asunto_cambio,referencia,peso,tipo from bitacora,tipo_documento,medio_recepcion,usuario where bitacora.id_usuario = usuario.id_usuario and bitacora.id_tipo_documento = tipo_documento.id_tipo_documento and bitacora.id_medio_recepcion = medio_recepcion.id_medio and bitacora.id_archivo = '".$row[0]."' order by bitacora.fecha_cambios asc";        
        // $sql_1 = pg_query($sql_1);
        // while($row_1 = pg_fetch_row($sql_1)){
        //     if($repetido == 0){                
        //         $pdf->Ln(2);   
        //         $pdf->SetX(1); 
        //         $pdf->Cell(208.2, 6, utf8_decode('BITACORA DEL ARCHIVO:'),0,1, 'C',1);                                     
        //         $pdf->SetX(1); 
        //         $pdf->Cell(48, 6, utf8_decode('USUARIO'),0,0, 'C',1);                                     
        //         $pdf->Cell(35, 6, utf8_decode('FEHCA CAMBIO '),0,0, 'C',1);                                     
        //         $pdf->Cell(40, 6, utf8_decode('ASUNTO CAMBIO'),0,0, 'C',1);
        //         $pdf->Cell(35, 6, utf8_decode('REFERENCIA'),0,0, 'C',1);                              
        //         $pdf->Cell(25, 6, utf8_decode('PESO'),0,0, 'C',1);                              
        //         $pdf->Cell(25, 6, utf8_decode('TIPO DOC.'),0,1, 'C',1);    
        //         $repetido = 1; 

        //         $pdf->SetX(1);      
        //         $pdf->Cell(208, 0, "",1,1, 'L',0);                                       
        //         $pdf->SetX(1);      
        //         $pdf->Cell(208, 0, "",1,1, 'L',0);                                       
        //         $pdf->Ln(2);         

        //     } 
        //     $pdf->SetX(1); 
        //     $pdf->Cell(48, 6, maxCaracter(utf8_decode($row_1[0]),30),0,0, 'L',0);                                     
        //     $pdf->Cell(35, 6, maxCaracter(utf8_decode($row_1[1]),19),0,0, 'C',0);                                     
        //     $pdf->Cell(40, 6, maxCaracter(utf8_decode($row_1[2]),20),0,0, 'L',0);
        //     $pdf->Cell(35, 6, maxCaracter(utf8_decode($row_1[3]),20),0,0, 'C',0);                              
        //     $pdf->Cell(25, 6, maxCaracter(number_format(($row_1[4] / 1024 / 1024),3,',','.') ,10)." Mb",0,0, 'C',0);
        //     $pdf->Cell(25, 6, maxCaracter(utf8_decode($row_1[5]),5),0,1, 'C',0);            
        // }          
        $pdf->Ln(2);         
        
    }
                   
    $pdf->Output();
?>
