require_relative 'acceptance_helper.rb'

# feature 'Events list', %q{
#   In order to find the required event,
#   the user should have the opportunity
#   to view the list of events
# } do
#   given!(:user) { create(:user) }
#   # given(:event) { create(:event, 2, user: user) }
#   before do
#     event1 = user.calendars.first.events.create(title: 'title1', start_date: 1.day.after)
#     event2 = user.calendars.first.events.create(title: 'title2', start_date: 1.day.after)
#   end
#
#   scenario 'Authenticated user views list of questions' do
#     sign_in(user)
#     visit calendar_path(user.calendars.first)
#
#     expect(page).to have_content 'title1'
#     expect(page).to have_content 'title2'
#   end
#
#   scenario 'Unauthenticated user views list of question' do
#     visit calendar_path(user.calendars.first)
#
#     expect(page).to_not have_content events.first.title
#     expect(page).to_not have_content events.last.title
#   end
# end
