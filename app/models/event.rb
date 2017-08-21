class Event < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :calendars, through: :calendars_events

  validates :title, :start_date, presence: true

  scope :count_unread_events, ->(user, calendar) { joins(:calendars_events)
    .where('events.user_id <> ? AND
            calendars_events.calendar_id = ? AND
            calendars_events.is_read = ?',
            user, calendar, false).count }

  scope :daily, -> { where('start_date < ?', 1.day.after) }

  def share(email)
    user = User.where(email: email).first
    calendar = user.calendars.first
    calendar.calendars_events.create(event: self)
  end

  def read(calendar)
    calendars_event = CalendarsEvent.where(calendar: calendar, event: self).first
    calendars_event.update(is_read: true)
  end

  def is_read?(calendar)
    CalendarsEvent.where(calendar: calendar, event: self).first.try(:is_read)
  end
end
