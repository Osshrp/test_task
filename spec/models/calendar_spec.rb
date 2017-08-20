require 'rails_helper'

RSpec.describe Calendar, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:events).through(:calendars_events) }
end
