BandungBangkitBersinar::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  config.assets.expire_after 2.weeks

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  config.log_level = :info

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )
  # config.assets.precompile += %w(blueprint/screen.css pdf.css jquery.ui.datepicker.js pdf.js number_pages.js jquery-1.7.2.min.js)
  config.assets.precompile += %w(blueprint/screen.css pdf.css pdf.js)

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.default_url_options = { host: "bandungbangkitbersinar.herokuapp.com" }

  config.action_mailer.smtp_settings = {
    address: "smtp.mandrillapp.com",
    port: 587,
    domain: "bandungbangkitbersinar.herokuapp.com",
    enable_starttls_auto: :true,
    user_name: "asevenfold7bit@gmail.com",
    password: "-fKEAFi9ZDoqbixfo6-f9g"
  }

  config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[bandungbangkitbersinar] ",
    :sender_address => %{"errors_notifier" <notifier@bandungbangkitbersinar.com>},
    :exception_recipients => %w{azure7bit@tri.blackberry.com ian.chaizir@gmail.com},
    :background_sections => %w{my_section1 my_section2 backtrace data}
  }
end
