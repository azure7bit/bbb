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
});