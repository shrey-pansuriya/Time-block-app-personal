require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe "#index" do
    it "assigns @user when user is logged in" do
      user = create(:user)
      session[:user_id] = user.id
      get :index
      expect(assigns(:user)).to eq(user)
    end

    it "does not assign @user when user is not logged in" do
      session[:user_id] = nil

      get :index

      expect(assigns(:user)).to be_nil
    end
  end
end
