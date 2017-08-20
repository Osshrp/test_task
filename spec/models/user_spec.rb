require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:events) }

  describe '#create_calendar' do
    it 'after creating user' do
      expect { create(:user) }.to change(Calendar, :count).by(1)
    end
  end
end
