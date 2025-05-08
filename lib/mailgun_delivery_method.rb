class MailgunDeliveryMethod
  attr_accessor :settings

  def initialize(settings)
    self.settings = settings
  end

  def deliver!(mail)
    mg_client = Mailgun::Client.new(settings[:api_key])

    html_part = mail.html_part ? mail.html_part.body.to_s : nil
    text_part = mail.text_part ? mail.text_part.body.to_s : mail.body.to_s

    message_params = {
      from: mail[:from].to_s,
      subject: mail.subject,
      text: text_part
    }

    message_params[:html] = html_part if html_part

    if mail.to
      message_params[:to] = mail.to
    end

    if mail.cc
      message_params[:cc] = mail.cc
    end

    if mail.bcc
      message_params[:bcc] = mail.bcc
    end

    domain = settings[:domain]
    mg_client.send_message(domain, message_params)
  end
end
