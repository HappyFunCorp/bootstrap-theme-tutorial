class ReportMailer < ApplicationMailer
  default from: 'will@happyfuncorp.com'
 
  def daily_report( email, subject, models, data )
    @user = email
    @data = data
    @models = models
    mail( to: email, subject: subject )
  end
end
