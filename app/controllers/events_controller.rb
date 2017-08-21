class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :share]

  def index
    respond_with(@events = Event.all)
  end

  def show
    @event.read(current_user.calendars.first)
  end

  def new
    respond_with(@event = current_user.calendars.first.events.new)
  end

  def create
    @event = current_user.calendars.first.events.create(event_params.merge(user: current_user))
    respond_with(@event)
  end

  def edit
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    respond_with(@event.destroy)
  end

  def share
    @event.share(params[:email])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
