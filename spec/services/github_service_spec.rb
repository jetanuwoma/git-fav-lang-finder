require 'rails_helper'

RSpec.describe GithubService do
  describe '.get_repositories' do
    describe '.get_favorite_language' do
      it 'returns the user favorite language' do
        username = 'testuser'
        repositories = [
          double(language: 'Ruby'),
          double(language: 'JavaScript')
        ]
        allow_any_instance_of(Octokit::Client).to receive(:repositories).with(username).and_return(repositories)

        favorite_language = GithubService.get_favorite_language(username)

        expect(favorite_language).to eq('Ruby')
      end

      it 'returns Unknown when user has no repositories' do
        username = 'testuser'
        repositories = []
        allow_any_instance_of(Octokit::Client).to receive(:repositories).with(username).and_return(repositories)

        favorite_language = GithubService.get_favorite_language(username)

        expect(favorite_language).to eq('Unknown')
      end

      it 'raises an error when unable to fetch repositories' do
        username = 'testuser'
        allow_any_instance_of(Octokit::Client).to receive(:repositories).with(username).and_raise(Octokit::Error)
        expect {
          GithubService.get_favorite_language(username)
        }.to raise_error.with_message("Unable to fetch user repositories")
      end
    end
  end
end
