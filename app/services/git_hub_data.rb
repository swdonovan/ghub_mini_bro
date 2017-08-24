require 'net/http'

class GitHubData < ApplicationController

  def initialize(username)
    @username     = username
    @auth         = "?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}"
  end

  def profile
    profile_data = get_request("https://api.github.com/users/#{@username}#{@auth}")
    profile = parse_response(profile_data)
  end

  def repos
    repos_data = get_request("https://api.github.com/users/#{@username}/repos#{@auth}")
    repos = parse_response(repos_data)
  end

  def followers
    followers_data = get_request("https://api.github.com/users/#{@username}/followers#{@auth}")
    followers = parse_response(followers_data)
  end

  def following
    following_data = get_request("https://api.github.com/users/#{@username}/following#{@auth}")
    following = parse_response(following_data)
  end

  def starred
    starred_data = get_request("https://api.github.com/users/#{@username}/starred#{@auth}")
    starred = parse_response(starred_data)
  end

  def events
    events_data = get_request("https://api.github.com/users/#{@username}/events#{@auth}")
    events = parse_response(events_data)
  end

  def organizations
    org_data = get_request("https://api.github.com/users/#{@username}/orgs#{@auth}")
    org = parse_response(org_data)
  end

  def get_request(url)
    url = URI(url)
    @request = Net::HTTP.get(url)
  end

  def parse_response(data)
    @response = JSON.parse(data)
  end
end
