require 'rails_helper' 

RSpec.describe "Dashboard API", type: :request do 
  describe "User visit dashboard page" do
    context "authenticated user" do 
      let (:user) { create(:user) }

      before do 
        get '/dashboard', headers: auth_header(user)
      end

      it "return success response" do 
        expect(response.body).to include("success", "message", "Welcome to dashboard, #{user.username}")
      end
    end

    context "unauthenticated user" do
      it "return errors response" do 
        get '/dashboard'

        expect(response.body).to include("error", "message", "Sorry, you're not authenticated")
      end
    end

    context "uncorrect format auth header" do
      let(:user) { create(:user) }

      it "return's errros response" do 
        get '/dashboard', params: { headers: { authorization: "Secret #{token_of(user)}" } }

        expect(response.body).to include("error", "message", "Sorry, you're not authenticated")
      end
    end 

    context "uncorrect auth token" do
      it "return's error response" do 
        get '/dashboard', params: { headers: { authorization: "Bearer 1nv4l1d_t0k3N" } }

        expect(response.body).to include("error", "message", "Sorry, you're not authenticated")
      end
    end
  end
end