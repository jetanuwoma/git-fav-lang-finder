require 'rails_helper'

RSpec.describe GithubService do
  describe '.get_repositories' do
    it 'returns the user repositories' do
      username = 'testuser'
      repositories = [
        { 'name' => 'repo1', 'language' => 'Ruby' },
        { 'name' => 'repo2', 'language' => 'JavaScript' }
      ]

      stub_request(:get, "https://api.github.com/users/#{username}/repos")
        .to_return(body: repositories.to_json, status: 200)

      response = GithubService.get_repositories(username)

      expect(response).to eq(repositories)
    end

    it 'raises an error when unable to fetch repositories' do
      username = 'testuser'

      stub_request(:get, "https://api.github.com/users/#{username}/repos")
        .to_return(status: 404)

      expect {
        GithubService.get_repositories(username)
      }.to raise_error.with_message("Unable to fetch user repositories")
    end
  end
end
