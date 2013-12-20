$(document).ready(function() {

  $("#supplier_delete_all").bind('click',function(event){
    event.stopPropagation();
    var values = $('input:checkbox:checked.cls_supplier_ids').map(function () {
      return parseInt(this.value);
    }).get();
    if (values.length == 0){alert("Please choose supplier(s) to delete."); return false}
    else{ var r=confirm("Are you sure you will delete these data?");}
    if (r==true){
      $.ajax({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        url: "/suppliers/delete_all",
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

  $("#supplier_print_all").bind('click',function(event){
    event.stopPropagation();
    var values = $('input:checkbox:checked.cls_supplier_ids').map(function () {
      return parseInt(this.value);
    }).get();
    if (values.length == 0){alert("Mohon pilih supplier minimal satu"); return false}
    else{
      window.open("/suppliers/print_preview?id_all="+values);
    }
  });
});