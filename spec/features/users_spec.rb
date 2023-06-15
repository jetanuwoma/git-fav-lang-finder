require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  it 'displays the favorite language after submitting the form' do
    username = 'testuser'
    favorite_language = 'Ruby'

    allow(GithubService).to receive(:get_favorite_language).and_return(favorite_language)

    visit root_path

    fill_in 'username', with: username
    click_button 'Submit'

    expect(page).to have_content("The favorite programming language of #{username} is Ruby.")
  end

  it 'displays an error message when username is not provided' do
    visit root_path

    click_button 'Submit'

    expect(page).to have_content('Please provide a GitHub username.')
  end

  it 'displays an error message when unable to fetch repositories' do
    username = 'testuser'

    allow(GithubService).to receive(:get_favorite_language).and_raise("Unable to fetch user repositories")

    visit root_path

    fill_in 'username', with: username
    click_button 'Submit'

    expect(page).to have_content('Unable to fetch user repositories')
  end
end
