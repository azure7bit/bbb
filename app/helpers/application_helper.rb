module ApplicationHelper
  def dollar_type(currency)
    "display: none;" if currency.include?('Dollar')
  end

  def rupiah_type(currency)
    "display: none;" if currency.include?('Rupiah')
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def link_to_remove_fields(name, f, options = {})
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", options)
  end

  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{ association }", :onsubmit => "return $(this.)validate();") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end

    link_to_function(name, "add_fields(this, \"#{ association }\", \"#{ escape_javascript(fields) }\")", options)
  end

  def kurs_value
    Company.first.kurs
  end

  def usd_to_idr(usd)
    number_to_currency(kurs_value * usd, unit: "Rp") if usd
  end

  def report_types
    if current_user.is_sales?
      [
        ['Sales Order By Date', "sales_by_date"],
        ['Piutang Usaha', 'piutang_usaha'],
        ['Sales Order By Date And Customer', "sales_by_date_and_customer"],
        ['Item History By Date', "item_by_date"]
      ]
    elsif current_user.is_purchase?
      [
        ['hutang usaha', 'hutang_usaha'],
        ['Purchase Order By Date', "po_by_date"],
        ['Purchase Order By Date And Supplier', "po_by_date_and_supplier"],
        ['Receive Order By Date', "receive_by_date"],
        ['Receive Order By Date And Supplier', "receive_by_date_and_supplier"],
        ['Item History By Date', "item_by_date"]
      ]
    else
      [
        ['Hutang Usaha', 'hutang_usaha'],
        ['Piutang Usaha', 'piutang_usaha'],
        ['Purchase Order By Date', "po_by_date"],
        ['Purchase Order By Date And Supplier', "po_by_date_and_supplier"],
        ['Receive Order By Date', "receive_by_date"],
        ['Receive Order By Date And Supplier', "receive_by_date_and_supplier"],
        ['Sales Order By Date', "sales_by_date"],
        ['Sales Order By Date And Customer', "sales_by_date_and_customer"],
        ['Item History By Date', "item_by_date"]
      ]
    end
  end
end
