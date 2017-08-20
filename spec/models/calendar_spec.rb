require 'rails_helper'

RSpec.describe Calendar, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:events).through(:calendars_events) }

  # describe '#owner' do
  #   let(:calendar) { create(:calendar) }
  #   it 'should returns calendar owner' do
  #     expect(calendar.owner.email).to eq calendar.users.first.email
  #   end
  # end
end
