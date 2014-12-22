class HomeController < ApplicationController
  before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token, :only => ['elfinder']

  def elfinder
    h, r = ElFinder::Connector.new(
      :root => File.join(Rails.public_path, 'system', 'elfinder'),
      :url => 'http://localhost:3000/system/elfinder',
      :driver => 'LocalFileSystem',
      :perms => {
        'forbidden' => {:read => false, :write => false, :rm => false},
        /README/ => {:write => false},
        /pjkh\.png$/ => {:write => false, :rm => false},
      },
      :extractors => {
        'application/zip' => ['unzip', '-qq', '-o'],
        'application/x-gzip' => ['tar', '-xzf'],
      },
      :archivers => {
        'application/zip' => ['.zip', 'zip', '-qr9'],
        'application/x-gzip' => ['.tgz', 'tar', '-czf'],
      },
      :thumbs => true
    ).run(params)

    headers.merge!(h)
    render (r.empty? ? {:nothing => true} : {:text => r.to_json}), :layout => false
  end

  def index
  	@statistic = Statistic.first
  end

  def purchase_history
  	ordered = PoReceive.history_order
    render json: ordered.map{|o| [o[0].to_i*1000, o[1].to_f]}
  end

  def sales_history
    ordered = SalesInvoice.history_order
    render json: ordered.map{|o| [o[0].to_i*1000, o[1].to_f]}
  end

  def file_managers;end

  def reset_data
    if params[:table_name]
      table_name = params[:table_name]
      ActiveRecord::Base.connection.execute("TRUNCATE #{table_name}") if !["schema_migrations"].include?(table_name)
      case table_name
      when "purchase_orders"
        ActiveRecord::Base.connection.execute("TRUNCATE purchase_order_details") if !["schema_migrations"].include?('purchase_order_details')
      when "sales_invoices"
        ActiveRecord::Base.connection.execute("TRUNCATE sales_invoice_details") if !["schema_migrations"].include?('sales_invoice_details')
      when "suppliers"
        ActiveRecord::Base.connection.execute("TRUNCATE supplier_items") if !["schema_migrations"].include?('supplier_items')
        ActiveRecord::Base.connection.execute("TRUNCATE supplier_item_prices") if !["schema_migrations"].include?('supplier_item_prices')
        ActiveRecord::Base.connection.execute("TRUNCATE supplier_payments") if !["schema_migrations"].include?('supplier_payments')
      when "items"
        ActiveRecord::Base.connection.execute("TRUNCATE manage_stocks") if !["schema_migrations"].include?('manage_stocks')
        ActiveRecord::Base.connection.execute("TRUNCATE mix_items") if !["schema_migrations"].include?('mix_items')
      when "po_receives"
        ActiveRecord::Base.connection.execute("TRUNCATE po_receive_details") if !["schema_migrations"].include?('po_receive_details')
      end
      render json: {data: request.env["HTTP_REFERER"]}
    end
  end
end
