require_relative 'acceptance_helper.rb'

feature 'Create event', %q{
  In order to schedule my events
  as an authenticated user
  I need to be able to create event
} do
  given(:user) { create(:user) }

  context 'Authenticated user' do
    before { sign_in(user) }

    scenario 'creates the event' do
      visit calendar_path(user.calendars.first)
      click_on 'Create new event'
      fill_in 'Title', with: 'event title'
      fill_in 'Description', with: 'Event description'
      fill_in 'Start date', with: 1.day.after
      click_on 'Create event'


      expect(page).to have_content "Author: #{user.email}"
      expect(page).to have_content 'event title'
      expect(page).to have_content 'Event description'
      expect(page).to have_link 'Edit event'
      expect(page).to have_link 'Delete event'
      expect(page).to have_button 'Share event'
    end
  end

  context 'Unauthenticated user' do
    scenario 'tries to create event' do
      visit calendar_path(user.calendars.first)

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
