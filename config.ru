require_relative 'config/environment'

Fritzbox::Smarthome.configure do |config|
  config.endpoint   = ENV['FRITZBOX_ENDPOINT'] || 'https://fritz.box'
  config.username   = ENV['FRITZBOX_USERNAME'] || 'smarthome'
  config.password   = ENV['FRITZBOX_PASSWORD'] || 'verysmart'
  config.verify_ssl = (ENV['FRITZBOX_VERIFY_SSL'] || 'false') == 'true'
  config.logger     = Logger.new(STDOUT, level: Logger::INFO)
end

require_relative 'lib/app'

run App
