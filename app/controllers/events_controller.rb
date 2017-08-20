class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_with(@events = Event.all)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    respond_with(@event = current_user.calendars.first.events.new)
  end

  def create
    @event = current_user.calendars.first.events.create(event_params.merge(user: current_user))
    respond_with(@event)
  end

  def edit
    respond_with(@event = Event.find(params[:id]))
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    respond_with(@event.destroy)
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date)
  end
end
