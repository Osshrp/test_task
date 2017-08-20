require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:calendars).through(:calendars_events) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :start_date }
end
