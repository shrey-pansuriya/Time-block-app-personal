class CalendarsController < ApplicationController
    before_action :require_login

    def show
        start_date = params.fetch(:start_date, Date.today).to_date
        # Use Current.user instead of current_user
        @events = Current.user.events.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
    end

    def require_login
        unless session[:user_id] && User.exists?(session[:user_id])
          flash[:alert] = 'Must sign in to use this feature.'
          redirect_to sign_in_path
        end
    end

end