class CalendarsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @calendars = Calendar.all
  end

  def show
    @calendar = Calendar.find(params[:id])
    # @unread_events = Event.count_unread_events(current_user, @calendar)
  end
end
