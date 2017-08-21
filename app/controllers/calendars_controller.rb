class CalendarsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_calendar, only: :show

  authorize_resource

  def index
    @calendars = Calendar.all
  end

  def show
  end

  private

  def set_calendar
    @calendar = Calendar.find(params[:id])
  end
end
