class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created account"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        @user = Current.user # or however you access the current user
      
        # Strong parameters, allow updating email and password
        if @user.update(user_params)
          # Redirect or handle success
          redirect_to some_path, notice: "Profile updated successfully."
        else
          # Render form again with error messages
          render :edit
        end
      end
      

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
