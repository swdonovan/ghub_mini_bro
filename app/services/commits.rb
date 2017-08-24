class Commits
  attr_reader :created_at,
              :message

  def initialize(data)
    @commit     = data
    @created_at = data['commit']['committer']['date']
    @message    = data['commit']['message']
  end
end
