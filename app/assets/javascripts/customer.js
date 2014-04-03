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

  $("input.number").keydown(function(event) {
    if ( $.inArray(event.keyCode,[46,8,9,27,13,190]) !== -1 ||
      (event.keyCode == 65 && event.ctrlKey === true) || 
      (event.keyCode >= 35 && event.keyCode <= 39)) {
      return;
    }
    else {
      if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
        event.preventDefault(); 
      }
    }
  });

  $("input.number").bind('copy paste cut',function(e) {
    e.preventDefault();
    return !!String.fromCharCode(e.which).match(/^\d$/);
    this.value = this.value.replace(/[^\d].+/, "");
  });

  $('#customer_phone_number').keypress(function() {
    $(this).unsetMask();
    $(this).setMask("(99) 9999-9999-9999");
  });
  
});