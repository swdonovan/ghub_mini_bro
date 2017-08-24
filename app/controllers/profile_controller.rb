class ProfileController < ApplicationController
  def index
    user         = User.find(current_user.id)
    @github_user = GitHubUser.new(user)
    @profile     = @github_user.profile
    @following   = @github_user.following
    @starred     = @github_user.starred
    @followers   = @github_user.followers
    @repos       = @github_user.repos
  end
end
