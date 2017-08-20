class Event < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :calendars, through: :calendars_events

  validates :title, :start_date, presence: true

  def share(email, event)
    user = User.where(email: email).first
    calendar = user.calendars.first
    calendar.calendars_events.create(calendar: calendar, event: event)
  end
end
