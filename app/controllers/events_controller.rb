class EventsController < ApplicationController
  before_action :require_login

  def new
    @event = Event.new
  end

  def create
    @event = Current.user.events.build(event_params)

    if @event.save
      redirect_to calendar_path, notice: "Event created!"
    else
      render :new
    end
  end

  def timeblock
    # Group events by priority
    grouped_events = Current.user.events.group_by(&:priority)

    # Calculate the start and end times for each priority group
    start_time = Time.current
    end_time = Time.current

    grouped_events.each do |priority, events|
      total_hours = events.sum { |event| event.end_time - event.start_time }
      end_time += total_hours
      events.each do |event|
        event.update(start_time: start_time, end_time: end_time)
      end
      start_time = end_time
    end

    redirect_to calendar_path, notice: "Events time-blocked!"
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_time, :end_time, :priority)
  end

  def require_login
    unless session[:user_id] && User.exists?(session[:user_id])
      flash[:alert] = 'Must sign in to use this feature.'
      redirect_to sign_in_path
    end
  end
end
