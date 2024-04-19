require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #new" do
    context "when user is logged in" do
      before do
        user = FactoryBot.create(:user)  # User factory now uses email
        session[:user_id] = user.id
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
    end

    context "when user is not logged in" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to(sign_in_path)
        expect(flash[:alert]).to eq('Must sign in to use this feature.')
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      let(:user) { FactoryBot.create(:user) }
      before { session[:user_id] = user.id }

      context "with valid parameters" do
        it "creates a new event" do
          expect {
            post :create, params: { event: { name: "Meeting", start_time: Time.zone.now, end_time: Time.zone.now + 1.hour } }
          }.to change { user.events.count }.by(1)
        end

        it "redirects to the calendar page with a notice" do
          post :create, params: { event: { name: "Meeting", start_time: Time.zone.now, end_time: Time.zone.now + 1.hour } }
          expect(response).to redirect_to(calendar_path)
          expect(flash[:notice]).to eq("Event created!")
        end
      end
    end
  end
end
