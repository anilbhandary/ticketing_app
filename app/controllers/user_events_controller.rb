class UserEventsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @event = Event.find(params[:user_event][:event_id])
    current_user.attend!(@event)
    redirect_to @event
  end
  
  def destroy
    @event = UserEvent.find(params[:id]).event
    current_user.unattend!(@event)
    redirect_to @event
  end
end
