class Event < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :calendars, through: :calendars_events

  validates :title, :start_date, presence: true

  def share(email, event)
    user = User.where(email: email).first
    calendar = user.calendars.first
    calendar.calendars_events.create(calendar: calendar, event: event, viewed: false)
  end

  def view(calendar, event)
    calendars_event = CalendarsEvent.where(calendar: calendar, event: event)
    calendars_event(viewed: true)
    calendars_event.save
  end

  def is_viewed?(calendar, event)
    CalendarsEvent.where(calendar: calendar, event: event).viewed
  end
end
