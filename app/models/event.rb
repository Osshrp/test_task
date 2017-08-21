class Event < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :calendars, through: :calendars_events

  validates :title, :start_date, presence: true

  def share(email)
    user = User.where(email: email).first
    calendar = user.calendars.first
    calendar.calendars_events.create(event: self)
  end

  def read(calendar, event)
    calendars_event = CalendarsEvent.where(calendar: calendar, event: event)
    calendars_event(read: true)
    calendars_event.save
  end

  def is_read?(calendar, event)
    CalendarsEvent.where(calendar: calendar, event: event).is_read
  end
end
