$(document).ready(function () {
  $("#customer_payment_start_date").datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function( selectedDate ) {
      $( "#customer_payment_end_date" ).datepicker( "option", "minDate", selectedDate );
    }
  });

  $("#customer_payment_end_date").datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function( selectedDate ) {
      $( "#customer_payment_start_date" ).datepicker( "option", "maxDate", selectedDate );
    }
  });

  $('#customer_payment_transaction_date').datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: function(dateText, inst) {
      $.ajax({
        url: '/return_customer_payment_number/'+dateText,
        type: 'GET',
        success: function(data){ $("#customer_payment_invoice_number").val(data); },
        error: function(data){}
      });
    }
  });  
});

$('.customer-payment-show').click(function(e){
  e.preventDefault();
  $.ajax({
    type: "GET",
    url: "/customer_payments/preview",
    data: {
      customer_payment: {
        'customer_id': $("#customer_payment_customer_id").val(),
        'start_date': $("#customer_payment_start_date").val(),
        'end_date': $("#customer_payment_end_date").val()
      }
    },
    dataType: "script",
    success: "data"
  });
});