class EventsController < ApplicationController


  def new

  	@event = Event.new 

  end

  def create

  
  	@event = Event.new(params_permit)
  	@event.creator_id = current_user.id
    @event.save

    redirect_to event_path(@event.id)

  end

  def params_permit

  	params.require(:event).permit(:title, :descr, :date, :place)

  end

  def show

    @event = Event.find(params[:id])
    
  end

  def index

    @event = Event.all
    
  end

  def subscribe

    @event = Event.find(params[:id])
    
        @event.attendees << current_user

   redirect_to event_path(@event.id)


  end


end
