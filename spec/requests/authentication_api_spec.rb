require 'rails_helper'

RSpec.describe "Authentication API", type: :request do  
  describe "User sign in" do 
    context "valid credential" do
      let(:user) { create(:user) }

      before do 
        post '/auth', params: auth_params(user)
      end

      it "return token" do 
        expect(response.body).to include("jwt", token_of(user))
      end
    end

    context "invalid credential" do 
      let(:user) { build_stubbed(:user) }

      before do 
        post '/auth', params: auth_params(user)
      end

      it "return error response" do
        expect(response.body).to include("error", "message", "Sorry, the credential is invalid")
      end
    end
  end
end