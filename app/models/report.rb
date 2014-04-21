class Report < ActiveRecord::Base
  attr_accessor :report_type, :start_date, :end_date

  validates :report_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.generate_report(params)
    file = "#{Time.now.strftime("%Y%m%d")}_" + params[:reports][:report_type].to_s + "_report.xls"

    start = params[:reports][:start_date].to_date.strftime("%Y-%m-%d 00:00:00")
    finish = params[:reports][:end_date].to_date.strftime("%Y-%m-%d 23:59:59")

    book = Spreadsheet::Workbook.new
    
    sheet1 = book.create_worksheet
    sheet1.name = 'Report'
    row = 3

    case params[:reports][:report_type]
    # purchase order by date
    when "po_by_date"
      contents = PurchaseOrder.where(:po_date => start..finish)

      sheet1[0,0] = "Purchase Order Report " + start.to_date.strftime("%d %B %Y") + " - " + finish.to_date.strftime("%d %B %Y")
      sheet1.row(2).replace ['No.', 'Invoice No.', 'Date', 'Supplier', 'Nama Barang', 'Harga', 'Qty', 'Subtotal']

      no = 1
      contents.each do |content|
        content.purchase_order_details.each do |detail|
          sheet1.update_row row, no, content.po_number, content.po_date.strftime("%d %B %Y"), content.supplier_full_name, detail.item_name, detail.price, detail.qty, detail.qty * detail.price
          no += 1
          row += 1
        end
      end

    # receive by date
    when "receive_by_date"
      contents = PoReceive.where(:transaction_date => start..finish)

      sheet1[0,0] = "Purchase Order Receive Report " + start.to_date.strftime("%d %B %Y") + " - " + finish.to_date.strftime("%d %B %Y")
      sheet1.row(2).replace ['No.', 'Invoice No.', 'Date', 'Supplier', 'Nama Barang', 'Harga', 'Qty', 'Subtotal']

      no = 1
      contents.each do |content|
        content.po_receive_details.each do |detail|
          sheet1.update_row row, no, content.invoice_number, content.transaction_date.strftime("%d %B %Y"), content.supplier_full_name, detail.item_name, detail.price, detail.qty, detail.qty * detail.price
          no += 1
          row += 1
        end
      end

    # sales by date
    when "sales_by_date"
      contents = SalesInvoice.where(:transaction_date => start..finish)

      sheet1[0,0] = "Sales Order Report " + start.to_date.strftime("%d %B %Y") + " - " + finish.to_date.strftime("%d %B %Y")
      sheet1.row(2).replace ['No.', 'Invoice No.', 'Date', 'Customer', 'Nama Barang', 'Harga', 'Qty', 'Subtotal']

      no = 1
      contents.each do |content|
        content.sales_invoice_details.each do |detail|
          sheet1.update_row row, no, content.invoice_number, content.transaction_date.strftime("%d %B %Y"), content.customer_full_name, detail.item_name, detail.price, detail.qty, detail.qty * detail.price
          no += 1
          row += 1
        end
      end
      
    end

    format_title = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 12
    format_header = Spreadsheet::Format.new :weight => :bold

    sheet1.row(0).height = 18
    sheet1.row(0).default_format = format_title
    sheet1.row(2).default_format = format_header

    sheet1.column(0).width = 5
    sheet1.column(1).width = 20
    sheet1.column(2).width = 15
    sheet1.column(3).width = 25
    sheet1.column(4).width = 25

    book.write file
    return file
  end

  def self.preview(params)
    start = params[:reports][:start_date].to_date.strftime("%Y-%m-%d 00:00:00")
    finish = params[:reports][:end_date].to_date.strftime("%Y-%m-%d 23:59:59")

    preview_contents = Array.new 
    case params[:reports][:report_type]
    # purchase order by date
    when "po_by_date"
      contents = PurchaseOrder.where(:po_date => start..finish)
      no = 1
      contents.each do |content|
        content.purchase_order_details.each do |detail|
          preview_contents.push(
            :no => no,
            :invoice_no => content.po_number,
            :date => content.po_date.strftime("%d %B %Y"),
            :customer => content.supplier_full_name,
            :item => detail.item_name,
            :price => detail.price,
            :qty => detail.qty,
            :subtotal => detail.qty * detail.price
          )
          no += 1
        end
      end

    # receive by date
    when "receive_by_date"
      contents = PoReceive.where(:transaction_date => start..finish)
      no = 1
      contents.each do |content|
        content.po_receive_details.each do |detail|
          preview_contents.push(
            :no => no,
            :invoice_no => content.invoice_number,
            :date => content.transaction_date.strftime("%d %B %Y"),
            :customer => content.supplier_full_name,
            :item => detail.item_name,
            :price => detail.price,
            :qty => detail.qty,
            :subtotal => detail.qty * detail.price
          )
          no += 1
        end
      end

    # sales by date
    when "sales_by_date"
      contents = SalesInvoice.where(:transaction_date => start..finish)
      no = 1
      contents.each do |content|
        content.sales_invoice_details.each do |detail|
          preview_contents.push(
            :no => no,
            :invoice_no => content.invoice_number,
            :date => content.transaction_date.strftime("%d %B %Y"),
            :customer => content.customer_full_name,
            :item => detail.item_name,
            :price => detail.price,
            :qty => detail.qty,
            :subtotal => detail.qty * detail.price
          )
          no += 1
        end
      end
    end    

    return preview_contents
  end
end