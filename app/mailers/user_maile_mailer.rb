require 'date'


class UserMaileMailer < ApplicationMailer
  default from: 'up694452@myport.ac.uk'

  def prayer_confirmation_email
    @requested_slots = params[:requested_slots]
    @to              = params[:to]
    puts "*****to",
    @subject        = 'GLM, Prayer confirmation for ' + @requested_slots.first.date.strftime("%a, %d %b %Y" )
    mail(to: @to, subject: @subject)
  end
end
