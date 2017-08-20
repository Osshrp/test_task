class Event < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :calendars, through: :calendars_events

  validates :title, :start_date, presence: true
end
