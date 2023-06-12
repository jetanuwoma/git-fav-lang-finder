require 'net/http'
require 'json'

class GithubService
  def self.get_repositories(username)
    url = URI("https://api.github.com/users/#{username}/repos")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    JSON.parse(response.read_body)
  rescue StandardError => e
    raise "Unable to fetch user repositories"
  end
end
