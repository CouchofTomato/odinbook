require 'rails_helper'

feature 'Post management' do
  scenario 'viewing a post' do
    user = create(:user)
    user_post = create(:post, user: user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    first('.post').click
    expect(current_path).to eq post_path(user_post)
  end

  scenario 'viewing the newsfeed' do
    user = create(:user)
    user_post = create(:post, user: user, content: "Hello, duckface")
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Newsfeed'
    expect(page).to have_selector('.post')
    expect(page).to have_content('Hello, duckface')
  end

  scenario 'creating a new post' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'New Post'
    expect(current_path).to eq new_user_post_path
    fill_in 'Content', with: "Ran over my neighbours foot. YOLO!"
    click_on 'Post'
    expect(current_path).to eq post_path(Post.last)
  end
end
