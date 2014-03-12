$(function() {
  $.getJSON('/po_history', function(data) {
    $('#containerPO').highcharts('StockChart', {
      rangeSelector : {
        selected : 1
      },
      title : {
        text : 'Purchase Order History'
      },
      series : [{
        name : 'Total',
        marker:{
          enabled:true,
          symbol:"diamond",
          radius:5
        },
        lineWidth: 1,
        data : data,
        tooltip: {
          valueDecimals: 2
        }
      }]
      }, function(chart) {
      // apply the date pickers
      setTimeout(function() {
        $('input.highcharts-range-selector', $('#containerPO')).datepicker()
      }, 0)
    });
  });

  $.getJSON('/sales_history', function(data) {
    $('#containerSO').highcharts('StockChart', {
      rangeSelector : {
        selected : 1
      },
      title : {
        text : 'Sales Order History'
      },
      series : [{
        name : 'Total',
        marker:{
          enabled:true,
          symbol:"diamond",
          radius:5
        },
        lineWidth: 1,
        data : data,
        tooltip: {
          valueDecimals: 2
        }
      }]
    });
  });

  // Set the datepicker's date format
  $.datepicker.setDefaults({
    onSelect: function(dateText) {
        this.onchange();
        this.onblur();
    }
  });  
});


// $(function() {
//   var seriesOptions = [],
//     yAxisOptions = [],
//     seriesCounter = 0,
//     names = ['Pembelian', 'Penjualan'],
//     colors = Highcharts.getOptions().colors;

//   $.each(names, function(i, name) {

//     $.getJSON('/po_history', function(data) {

//       seriesOptions[i] = {
//         name: name,
//         data: data
//       };

//       // As we're loading the data asynchronously, we don't know what order it will arrive. So
//       // we keep a counter and create the chart when all the data is loaded.
//       seriesCounter++;

//       if (seriesCounter == names.length) {
//         createChart();
//       }
//     });
//   });



//   // create the chart when all data is loaded
//   function createChart() {

//     $('#containerPO').highcharts('StockChart', {
//         chart: {
//         },

//         rangeSelector: {
//           selected: 1
//         },

//         yAxis: {
//           labels: {
//             formatter: function() {
//               return (this.value > 0) + this.value;
//             }
//           },
//           plotLines: [{
//             value: 0,
//             width: 2,
//             color: 'silver'
//           }]
//         },
        
//         tooltip: {
//           valueDecimals: 2
//         },
        
//         series: seriesOptions
//     });
//   }

// });