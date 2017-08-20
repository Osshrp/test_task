require_relative 'acceptance_helper.rb'

feature 'Calendars list', %q{
  In order to find the required calendar,
  the user should have the opportunity
  to view the list of calendars
} do
  given!(:calendars) { create_list(:calendar, 2) }
  given(:user) { create(:user) }

  scenario 'user views list of calendars' do
    visit root_path

    expect(page).to have_content calendars.first.user.email
    expect(page).to have_content calendars.last.user.email
  end
end
