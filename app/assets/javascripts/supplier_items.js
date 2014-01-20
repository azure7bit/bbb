var itemFieldsUI = {
  init: function() {
    var validationSettings = {
      errorMessagePosition : 'element'
    };

    $('#new-item-fields').validateOnBlur();

    $('#addButton').on('click', function(e) {
      var isValid = $('#new-item-fields').validate(false, validationSettings);
      
      if(!isValid) {
        e.stopPropagation();
        return false;
      }
      $("select").attr("disabled", "disabled");
      $("select#sales_invoice_customer_id").attr("disabled", false);
      formHandler.appendFields();
      formHandler.hideForm();
      calculateTotal();
    });

    $('#cancelButton').on('click', function(e){
      e.stopPropagation();
      var inputFields = $(cfg.formId + ' ' + cfg.inputFieldClassSelector);
      inputFields.detach();
      $('.category_name').remove();
      formHandler.hideForm();
    });
    
    $('button.close').on('click', function(e){
      e.stopPropagation();
      var inputFields = $(cfg.formId + ' ' + cfg.inputFieldClassSelector);
      inputFields.detach();
      $(cfg.inputFieldClassSelector).remove();
      formHandler.hideForm();
    });
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

var formHandler = {
  appendFields: function () {
    var inputFields = $(cfg.formId + ' ' + cfg.inputFieldClassSelector);
    inputFields.detach();
    rowBuilder.addRow(cfg.getTBodySelector(), inputFields);
    rowBuilder.link.clone().appendTo($('tr.fields:last td:last'));
  },

  hideForm: function() {
    $(cfg.formId).modal('hide');
  }
};

var rowBuilder = function() {
  var row = $('<tr>', { class: 'fields' });
  
  var link = $('<a>', {
    href: '#',
    onclick: 'remove_fields(this); return false;',
    title: 'Delete this Item.'
  }).append($('<i>', { class: 'icon-remove' }));

  var buildRow = function(fields) {
    var newRow = row.clone();

    $(fields).map(function() {
      $(this).removeAttr('class');
      var td = $('<td/>').append($(this));
      td.appendTo(newRow);
    });

    return newRow;
  }

  var attachRow = function(tableBody, fields) {
    var row = buildRow(fields);
    $(row).appendTo($(tableBody));
  }

  return {
    addRow: attachRow,
    link: link
  }
}();

var calculate = function(){
  $('tr.fields').each(function(index,value){
    $($(this).find('input')[2]).keyup(function() {
      var value = $(this).val() * $($(this).parents("tr").find('input')[0]).val();
      $($(this).parents("tr").find('input')[3]).val(value);
      calculateTotal();
      return false;
    });
  });

  $('tr.fields').find('a').each(function(index,value){
    $(this).click(function(){
      $(this).parents('tr').remove();
      calculateTotal()-parseFloat($($(this).find('input')[3]).val());
      return false;
    });
  });
}

function calculateTotal() {
  var subTotal = 0;
  $('tr.fields').each(function(index,value){
    subTotal += parseFloat($($(this).find('input')[3]).val());
    $(".total_invoice").val(subTotal); 
    $(".ppn_invoice").val(subTotal * 0.1); 
    $(".grand_total_invoice").val(subTotal * 1.1);
  });
}