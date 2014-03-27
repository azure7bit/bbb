$(document).ready(function() {
  var gaiSelected = [];
  $('#check_all').click(function () {
    if ($(this).is(":checked")) {
      $(this).parents('.table').find(':checkbox').attr('checked', this.checked);
      $(this).parents('.table').find('span').addClass('checked');
    }else{
      $(this).parents('.table').find(':checkbox').attr('checked', false);
      $(this).parents('.table').find('span').removeClass('checked');
    }
  });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#avatar_pic').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#cancel-edit").bind('click', function(){
    window.history.back();
    return false
  });

  $("#user_avatar").change(function(){
    readURL(this);
  });

  $("#delete_all").bind('click',function(event){
    event.stopPropagation();
    var values = $('input:checkbox:checked.cls_user_ids').map(function () {
      return parseInt(this.value);
    }).get();
    if (values.length == 0){alert("You dont choose user to delete"); return false}
    else{ var r=confirm("Are you sure to delete this data?");}
    if (r==true){
      $.ajax({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        url: "/users/delete_all",
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

  if($('#is-ajax').is(":checked")){return false;}else{window.onload = $('#is-ajax').click();}

});