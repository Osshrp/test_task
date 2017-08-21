require_relative 'acceptance_helper.rb'

feature 'Edit event', %q{
  In order to correct mistakes
  as an author
  I need to be able to edit event
} do
  given(:user) { create(:user) }
  given(:calendar_with_events) { create(:calendar_with_events, user: user) }

  context 'Authenticated user' do
    before { sign_in(user) }

    scenario 'edit the event' do
      visit event_path(calendar_with_events.events.first)

      click_on 'Edit event'
      fill_in 'Title', with: 'New title'
      fill_in 'Description', with: 'New description'

      click_on 'Create event'

      within '.event' do
        expect(page).to have_content 'New title'
        expect(page).to have_content 'New description'
      end
    end
  end

  context 'Unauthenticated user' do
    scenario 'tries to edit event' do
      visit event_path(calendar_with_events.events.first)

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
