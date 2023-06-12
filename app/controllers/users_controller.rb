class UsersController < ApplicationController
  def index;end

  def favorite_language
    username = params[:username]

    if username.blank?
      flash[:alert] = 'Please provide a GitHub username.'
      redirect_to root_path
    else
      repositories = GithubService.get_repositories(username)
      languages = Hash.new(0)

      repositories.each do |repo|
        languages[repo['language']] += 1 if repo['language']
      end

      favorite_language = languages.max_by { |_, count| count }&.first || 'Unknown'

      flash[:notice] = "The favorite programming language of #{username} is #{favorite_language}."
      redirect_to root_path
    end
  rescue StandardError => e
    flash[:alert] = e.message
    redirect_to root_path
  end
end
