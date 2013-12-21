function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regex = new RegExp("new_" + association, "g");
  $(link).parent().after(content.replace(regex, new_id));
  $('#new-item-fields').modal('show');
}

var itemFieldsUI = {
  init: function() {
    $('#addButton').on('click', function() {
      formHandler.appendFields();
      formHandler.hideForm();
    });
  }
};

var formHandler = {
  // Public method for adding a new row to the table.
  appendFields: function() {
    // Get a handle on all the input fields in the form and detach them from the DOM (we will attach them later).
    var inputFields = $(cfg.formId + ' ' + cfg.inputFieldClassSelector);
    inputFields.detach();

    // Build the row and add it to the end of the table.
    rowBuilder.addRow(cfg.getTBodySelector(), inputFields);

    // Add the "Remove" link to the last cell.
    rowBuilder.link.appendTo($('tr:last td:last'));
  },

  // Public method for hiding the data entry fields.
  hideForm: function() {
    $(cfg.formId).modal('hide');
  }
};

var cfg = {
  formId: '#new-item-fields',
  tableId: '#items-table',
  inputFieldClassSelector: '.field',
  getTBodySelector: function() {
    return this.tableId + ' tbody';
  }
};

var rowBuilder = function() {
  // Private property that define the default <TR> element text.
  var row = $('<tr>', { class: 'fields' });

  // Public property that describes the "Remove" link.
  var link = $('<a>', {
    href: '#',
    onclick: 'remove_fields(this); return false;',
    title: 'Delete this Item.'
  }).append($('<i>', { class: 'icon-remove' }));

  // A private method for building a <TR> w/the required data.
  var buildRow = function(fields) {
    var newRow = row.clone();

    $(fields).map(function() {
      $(this).removeAttr('class');
      return $('<td/>').append($(this));
    }).appendTo(newRow);

    return newRow;
  }

  // A public method for building a row and attaching it to the end of a <TBODY> element.
  var attachRow = function(tableBody, fields) {
    var row = buildRow(fields);
    $(row).appendTo($(tableBody));
  }

  // Only expose public methods/properties.
  return {
    addRow: attachRow,
    link: link
  }
}();

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

  // itemFieldsUI.init();
});