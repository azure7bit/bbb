$(document).ready(function () {
  $("#supplier_payment_start_date").datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function( selectedDate ) {
      $( "#supplier_payment_end_date" ).datepicker( "option", "minDate", selectedDate );
    }
  });

  $("#supplier_payment_end_date").datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function( selectedDate ) {
      $( "#supplier_payment_start_date" ).datepicker( "option", "maxDate", selectedDate );
    }
  });

  $('#supplier_payment_transaction_date').datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: function(dateText, inst) {
      $.ajax({
        url: '/return_supplier_payment_number/'+dateText,
        type: 'GET',
        success: function(data){ $("#supplier_payment_invoice_number").val(data); },
        error: function(data){}
      });
    }
  });  
});

$('.supplier-payment-show').click(function(e){
  e.preventDefault();
  $.ajax({
    type: "GET",
    url: "/supplier_payments/preview",
    data: {
      supplier_payment: {
        'supplier_id': $("#supplier_payment_supplier_id").val(),
        'start_date': $("#supplier_payment_start_date").val(),
        'end_date': $("#supplier_payment_end_date").val()
      }
    },
    dataType: "script",
    success: "data"
  });
});