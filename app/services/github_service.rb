class GithubService
  def self.get_favorite_language(username)
    client = Octokit::Client.new

    repositories = client.repositories(username)
    languages = Hash.new(0)

    repositories.each do |repo|
      languages[repo.language] += 1 if repo.language
    end

    favorite_language = languages.max_by { |_, count| count }&.first || 'Unknown'
  rescue Octokit::Error => e
    raise "Unable to fetch user repositories"
  end
end
