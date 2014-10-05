class GuestMailer < ActionMailer::Base
  before_action :get_host
  default from: "carolene.brandsen@gmail.com"

  def send_guest_mail(guest, template, subject = "", message = "")

    @guest = guest
    @template = template
    @message = message


    if subject.blank?
      @subject = @template.description
    else
      @subject = subject
    end

    #bitly urls
    @url = "http://#{@host}/guests/#{@guest.id}/dashboard/?token=#{@guest.access_token}&address=true"

    email_with_name = "#{@guest.name} <#{@guest.email}>"
    mail(
        to: email_with_name,
        subject: @subject,
        template_name:  @template.template )

  end

  private

  def get_host
    @host = ActionMailer::Base.default_url_options[:host]
  end

end
