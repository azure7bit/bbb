$(document).ready(function () {
  $('select').chosen();
  $("#tanggal_awal").datepicker({
    dateFormat: "dd-mm-yy"
  });

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
        'item_id': $("#reports_item_id").val(),
        'supplier_id': $("#reports_supplier_id").val(),
        'customer_id': $("#reports_customer_id").val(),
        'start_date': $("#reports_start_date").val(),
        'end_date': $("#reports_end_date").val()
      }
    },
    dataType: "script",
    success: "data"
  });
});

$("#reports_report_type").change(function(){
  console.log($(this).val() == "item_by_date");
  if ($(this).val() == "item_by_date") {
    $("div.item-list").show();
    $("div.supplier-list").hide();
    $("div.customer-list").hide();
  } else if ($(this).val() == "po_by_date_and_supplier" || $(this).val() == "receive_by_date_and_supplier") {
    $("div.item-list").hide();
    $("div.supplier-list").show();
    $("div.customer-list").hide();
  } else if ($(this).val() == "sales_by_date_and_customer") {
    $("div.item-list").hide();
    $("div.supplier-list").hide();
    $("div.customer-list").show();
  } else {
    $("div.item-list").hide();
    $("div.supplier-list").hide();
    $("div.customer-list").hide();
  }
});