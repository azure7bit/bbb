$(document).ready(function () {
  $('#po_receive_transaction_date').datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: function(dateText, inst) {
      $.ajax({
        url: '/return_receive_number/'+dateText,
        type: 'GET',
        success: function(data){ $("#po_receive_invoice_number").val(data); },
        error: function(data){}
      });
    }
  });

  $('#purchase_order_po_date').datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: function(dateText, inst) {
      $.ajax({
        url: '/return_po_number/'+dateText,
        type: 'GET',
        success: function(data){ $("#purchase_order_po_number").val(data); },
        error: function(data){}
      });
    }
  });

  $(".addItem").click(function() {
    var supplier_id = $("#purchase_order_supplier_id").val();
    if(supplier_id){
      $.ajax({
        url: '/purchase_orders/new',
        type: 'GET',
        data: {
          sp_id: supplier_id
        },
        success: function(data){},
        error: function(data){},
      });
    }
  });
});