class Calendar < ApplicationRecord
  belongs_to :user
  has_many :calendars_events
  has_many :events, through: :calendars_events
end
