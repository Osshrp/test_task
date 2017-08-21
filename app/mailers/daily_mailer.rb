class DailyMailer < ApplicationMailer
  def digest(user, events)
    @events = events
    @user = user
    mail(to: @user.email, subject: 'Daily digest')
  end
end
