class Calendar < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :events, through: :calendars_events

  scope :count_unread_events, ->(user, calendar) { joins(events: :calendars_events)
    .where("events.user_id != ? and calendars_events.calendar_id = ?", user, calendar).count }
end
