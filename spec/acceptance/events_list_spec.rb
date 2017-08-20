require_relative 'acceptance_helper.rb'

feature 'Events list', %q{
  In order to find the required event,
  the user should have the opportunity
  to view the list of events
} do
  given!(:events) { create_list(:event, 2) }
  given(:user) { create(:user) }

  scenario 'Authenticated user views list of questions' do
    sign_in(user)
    visit events_path

    expect(page).to have_content events.first.title
    expect(page).to have_content events.last.title
  end

  scenario 'Unauthenticated user views list of question' do
    visit events_path

    expect(page).to_not have_content events.first.title
    expect(page).to_not have_content events.last.title
  end
end
