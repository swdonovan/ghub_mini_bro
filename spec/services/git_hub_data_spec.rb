require 'rails_helper'


describe GitHubData do
  attr_reader :data

  before(:each) do
    uid = 25035051
    screen_name = "swdonovan"

    user = User.create(uid: uid, screen_name: screen_name)
    @data = GitHubData.new(user.screen_name)
  end

  describe "github data service calls the github API", :vcr do
    it "initializes get_request & NET::HTML connection" do

      expect(@data.auth).to eq("?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}")
      expect(@data.username).to eq("swdonovan")
    end

    it "returns the user profile" do
      profile = @data.profile

      expect(profile["login"]).to eq("swdonovan")
      expect(profile["url"]).to eq("https://api.github.com/users/swdonovan")
    end

    it "returns followers" do
      followers = @data.followers

      expect(followers.first['login']).to eq("thedanielvogelsang")
    end

    it "returns repos" do
      repos = @data.repos

      expect(repos.first["name"]).to eq("backend-curriculum-site")
      expect(repos.first["owner"]["login"]).to eq("swdonovan")
    end

    it "returns events" do
      events = @data.events

      expect(events.first["actor"]["login"]).to eq("swdonovan")
    end

    it "returns organizations" do
      organizations = @data.organizations

      expect(organizations).to eq([])
    end

    it "returns number of starred repos" do
      starred = @data.starred

      expect(starred.count).to eq(0)
    end

    it "returns following" do
      following = @data.following

      expect(following.first["login"]).to eq("mikedao")
    end
  end
end
