  $(document).on("ready",inicio);
  function inicio(){  
    var areaChartCanvas = $("#areaChart").get(0).getContext("2d");        
    var areaChart = new Chart(areaChartCanvas);       
    
    var areaChartCanvas_peso = $("#areaChart_peso").get(0).getContext("2d");    
    var areaChart_peso = new Chart(areaChartCanvas_peso);      

    var areaChartCanvas_tipo_doc = $("#areaChart_tipos_doc ").get(0).getContext("2d");    
    var areaChart_tipos_doc = new Chart(areaChartCanvas_tipo_doc);      

    //var areaChartCanvas_estado = $("#areaChart_estado ").get(0).getContext("2d");    
    //var areaChart_estado = new Chart(areaChartCanvas_estado);          

    var areaChartCanvas_estado = $("#areaChart_estado").get(0).getContext("2d");
    var areaChart_estado = new Chart(areaChartCanvas_estado);
  
    var areaChartOptions = {
      //Boolean - If we should show the scale at all
      showScale: true,
      //Boolean - Whether grid lines are shown across the chart
      scaleShowGridLines: false,
      //String - Colour of the grid lines
      scaleGridLineColor: "rgba(0,0,0,.05)",
      //Number - Width of the grid lines
      scaleGridLineWidth: 1,
      //Boolean - Whether to show horizontal lines (except X axis)
      scaleShowHorizontalLines: true,
      //Boolean - Whether to show vertical lines (except Y axis)
      scaleShowVerticalLines: true,
      //Boolean - Whether the line is curved between points
      bezierCurve: true,
      //Number - Tension of the bezier curve between points
      bezierCurveTension: 0.3,
      //Boolean - Whether to show a dot for each point
      pointDot: false,
      //Number - Radius of each point dot in pixels
      pointDotRadius: 4,
      //Number - Pixel width of point dot stroke
      pointDotStrokeWidth: 1,
      //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
      pointHitDetectionRadius: 20,
      //Boolean - Whether to show a stroke for datasets
      datasetStroke: true,
      //Number - Pixel width of dataset stroke
      datasetStrokeWidth: 2,
      //Boolean - Whether to fill the dataset with a color
      datasetFill: true,
      //String - A legend template
      legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>",
      //Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
      maintainAspectRatio: false,
      //Boolean - whether to make the chart responsive to window resizing
      responsive: true
    };  
    ///////////total de envios por mes
    $.ajax({        
      type: "POST",
      url: "../varios.php?tipo=0&fun=35",
      dataType: 'json',
      success: function(data) { 
        var areaChartData = {
          labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
          datasets: [
            {
              label: "Meses de envio",
              fillColor: "rgba(60,141,188,0.8)",
              strokeColor: "rgba(60,141,188,0.8)",
              pointColor: "#3b8bba",
              pointStrokeColor: "rgba(60,141,188,1)",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(60,141,188,1)",
              data: data,
            },                        
          ]
        };
        areaChart.Line(areaChartData, areaChartOptions);                       
      }
    });    
    ////////total de kbs por mes
    $.ajax({        
      type: "POST",
      url: "../varios.php?tipo=0&fun=36",
      dataType: 'json',
      success: function(data) { 

        var areaChartData = {
          labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
          datasets: [
            {
              label: "Peso Meses de envio",
              fillColor: "rgba(60,141,188,0.9)",
              strokeColor: "rgba(60,141,188,0.8)",
              pointColor: "#3b8bba",
              pointStrokeColor: "rgba(60,141,188,1)",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(60,141,188,1)",
              data: data,
            },            
          ]
        };
        areaChart_peso.Line(areaChartData, areaChartOptions);                       
      }
    }); 
    ////////total tipos de documentos de kbs por mes
    $.ajax({        
      type: "POST",
      url: "../varios.php?tipo=0&fun=37",
      dataType: 'json',
      success: function(data) {         
        var areaChartData = {
          labels: data['departamento'],
          datasets: [
            {
              label: "Peso Meses de envio",
              fillColor: "rgba(60,141,188,0.9)",
              strokeColor: "rgba(60,141,188,0.8)",
              pointColor: "#3b8bba",
              pointStrokeColor: "rgba(60,141,188,1)",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(60,141,188,1)",
              data: data['peso'],
            },            
          ]
        };
        areaChart_tipos_doc.Line(areaChartData, areaChartOptions);                       
      }
    }); 
     ////////estado de los documentos
    $.ajax({        
      type: "POST",
      url: "../varios.php?tipo=0&fun=38",
      dataType: 'json',
      success: function(data) { 
        console.log(data);
        var PieData = [
          {
            value: parseInt(data[0]),
            color: "#f56954",
            highlight: "#f56954",
            label: "En Revisión"
          },
          {
            value: parseInt(data[1]),
            color: "#00a65a",
            highlight: "#00a65a",
            label: "Finalizado"
          },         
        ];
        var pieOptions = {
          //Boolean - Whether we should show a stroke on each segment
          segmentShowStroke: true,
          //String - The colour of each segment stroke
          segmentStrokeColor: "#fff",
          //Number - The width of each segment stroke
          segmentStrokeWidth: 2,
          //Number - The percentage of the chart that we cut out of the middle
          percentageInnerCutout: 0, // This is 0 for Pie charts
          //Number - Amount of animation steps
          animationSteps: 100,
          //String - Animation easing effect
          animationEasing: "easeOutBounce",
          //Boolean - Whether we animate the rotation of the Doughnut
          animateRotate: true,
          //Boolean - Whether we animate scaling the Doughnut from the centre
          animateScale: false,
          //Boolean - whether to make the chart responsive to window resizing
          responsive: true,
          // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
          maintainAspectRatio: false,
          //String - A legend template
          legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
        };
        areaChart_estado.Doughnut(PieData, pieOptions);
      }
    }); 

  }
     