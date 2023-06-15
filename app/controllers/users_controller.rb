class UsersController < ApplicationController
  def index;end

  def favorite_language
    username = params[:username]

    if username.blank?
      flash[:alert] = 'Please provide a GitHub username.'
    else
      begin
        favorite_language = GithubService.get_favorite_language(username)
        flash[:notice] = "The favorite programming language of #{username} is #{favorite_language}."
      rescue StandardError => e
        flash[:alert] = e.message
      end
    end

    redirect_to root_path
  end
end
