require_relative 'acceptance_helper.rb'

feature 'Delete event', %q{
  In order to corret mistake
  as an author
  I need to be able to delete event
} do
  given(:user) { create(:user) }
  given(:calendar_with_events) { create(:calendar_with_events, user: user) }

  context 'Author' do
    before { sign_in(user) }

    scenario 'deletes the event' do
      visit event_path(calendar_with_events.events.first)

      click_on 'Delete event'

      expect(page).to_not have_content 'Test title1'
      expect(page).to have_content 'Test title2'
    end
  end

  context 'Unuthenticated user' do

    scenario 'tries to delete the event' do
      visit event_path(calendar_with_events.events.first)

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
