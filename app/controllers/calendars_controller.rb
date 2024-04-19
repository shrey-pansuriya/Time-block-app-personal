class CalendarsController < ApplicationController
  before_action :require_login

  def show
    start_date = params.fetch(:start_date, Date.today).to_date
    @events = time_blocked_events(start_date)
  end

  private

  def time_blocked_events(start_date)
    # Retrieve events for the week
    events = Current.user.events.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
    # Implement time-blocking logic here to generate time-blocked events
    # For now, just return the original events
    events
  end

  def require_login
    unless session[:user_id] && User.exists?(session[:user_id])
      flash[:alert] = 'Must sign in to use this feature.'
      redirect_to sign_in_path
    end
  end
end