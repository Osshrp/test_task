require_relative 'acceptance_helper.rb'

feature 'View event', %q{
  In order to check an event in calendar
  I need to be able to view event
} do
  given(:user) { create(:user) }
  given(:calendar_with_events) { create(:calendar_with_events, user: user) }
  given(:another_user) { create(:user) }
  given(:calendar2_with_events) { create(:calendar_with_events, user: another_user) }

  context 'Authenticated user' do
    before { sign_in(user) }

    scenario 'sees the event' do
      visit event_path(calendar_with_events.events.first)

      expect(page).to have_content 'Test title'
      expect(page).to have_content calendar_with_events.events.first.start_date
      expect(page).to have_link 'Edit event'
      expect(page).to have_link 'Delete event'
    end
  end

  context 'Unauthenticated user' do

    scenario 'tries to see the event' do
      visit event_path(calendar_with_events.events.first)

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(page).to_not have_content 'Test title'
      expect(page).to_not have_content calendar_with_events.events.first.start_date
    end
  end
end
