class Repo
  attr_reader :data,
              :repo_name,
              :owner_name

  def initialize(repo = {})
    @repo         = repo
    @repo_name    = repo['name']
    @owner_name   = repo['owner']['login']
    @url          = repo['html_url']
    @data         = RepoData.new(@repo_name, @owner_name)
  end

  def commits
    data.commits.map { |commit| Commits.new(commit)  }
  end
end
