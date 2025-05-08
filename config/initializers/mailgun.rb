require 'mailgun-ruby'

api_key = ENV['MAILGUN_API_KEY']
domain = ENV['MAILGUN_DOMAIN']

if api_key.nil? || domain.nil?
  Rails.logger.error("⚠️ MAILGUN_API_KEY o MAILGUN_DOMAIN no configurados. El envío de correo no funcionará.")
end

Mailgun.configure do |config|
  config.api_key = api_key if api_key
end

ActionMailer::Base.add_delivery_method(:mailgun, Mailgun::DeliveryMethod, 
  api_key: api_key, 
  domain: domain
) if api_key && domain
