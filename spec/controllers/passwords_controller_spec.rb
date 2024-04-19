require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  let(:valid_attributes) do
    {
      user: {
        password: "new_password",
        password_confirmation: "new_password"
      }
    }
  end

  let(:invalid_attributes) do
    {
      user: {
        password: "short",
        password_confirmation: "short"
      }
    }
  end

  describe "GET #edit" do
    it "renders the edit template" do
      user = create(:user)
      session[:user_id] = user.id

      get :edit

      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the password and redirects to root path with a notice" do
        user = create(:user)
        session[:user_id] = user.id
        allow(Current).to receive(:user).and_return(user)

        patch :update, params: valid_attributes

        expect(user.reload.authenticate("new_password")).to be_truthy
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Password Updated!")
      end

      it "sets a session for the user" do
        user = create(:user)
        session[:user_id] = user.id
        allow(Current).to receive(:user).and_return(user)

        patch :update, params: valid_attributes

        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "with invalid parameters" do
      it "does not update the password" do
        user = create(:user)
        session[:user_id] = user.id
        allow(Current).to receive(:user).and_return(user)

        patch :update, params: invalid_attributes

        expect(user.reload.authenticate("new_password")).to be_falsey
      end
    end
  end
end
