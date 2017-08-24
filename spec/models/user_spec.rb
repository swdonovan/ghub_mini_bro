require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#from_omniauth" do
    it "should return a created user" do
      user = OmniAuth.config.add_mock(:github,
                                {"uid"=>25035051,
                               "extra"=>{"raw_info"=>
                                         {"screen_name"=>"swdonovan",
                                            " id"=>25035051,
                                           "name"=>"Wil Donovan",
                                          "email"=>"wil.donovan@gmail.com"}},
                         "credentials"=>
                                         {"token"=>"skills",
                                        "expires"=>false}})

      user_new = User.from_omniauth(user)

      expect(user_new).to eq(User.last)
    end
  end
end
