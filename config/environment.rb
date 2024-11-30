require 'bundler'

Bundler.require(:default)

# https://stackoverflow.com/questions/76183622/since-a-ruby-container-upgrade-we-expirience-a-lot-of-opensslsslsslerror
if OpenSSL::SSL.const_defined?(:OP_IGNORE_UNEXPECTED_EOF)
  OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:options] |= OpenSSL::SSL::OP_IGNORE_UNEXPECTED_EOF
end

require_relative '../lib/app'
