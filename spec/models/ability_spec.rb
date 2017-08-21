require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :index, Calendar }
    it { should_not be_able_to :show, Calendar }
    it { should_not be_able_to :read, Event }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:calendar_with_events) { create(:calendar_with_events, user: user) }
    let(:other_users_event) { create(:event) }
    # let(:other_users_answer) { create(:answer, user: other_user) }
    # let(:other_answer) { create(:answer, question: create(:question)) }


    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, Calendar, user: user }
    it { should be_able_to :read, Event, user: user }

    it { should be_able_to :create, Calendar }
    it { should be_able_to :create, Event }

    it { should be_able_to :update, calendar_with_events.events.first, user: user }
    it { should_not be_able_to :update, other_users_event, user: user }


    it { should be_able_to :destroy, calendar_with_events.events.first, user: user}
    it { should_not be_able_to :destroy, other_users_event, user: user }


    it { should be_able_to :share, calendar_with_events.events.first, user: user }
    it { should_not be_able_to :share, other_users_event, user: user }
  end
end
