require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let!(:events) { create_list(:event, 2) }

  it 'sends daily digest' do
    User.all.each do |user|
      expect(DailyMailer).to receive(:digest).with(user, events).and_call_original
    end
    DailyDigestJob.perform_now
  end
end
