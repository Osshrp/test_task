require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:calendars).through(:calendars_events) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :start_date }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:calendar_with_events) { create(:calendar_with_events, user: user) }


  describe '#share' do
    it 'shares event' do
      calendar_with_events.events.first.share(another_user.email)
      expect(another_user.calendars.first.events.first).to eq calendar_with_events.events.first
    end
  end

  describe '#read' do
    it 'reads event' do
      calendar_with_events.events.first.read(calendar_with_events)
      expect(CalendarsEvent.find_by(calendar: calendar_with_events, event: calendar_with_events.events).is_read)
        .to be_truthy
    end
  end
end
