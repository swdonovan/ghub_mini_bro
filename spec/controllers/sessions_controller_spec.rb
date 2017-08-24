require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #create" do
    it "returns http success" do
      request.env['omniauth.auth'] = OmniAuth.config.add_mock(:github,
                                {"uid"=>25035051,
                               "extra"=>{"raw_info"=>
                                         {"screen_name"=>"swdonovan",
                                            " id"=>25035051,
                                           "name"=>"Wil Donovan",
                                          "email"=>"wil.donovan@gmail.com"}},
                         "credentials"=>
                                         {"token"=>"skills",
                                        "expires"=>false}})

      get :create
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE #destroy" do
    it "returns http redirect" do
      uid = 25035051
      screen_name = "swdonovan"

      user = User.create!(uid: uid, screen_name: screen_name)

      allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)

      delete :destroy
      expect(response).to have_http_status(:redirect)
    end
  end
end
