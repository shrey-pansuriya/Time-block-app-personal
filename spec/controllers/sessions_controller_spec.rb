require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      let(:user) { FactoryBot.create(:user, email: "test@example.com", password: "password") }

      it "redirects to root_path with a notice" do
        post :create, params: { email: user.email, password: "password" }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Logged in successfully")
      end
    end

    context "with invalid credentials" do
      it "renders the new template with an alert" do
        post :create, params: { email: "invalid@example.com", password: "invalidpassword" }
        expect(response).to render_template("new")
        expect(flash[:alert]).to eq("Invalid email or password")
      end
    end
  end

  describe "DELETE #destroy" do
    it "logs out the user and redirects to root_path with a notice" do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Logged out")
    end
  end
end
