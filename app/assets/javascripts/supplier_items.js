var itemFieldsUI = {
  init: function() {
    $('#addButton').on('click', function(e) {
      formHandler.appendFields();
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