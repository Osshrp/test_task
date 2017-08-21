class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    events = Event.daily
    if events.present?
      User.find_each do |user|
        DailyMailer.digest(user, events.to_a).deliver_later
      end
    end
  end
end
