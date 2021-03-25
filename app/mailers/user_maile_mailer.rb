require 'date'


class UserMaileMailer < ApplicationMailer
  default from: "Green Lane Masjid <info@greenlanemasjid.org>"

  def prayer_confirmation_email
    @to              = params[:to]
    return if @to.nil?
    @requested_slots = params[:requested_slots]
    @subject        = 'GLM, Prayer confirmation for ' + @requested_slots.first.date.strftime("%a, %d %b %Y" )
    mail(to: @to, subject: @subject)
  end
end
