$(document).ready(function () {
  $("#reports_start_date").datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function( selectedDate ) {
      $( "#reports_end_date" ).datepicker( "option", "minDate", selectedDate );
    }
  });

  $("#reports_end_date").datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function( selectedDate ) {
      $( "#reports_start_date" ).datepicker( "option", "maxDate", selectedDate );
    }
  });
});

$('.report-preview-submit').click(function(e){
  e.preventDefault();
  $.ajax({
    type: "GET",
    url: "/reports/preview",
    data: {
      reports: {
        'report_type': $("#reports_report_type").val(),
        'start_date': $("#reports_start_date").val(),
        'end_date': $("#reports_end_date").val()
      }
    },
    dataType: "script",
    success: "data"
  });
});