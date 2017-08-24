class Followee
  attr_reader :avatar_url,
              :username,
              :data
  def initialize(followee)
    @user       = followee
    @username   = followee['login']
    @data       = GitHubData.new(@username)
    @avatar_url = followee['avatar_url']
  end

  def repos
    data.repos
  end

  def events
    data.events
  end
end
