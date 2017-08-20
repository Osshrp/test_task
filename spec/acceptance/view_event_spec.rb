require_relative 'acceptance_helper.rb'

feature 'View event' do
  given!(:calendar) { create(:calendar) }
  # given(:user) { create(:user) }
  #
  # scenario 'user views list of calendars' do
  #   visit root_path
  #
  #   expect(page).to have_content calendars.first.user.email
  #   expect(page).to have_content calendars.last.user.email
  # end
end
