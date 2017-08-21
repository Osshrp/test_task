require_relative 'acceptance_helper.rb'

feature 'View event', %q{
  In order to check an event in calendar
  I need to be able to view event
} do
  given!(:user) { create(:user) }
  given(:calendar_with_events) { create(:calendar_with_events, user: user) }

  context 'Authenticated user' do
    before { sign_in(user) }

    scenario 'sees the event' do
      visit event_path(calendar_with_events.events.first)

      expect(page).to have_content 'Test title'
      expect(page).to have_content calendar_with_events.events.first.start_date
    end
  end
end
