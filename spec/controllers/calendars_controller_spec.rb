require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  describe 'GET #index' do
    let(:calendars) { create_list(:calendar, 2) }

    before { get :index }

    it 'populates an array of all calendars' do
      expect(assigns(:calendars)).to match_array(Calendar.all)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:calendar) { create(:calendar) }

    context 'Unauthenticated user' do
      before { get :show, params: { id: calendar } }

      it 'does not assign requested calendar to @calendar' do
        expect(assigns(:calendar)).to_not eq calendar
      end

      it 'does not renders show view' do
        expect(response).to_not render_template :show
      end
    end

    context 'Authenticated user' do
      sign_in_user
      before { get :show, params: { id: @user.calendars.first } }

      it 'assigns requested calendar to @calendar' do
        expect(assigns(:calendar)).to eq @user.calendars.first
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end
  end
end
