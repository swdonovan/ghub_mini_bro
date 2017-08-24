require 'net/http'

class RepoData
  def initialize(repo_name, owner_name)
    @repo_name  = repo_name
    @owner_name = owner_name
    @auth       = "?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}"
  end

  def commits
    commits_data = get_request("https://api.github.com/repos/#{@owner_name}/#{@repo_name}/commits#{@auth}")
    commits      = parse_response(commits_data)
  end

  def issues
    issues_data = get_request("https://api.github.com/repos/#{@owner_name}/#{@repo_name}/issues#{@auth}")
    issues      = parse_response(issues_data)
  end

  def pull_requests
    issues.find_all do |issue|
      issue['pull_request'] != nil
    end
  end

  private

  def get_request(url)
    url = URI(url)
    @request = Net::HTTP.get(url)
  end

  def parse_response(data)
    @response = JSON.parse(data)
  end
end
