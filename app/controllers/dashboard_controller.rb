class DashboardController < ApplicationController
  def index
    user         = set_user
    @github_user = GitHubUser.new(user)
    @events      = @github_user.events
    @following   = @github_user.following
    @all_events  = @github_user.all_events
    @repos       = @github_user.repos
    @commits     = @github_user.sorted_commits
  end

  private

  def set_user
    user = User.find(current_user.id)
  end
end
