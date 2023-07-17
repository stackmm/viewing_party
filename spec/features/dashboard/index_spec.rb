require 'rails_helper'

RSpec.describe 'Landing Page' do
  before(:each) do
    @user1 = User.create!(name: 'John Smith', email: 'jsmith@aol.com', password: 'password', password_confirmation: 'password')
    @user2 = User.create!(name: 'Jane Doe', email: 'jdoe@gmail.com', password: 'password1', password_confirmation: 'password1')
    @user3 = User.create!(name: 'Michael Jackson', email: 'mjack@gmail.com', password: 'password2', password_confirmation: 'password2')

    visit root_path
  end

  it 'displays the title of the application' do
    within('#title') do
      expect(page).to have_content('Viewing Party')
    end
  end

  it 'displays a button to create a new user' do
    within('#create-user') do
      expect(page).to have_button('Create User')
    end
  end

  it 'displays a list of existing users which links to the users dashboard' do
    within('#existing-users') do
      expect(page).to have_content('Existing Users')
      expect(page).to have_link(@user1.name)
      expect(page).to have_link(@user2.name)
      expect(page).to have_link(@user3.name)
    end
  end

  it 'displays a link to go back to the landing page' do
    within('#nav-bar') do
      expect(page).to have_link('Home')

      click_link('Home')
      expect(current_path).to eq(root_path)
    end
  end

  it 'displays a link to log in' do
    within('#nav-bar') do
      expect(page).to have_link('Log In')

      click_link('Log In')
      expect(current_path).to eq(login_path)
    end
  end
end
