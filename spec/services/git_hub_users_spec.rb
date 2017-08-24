require 'rails_helper'

describe GitHubUser do

  before(:each) do
    uid = 25035051
    screen_name = "swdonovan"

    user = User.create(uid: uid, screen_name: screen_name)
    @github_user = GitHubUser.new(user)
  end

  describe "#github user", :vcr do
    it 'find the correct user' do
      expect(@github_user.data.username).to eq("swdonovan")
      expect(@github_user.profile['login']).to eq("swdonovan")
      expect(@github_user.user['screen_name']).to eq("swdonovan")
    end

    it 'has a github_@data method as an attribute' do
      expect(@github_user.data.class).to eq(GitHubData)
    end

    it 'followers returns an array of follower objects' do
      followers = @github_user.followers

      expect(followers.first['login']).to eq("thedanielvogelsang")
    end

    it 'repos returns an array of repo objects' do
      repos = @github_user.repos

      expect(repos.first.repo_name).to eq("backend-curriculum-site")
      expect(repos.first.owner_name).to eq("swdonovan")
    end

    it 'events returns an array of event objects' do
      events = @github_user.events
      expect(events.first['id']).to eq("6506954160")
      expect(events.first['type']).to eq("PushEvent")
      expect(events.first['repo']['name']).to eq("swdonovan/ghub_mini_bro")
    end

    it 'starred returns an array of starred objects' do
      starred = @github_user.starred

      expect(starred.count).to eq(0)
    end

    it 'commits count returns a correct count of commits' do
      count = @github_user.commits_count

      expect(count).to eq(404)
    end

    it 'following returns an array of followees objects' do
      following = @github_user.following

      expect(following.first.username).to eq("mikedao")
      expect(following.first.class).to eq(Followee)
    end

    it 'following returns an array of organization objects' do
      organizations = @github_user.organizations

      expect(organizations).to eq([])
    end
  end
end
