class CalendarsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @calendars = Calendar.all
  end

  def show
    @calendar = current_user.calendars.first
  end
end
