$(document).ready(function() {
  $("#customer_delete_all").bind('click',function(event){
    event.stopPropagation();
    var values = $('input:checkbox:checked.cls_customer_ids').map(function () {
      return parseInt(this.value);
    }).get();
    if (values.length == 0){alert("Please choose customer(s) to delete."); return false}
    else{ var r=confirm("Are you sure you will delete these data?");}
    if (r==true){
      $.ajax({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        url: "/customers/delete_all",
        type: 'DELETE',
        dataType: 'json',
        data: { id_all: values },
        success: function(data) {
          window.location.reload();
        },
        error: function(data){}
      });
    }
  });

  $("#sales_invoice_customer_id").change(function() {
    if($(this).val()) {
      $.ajax({
        url: '/sales_invoices/customer_info',
        type: 'GET',
        data: {
          sales_invoices: {
            'customer_id' : $(this).val()
          }
        },
        success: function(data) {
          $("textarea#sales_invoice_customer_address").val(data.address);
          $("input#sales_invoice_customer_phone").val(data.phone_number);
          $(".addItem").show();
        },
        error: function(data){},
      });
    } else {
      $("textarea#sales_invoice_customer_address").val("");
      $("input#sales_invoice_customer_phone").val("");
      $(".addItem").hide();
    }
  });

  $('.discount').keyup(function() {
    var total = $('.total_invoice').val();
    if(this.value < total){
      var value = total - $(this).val();
      $('.grand_total_invoice').val(value);
      return false;
    }else{alert('harus kurang dari grand_total'); this.value = 0; return;}
  });

  $('.down_payment').keyup(function(event) {
    var total = $('.total_invoice').val();
    if(this.value < total){
      var value = total - $(this).val();
      $('.grand_total_invoice').val(value);
      return false;
    }else{alert('harus kurang dari grand_total'); this.value = 0; return;}
  });
});