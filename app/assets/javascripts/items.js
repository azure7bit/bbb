$(document).ready(function() {
  $("#item_delete_all").bind('click',function(event){
    event.stopPropagation();
    var values = $('input:checkbox:checked.cls_item_ids').map(function () {
      return parseInt(this.value);
    }).get();
    if (values.length == 0){alert("Please choose item(s) to delete."); return false}
    else{ var r=confirm("Are you sure you will delete these data?");}
    if (r==true){
      $.ajax({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        url: "/items/delete_all",
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

  $('.submit_manage').click(function(e){
    e.preventDefault();
    var item = $('.items').map(function(){
      return parseInt(this.value);
    }).get();

    var values = $('input:text.item_manage').map(function () {
      return parseInt(this.value);
    }).get();

    var sup = $('.supplier_ids').map(function () {
      return parseInt(this.value);
    }).get();

    $.ajax({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      url: "/manage_stocks",
      type: 'POST',
      data: { items_manage: values, supplier_ids: sup, item: item, invoice_id: $('#invoice_id').val()},
      success: function(data) {
        window.location.reload();
      },
      error: function(data){}
    });
  });
});

function setDatePicker(picker){
  $(picker).datepicker({dateFormat: "yy-mm-dd"});
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
  var xyz = parseFloat($($(link).closest(".fields").find('input')[3]).val());
  summaryAmount(xyz);
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regex = new RegExp("new_" + association, "g");
  $(link).parent().after(content.replace(regex, new_id));
  $('#new-item-fields').modal('show');
}

function numbersonly(evt){
  var charCode = (evt.which) ? evt.which : event.keyCode;
  if (charCode != 46 && charCode > 31
    && (charCode < 48 || charCode > 57))
     return false;

  return true;
}

function totalTransaction(input){
  var subtotal = 0;
  var total = parseFloat(input.value * $($(input).closest(".fields").find('input')[1]).val());
  var item_stock = parseFloat($(".item_stock").val());

  if(item_stock){
    if(item_stock < input.value){
      alert('qty melebihi stock');
      $('#addButton').attr("disabled","disabled");
      $('input.save_invoice').attr("disabled","disabled");
      return false
    }else{
      $('#addButton').removeAttr("disabled");
      $('input.save_invoice').removeAttr("disabled");
    }
  }
  subtotal += parseFloat(input.value * $($(input).closest(".fields").find('input')[0]).val());
  $($(input).closest(".fields").find('input')[4]).val(total);

  calculateTotal();
}

function summaryAmount(input){
  var total = $(".total_invoice").val();
  var ppn = $(".ppn_invoice").val().toFixed(3);
  var grand_total = $(".grand_total_invoice").val();
  var discount = $(".discount").val();
  var xyz = input;
  total = total - xyz;
  ppn = total * 0.1;
  if(discount){grand_total = (total - ppn) - discount;}else{grand_total = (total - ppn)}
  $(".total_invoice").val(total);
  $(".ppn_invoice").val(ppn);
  $(".grand_total_invoice").val(grand_total);
}

function discountAmount(input){
  var grand_total = $(".grand_total_invoice").val();
  grand_total = grand_total - input.value;
  $(".grand_total_invoice").val(grand_total);
}

function kursConvert(input){
  console.log('anegh');
  var total = parseFloat($(".total_invoice").val() * input.value).toFixed(3);
  var ppn = parseFloat($(".ppn_invoice").val() * input.value).toFixed(3);
  var grand_total = parseFloat($(".grand_total_invoice").val() * input.value).toFixed(3);
  var discount = parseFloat($(".discount").val() * input.value).toFixed(3);

  $('.valas_total').val(total);
  $('.valas_ppn').val(ppn);
  $('.valas_grand_total').val(grand_total);
  $('.valas_discount').val(discount);

  $('tr.fields').each(function(index,value){
    $($(this).find('input')[2]).val(parseFloat($($(this).find('input')[1]).val()) * parseFloat(input.value));
  });
}

function switchValue(link){
  $('tr.supplier_item').each(function(index, value){
    var current_stock = parseInt($($(this).find('td')[3]).text());
    var qty = $($(this).find('.item_manage')[0]).val();
    var total = parseInt($("#total_item").text());
    if(total > 0){
      if(current_stock >= qty && qty>0){
        console.log(total);
        $($(this).find('td')[3]).text(parseInt(current_stock-qty));
        $("#total_item").text(total-qty);
        $($(this).find('.item_manage')[0]).attr('disabled', 'disabled')
      }else{
        $($(this).find('.item_manage')[0]).val(0);
      }
    }else{$($(this).find('.item_manage')[0]).val(0);}
  });
}

function undoValue(link){
  $('tr.supplier_item').each(function(index, value){
    var current_stock = parseInt($($(this).find('td')[3]).text());
    var qty = parseInt($($(this).find('.item_manage')[0]).val());
    var total = parseInt($("#total_item").text());
    $($(this).find('td')[3]).text(parseInt(current_stock+qty));
    $("#total_item").text(total+qty);
    $($(this).find('.item_manage')[0]).val(0);
    $($(this).find('.item_manage')[0]).removeAttr('disabled')
  });
}

function numberValue(){
  $(".number").keyup(function(event) {
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
}

