class GitHubUser
  attr_reader :data,
              :user

  def initialize(user)
    @user = user
    @data = GitHubData.new(@user.screen_name)
  end

  def profile
    data.profile
  end

  def commits
    commits = repos.map {|repo| repo.commits if repo.commits}
  end

  def sorted_commits
    commits.flatten.sort_by {|commit| commit.created_at}.reverse
  end

  def repos
    data.repos.map { |repo| Repo.new(repo) }
  end

  def commits_count
    count = repos.inject(0) do |sum, repo|
      sum += repo.commits.count
      sum
    end
  end

  def followers
    data.followers
  end

  def following
    data.following.map { |followee| Followee.new(followee)}
  end

  def starred
    data.starred
  end

  def events
    data.events
  end

  def all_events
    following.inject(Array.new) do |array, followee|
      array << followee.events
      array
    end
  end
end
