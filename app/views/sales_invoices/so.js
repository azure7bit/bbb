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

  function selectedCurrency() {
    $(".fields").each(function(index, value) {
      var valas_price = $($(this).find('input')[1]).val();
      var idr_price = $($(this).find('input')[2]).val();
      var qty = $($(this).find('input')[3]).val();
      if ($("#to_idr").prop('checked')) {
        $($(this).find('input')[4]).val(qty * idr_price)
      } else {
        $($(this).find('input')[4]).val(qty * valas_price)
      }
    });
    calculateTotal();
  }
});