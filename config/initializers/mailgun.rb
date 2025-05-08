if ENV['MAILGUN_API_KEY'].present? && ENV['MAILGUN_DOMAIN'].present?
  Rails.application.config.action_mailer.mailgun_settings = {
    api_key: ENV['MAILGUN_API_KEY'],
    domain: ENV['MAILGUN_DOMAIN'],
    api_host: 'api.mailgun.net'  
  }
else
  Rails.logger.error("⚠️ MAILGUN_API_KEY o MAILGUN_DOMAIN no configurados. El envío de correo no funcionará.")
end
