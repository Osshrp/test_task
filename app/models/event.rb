class Event < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :calendars, through: :calendars_events
end
