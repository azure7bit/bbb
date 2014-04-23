class Report < ActiveRecord::Base
  attr_accessor :report_type, :start_date, :end_date, :item_id

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
    when "po_by_date", "po_by_date_and_supplier"
      contents = PurchaseOrder.where(:po_date => start..finish)
      contents = contents.where(:supplier_id => params[:reports][:supplier_id]) if params[:reports][:report_type] == "po_by_date_and_supplier"
      title = "Purchase Order Report "
      title = title + "- " + Supplier.find_by_id(params[:reports][:supplier_id]).full_id + " - " if params[:reports][:report_type] == "po_by_date_and_supplier"

      sheet1[0,0] = title + start.to_date.strftime("%d %B %Y") + " - " + finish.to_date.strftime("%d %B %Y")
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
    when "receive_by_date", "receive_by_date_and_supplier"
      contents = PoReceive.where(:transaction_date => start..finish)
      contents = contents.where(:supplier_id => params[:reports][:supplier_id]) if params[:reports][:report_type] == "receive_by_date_and_supplier"
      title = "Purchase Order Receive Report "
      title = title + "- " + Supplier.find_by_id(params[:reports][:supplier_id]).full_id + " - " if params[:reports][:report_type] == "receive_by_date_and_supplier"

      sheet1[0,0] = title + start.to_date.strftime("%d %B %Y") + " - " + finish.to_date.strftime("%d %B %Y")
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
    when "sales_by_date", "sales_by_date_and_customer"
      contents = SalesInvoice.where(:transaction_date => start..finish)
      contents = contents.where(:customer_id => params[:reports][:customer_id]) if params[:reports][:report_type] == "sales_by_date_and_customer"
      title = "Sales Receive Report "
      title = title + "- " + Customer.find_by_id(params[:reports][:customer_id]).full_id + " - " if params[:reports][:report_type] == "sales_by_date_and_customer"

      sheet1[0,0] = title + start.to_date.strftime("%d %B %Y") + " - " + finish.to_date.strftime("%d %B %Y")
      sheet1.row(2).replace ['No.', 'Invoice No.', 'Date', 'Customer', 'Nama Barang', 'Harga', 'Qty', 'Subtotal']

      no = 1
      contents.each do |content|
        content.sales_invoice_details.each do |detail|
          sheet1.update_row row, no, content.invoice_number, content.transaction_date.strftime("%d %B %Y"), content.customer_full_name, detail.item_name, detail.price, detail.qty, detail.qty * detail.price
          no += 1
          row += 1
        end
      end
      
    # item by date
    when "item_by_date"
      item = Item.find_by_id(params[:reports][:item_id])
      sheet1[0,0] = "Item History Report - " + item.code + " - " + item.name + " - " + start.to_date.strftime("%d %B %Y") + " - " + finish.to_date.strftime("%d %B %Y")

      # item in
      contents = PoReceive.where(:transaction_date => start..finish)
      sheet1[2,0] = "Item In"
      sheet1.row(3).replace ['No.', 'Invoice No.', 'Date', 'Qty', 'Supplier', 'Price']
      sheet1.row(3).default_format = Spreadsheet::Format.new :weight => :bold, :size => 10

      row += 1
      no = 1
      contents.each do |content|
        order_in_details = content.po_receive_details.where(:item_id => item.id)
        order_in_details.each do |detail|
          sheet1.update_row row, no, content.invoice_number, content.transaction_date.strftime("%d %B %Y"), detail.qty, content.supplier_full_name, detail.price
          no += 1
          row += 1
        end
      end
      
      # item out
      contents = SalesInvoice.where(:transaction_date => start..finish)
      sheet1[row + 1,0] = "Item Out"
      sheet1.row(row + 2).replace ['No.', 'Invoice No.', 'Date', 'Qty', 'Customer', 'Price']
      sheet1.row(row + 1).default_format = Spreadsheet::Format.new :weight => :bold, :size => 10
      sheet1.row(row + 2).default_format = Spreadsheet::Format.new :weight => :bold, :size => 10

      row += 3
      no = 1
      contents.each do |content|
        order_out_details = content.sales_invoice_details.where(:item_id => item.id)
        order_out_details.each do |detail|
          sheet1.update_row row, no, content.invoice_number, content.transaction_date.strftime("%d %B %Y"), detail.qty, content.customer_full_name, detail.price
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
    when "po_by_date", "po_by_date_and_supplier"
      contents = PurchaseOrder.where(:po_date => start..finish)
      contents = contents.where(:supplier_id => params[:reports][:supplier_id]) if params[:reports][:report_type] == "po_by_date_and_supplier"
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
    when "receive_by_date", "receive_by_date_and_supplier"
      contents = PoReceive.where(:transaction_date => start..finish)
      contents = contents.where(:supplier_id => params[:reports][:supplier_id]) if params[:reports][:report_type] == "receive_by_date_and_supplier"
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
    when "sales_by_date", "sales_by_date_and_customer"
      contents = SalesInvoice.where(:transaction_date => start..finish)
      contents = contents.where(:customer_id => params[:reports][:customer_id]) if params[:reports][:report_type] == "sales_by_date_and_customer"
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
    
    when "item_by_date"
      item = Item.find_by_id(params[:reports][:item_id])
      
      # item_in
      item_ins = Array.new
      order_ins = PoReceive.where(:transaction_date => start..finish)
      no = 1
      order_ins.each do |order_in|
        order_in_details = order_in.po_receive_details.where(:item_id => item.id)
        order_in_details.each do |detail|
          item_ins.push(
            :no => no,
            :invoice_no => order_in.invoice_number,
            :date => order_in.transaction_date.strftime("%d %B %Y"),
            :qty => detail.qty,
            :supplier => order_in.supplier_full_name,
            :price => detail.price
          )
          no += 1
        end
      end

      # item_out
      item_outs = Array.new
      order_outs = SalesInvoice.where(:transaction_date => start..finish)
      no = 1
      order_outs.each do |order_out|
        order_out_details = order_out.sales_invoice_details.where(:item_id => item.id)
        order_out_details.each do |detail|
          item_outs.push(
            :no => no,
            :invoice_no => order_out.invoice_number,
            :date => order_out.transaction_date.strftime("%d %B %Y"),
            :qty => detail.qty,
            :customer => order_out.customer_full_name,
            :price => detail.price
          )
          no += 1
        end
      end

      preview_contents.push(
        :item_ins => item_ins,
        :item_outs => item_outs
      )
    end    

    return preview_contents
  end
end