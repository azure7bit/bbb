RAILS_HOST = Rails.env.development? ? "http://localhost:3000" : "http://bandungbangkitbersinar.herokuapp.com"

if Rails.env.staging? || Rails.env.production?
  WickedPdf.config = {:exe_path => Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s}
else
  WickedPdf.config = { :exe_path => '/usr/bin/wkhtmltopdf'}
end