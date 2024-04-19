require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:valid_attributes) do
    {
      user: {
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }
  end
  let(:invalid_attributes) do
    {
      user: {
        email: "test@example.com",
        password: "password123",
        password_confirmation: "wrong"
      }
    }
  end

  describe "GET #new" do
    it "initializes a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do

    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "redirects to the root path with a notice" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Successfully created account")
      end

      it "sets a session for the user" do
        post :create, params: valid_attributes
        expect(session[:user_id]).not_to be_nil
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, params: invalid_attributes
        expect(response).to render_template(:new)
      end

      it "returns an unprocessable entity status" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    # Additional tests for white box methodologies:

    # Data access testing:
    it "accesses the user parameters" do
      expect(controller).to receive(:user_params).and_call_original
      post :create, params: valid_attributes
    end

    # Initialization testing:
    it "initializes user session after successful registration" do
      post :create, params: valid_attributes
      expect(session[:user_id]).to eq(User.last.id)
    end

    # Condition testing:
    it "tests the condition for password confirmation mismatch" do
      post :create, params: { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'different' } }
      expect(response).to render_template(:new)
      # Ensure this message matches what is actually validated in the User model
      expect(assigns(:user).errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

end

