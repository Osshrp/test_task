require_relative 'acceptance_helper.rb'

feature 'Edit event', %q{
  In order to pass event to another user
  as an author
  I need to be able to share event
} do
  given(:user) { create(:user) }
  given(:calendar_with_events) { create(:calendar_with_events, user: user) }
  given(:another_user) { create(:user) }

  context 'Auther user' do
    before do
      sign_in(user)
      visit event_path(calendar_with_events.events.first)
      fill_in 'Email', with: another_user.email
      click_on 'Share event'
    end

    scenario 'share the event' do
      visit events_path
      click_link 'Sign out'
      sign_in(another_user)
      visit calendar_path(another_user.calendars.first)
      expect(page).to have_content calendar_with_events.events.first.title
    end
  end
end
