$(document).ready(function () {
  $('#sales_invoice_transaction_date').datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: function(dateText, inst) {
      $.ajax({
        url: '/return_so_number/'+dateText,
        type: 'GET',
        success: function(data){ $("#sales_invoice_invoice_number").val(data); },
        error: function(data){}
      });
    }
  });

  $("#to_idr").click(function() {
    selectedCurrency();
  });
});