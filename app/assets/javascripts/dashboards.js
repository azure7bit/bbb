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
        tickInterval: data.first_interval,
        pointStart: data.point_start,
        name : 'Total',
        data : data.ordered,
        tooltip: {
          valueDecimals: 2
        }
      }]
    });
    $('#containerSO').highcharts('StockChart', {
      rangeSelector : {
        selected : 1
      },
      title : {
        text : 'Sales Order History'
      },
      series : [{
        tickInterval: data.first_interval,
        pointStart: data.point_start,
        name : 'Total',
        data : data.ordered,
        tooltip: {
          valueDecimals: 2
        }
      }]
    });
  });
});