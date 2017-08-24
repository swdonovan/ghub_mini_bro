require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      uid = 25035051
      screen_name = "swdonovan"

      user = User.create!(uid: uid, screen_name: screen_name)

      allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)

      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
