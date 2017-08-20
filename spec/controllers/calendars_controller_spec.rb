require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  describe 'GET #index' do
    let(:calendars) { create_list(:calendar, 2) }

    before { get :index }

    it 'populates an array of all calendars' do
      expect(assigns(:calendars)).to match_array(calendars)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
