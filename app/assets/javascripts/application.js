// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-1.7.2.min
//= require jquery-1.8.2.min
//= require jquery-ui-1.8.21.custom.min
//= require bootstrap-transition
//= require bootstrap-alert
//= require bootstrap-modal
//= require bootstrap-dropdown
//= require bootstrap-scrollspy
//= require bootstrap-tab
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-button
//= require bootstrap-collapse
//= require bootstrap-carousel
//= require bootstrap-typeahead
//= require bootstrap-tour
//= require jquery.cookie
//= require jquery.dataTables.min
//= require jquery.chosen.min
//= require jquery.uniform.min
//= require jquery.colorbox.min
//= require jquery.cleditor.min
//= require jquery.noty
//= require jquery.elfinder.min
//= require jquery.raty.min
//= require jquery.autogrow-textarea
//= require jquery.uploadify-3.1.min
//= require jquery.history
//= require jquery.formvalidator.min
//= require jquery.jeditable.mini
//= require charisma
//= require user
//= require supplier
//= require customer
//= require category
//= require items
//= require supplier_items

function remove_fields(link) {
  var total = $(".total_invoice").val();
  var ppn = $(".ppn_invoice").val(); 
  var grand_total = $(".grand_total_invoice").val();
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
  var xyz = parseFloat($($(link).closest(".fields").find('input')[2]).val());
  total = total - xyz;
  ppn = total * 0.1;
  grand_total = total - ppn;
  $(".total_invoice").val(total);
  $(".ppn_invoice").val(ppn); 
  $(".grand_total_invoice").val(grand_total);
  $(link).closest(".fields").remove();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regex = new RegExp("new_" + association, "g");
  $(link).parent().after(content.replace(regex, new_id));
  $('#new-item-fields').modal('show');
}