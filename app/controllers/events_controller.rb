class EventsController < ApplicationController
    
  def index
    @events = Event.all
  end
  
  def show
    @title = 'Attenders'
    @event = Event.find(params[:id])
    @users = @event.users
  end
  
end
