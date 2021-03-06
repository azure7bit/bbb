//= require jquery-1.7.2.min
//= require jquery-1.8.2.min
//= require jquery-ui-1.8.21.custom.min
//= require bootstrap-transition
//= require bootstrap-alert.min
//= require bootstrap-modal.min
//= require bootstrap-dropdown.min
//= require bootstrap-scrollspy.min
//= require bootstrap-tab.min
//= require bootstrap-tooltip.min
//= require bootstrap-popover.min
//= require bootstrap-button.min
//= require bootstrap-collapse.min
//= require bootstrap-carousel.min
//= require bootstrap-typeahead.min
//= require bootstrap-tour.min
//= require jquery.cookie
//= require jquery.dataTables.min
//= require jquery.chosen.min
//= require jquery.uniform.min
//= require jquery.colorbox.min
//= require jquery.cleditor.min
//= require jquery.noty.min
//= require jquery.elfinder.min
//= require jquery.raty.min
//= require jquery.autogrow-textarea
//= require jquery.uploadify-3.1.min
//= require jquery.history
//= require jquery.formvalidator.min
//= require jquery.jeditable.mini
//= require jquery.meio.mask.min
//= require responsive-tables
//= require jpicker-1.1.6.min
//= require charisma.min
//= require user
//= require supplier
//= require customer
//= require category
//= require items
//= require supplier_items
//= require highstock.min
//= require report
//= require po
//= require so
//= require supplier_payment
//= require customer_payment

$(document).ready(function(){
  $("#reset_data").click(function(){
    $.ajax({
      url: "/reset_data",
      data: {
        table_name: $(this).attr("data-member")
      },
      type: "GET",
      data_type: 'application/json',
      success: function(data){
        window.location.href = data.data;
      },
      error: function(data){
        // window.location.href = data.data;
      }
    });
  });
});
