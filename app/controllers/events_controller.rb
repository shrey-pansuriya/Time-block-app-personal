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


    private
    def event_params
        params.require(:event).permit(:name, :start_time, :end_time)
    end
    def require_login
        unless session[:user_id] && User.exists?(session[:user_id])
          flash[:alert] = 'Must sign in to use this feature.'
          redirect_to sign_in_path
        end
    end
end