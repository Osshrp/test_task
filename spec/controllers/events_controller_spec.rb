require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  # let(:user) { create(:user) }
  # let(:event) { create(:event, user: user) }
  # let(:calendar_with_enents) { create(:calendar_with_enents, user: user) }

  describe 'GET #index' do
    let(:events) { create_list(:event, 2) }

    before { get :index }
    context 'Unauthenticated user' do

      it 'does not populate an array of all events' do
        expect(assigns(:events)).to_not match_array(events)
      end
      it 'does not render index view' do
        expect(response).to_not render_template :index
      end
    end

    context 'Authenticated user' do
      sign_in_user

      it 'populates an array of all events' do
        expect(assigns(:events)).to_not match_array(events)
      end
      it 'renders index view' do
        expect(response).to_not render_template :index
      end
    end
  end

  describe 'GET #show' do
    sign_in_user

    before do
      set_event
      get :show, params: { id: @event }
    end

    it 'assigns requested event to @event' do
      expect(assigns(:event)).to eq @event
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }
    it 'assigns a new Event to @event' do
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do

      it 'associates event with the user' do
        expect { post :create, params: { event: attributes_for(:event) } }
          .to change(@user.events, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { event: attributes_for(:event) }
        expect(response).to redirect_to event_path(assigns(:event))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the event' do
        expect { post :create, params: { event: attributes_for(:invalid_event) } }
          .to_not change(Event, :count)
      end

      it 're-renders new view' do
        post :create, params: { event: attributes_for(:invalid_event) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let!(:users_event) { create(:event, user: @user) }

    context 'with valid attributes' do
      it 'assigns the requested event to @event' do
        patch :update, params: { id: users_event,
          event: attributes_for(:event) }
        expect(assigns(:event)).to eq users_event
      end

      it 'change event attributes' do
        patch :update, params: { id: users_event,
          event: { title: 'new_title', description: 'new_description' } }
        users_event.reload
        expect(users_event.title).to eq 'new_title'
        expect(users_event.description).to eq 'new_description'
      end

      it 'redirects to updated @event' do
        patch :update, params: { id: users_event, event: attributes_for(:event) }
        expect(response).to redirect_to(assigns(:event))
      end
    end

    context 'with invalid attributes' do
      let(:title) { users_event.title }
      let(:start_date) { users_event.start_date }
      before do
        patch :update, params: { id: users_event,
          event: { title: 'new_title', start_date: nil } }
      end
      it 'does not change @event attributes' do
        users_event.reload
        expect(users_event.title).to eq title
        expect(users_event.start_date).to eq start_date
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'user tries to update event that does not belong to him' do
      let(:title) { event.title }
      let(:start_date) { event.start_date }
      let(:event) { create(:event) }
      before do
        patch :update, params: { id: event,
          event: { title: 'new_title', start_date: '2017-12-01' } }
      end
      it 'does not update event attributes' do
        event.reload
        expect(event.title).to eq title
        expect(event.start_date).to eq start_date
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:users_event) { create(:event, user: @user) }
    let(:event) { create(:event) }
    before { event }

    context 'author tries to delete event' do
      it 'deletes event' do
        expect { delete :destroy, params: { id: users_event } }
          .to change(Event, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: users_event }
        expect(response).to redirect_to events_path
      end
    end

    context 'user tries to delete event that does not belongs to him' do
      it 'does not deletes event' do
        expect { delete :destroy, params: { id: event } }
          .to_not change(Event, :count)
      end

      it 'redirects to events index view' do
        delete :destroy, params: { id: event }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH #share' do
    sign_in_user
    let(:calendar_with_events) { create(:calendar_with_events, user: @user) }
    let!(:user) { create(:user) }

    before do
      patch :share, params: { id: calendar_with_events.events.first, email: user.email }
    end

    it 'share event with another user' do
      expect(user.calendars.first.events.first).to eq @user.events.first
    end
  end

  private

  def set_event
    calendar_with_events = create(:calendar_with_events, user: @user)
    @event = calendar_with_events.events.first
  end
end
