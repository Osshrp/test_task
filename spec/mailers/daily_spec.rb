require "rails_helper"

RSpec.describe DailyMailer, type: :mailer do
  describe "digest" do
    let(:user)  { create(:user) }
    let(:events) { create_list(:event, 2) }
    let(:mail) { DailyMailer.digest(user, events) }

    it "renders the headers" do
      expect(mail.subject).to eq("Daily digest")
      expect(mail.to).to eq([user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
