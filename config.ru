require 'bundler'

Bundler.require(:default)

Fritzbox::Smarthome.configure do |config|
  config.endpoint   = ENV['FRITZBOX_ENDPOINT'] || 'https://fritz.box'
  config.username   = ENV['FRITZBOX_USERNAME'] || 'smarthome'
  config.password   = ENV['FRITZBOX_PASSWORD'] || 'verysmart'
  config.verify_ssl = (ENV['FRITZBOX_VERIFY_SSL'] || 'false') == 'true'
end

rollbar_token_file = ENV['ROLLBAR_TOKEN_FILE']

Rollbar.configure do |config|
  config.enabled      = ENV['ROLLBAR_ENABLED'] == 'true'
  config.access_token = ENV['ROLLBAR_TOKEN'] || (rollbar_token_file && File.read(rollbar_token_file).strip)
end

require_relative 'lib/app'

run App
