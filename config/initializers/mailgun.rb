require 'mailgun-ruby'
require_relative '../../lib/mailgun_delivery_method'

Rails.application.configure do
  if ENV['MAILGUN_API_KEY'].present? && ENV['MAILGUN_DOMAIN'].present?
    # Registra el método de entrega personalizado
    ActionMailer::Base.add_delivery_method(:mailgun, MailgunDeliveryMethod,
      api_key: ENV['MAILGUN_API_KEY'],
      domain: ENV['MAILGUN_DOMAIN']
    )
    
    # Configura el action_mailer para usar este método
    config.action_mailer.delivery_method = :mailgun
    
    # Imprime un mensaje de confirmación
    Rails.logger.info("✅ Mailgun configurado correctamente con dominio: #{ENV['MAILGUN_DOMAIN']}")
  else
    Rails.logger.error("⚠️ MAILGUN_API_KEY o MAILGUN_DOMAIN no configurados. El envío de correo no funcionará.")
  end
end
