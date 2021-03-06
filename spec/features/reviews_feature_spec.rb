require 'rails_helper'

feature 'reviewing' do

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  def sign_up(email, password)
    visit '/users/sign_up'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'LET ME YALP!'
  end

  before {
          sign_up('tester@before.com', 'testtest')
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'KFC'
          click_button 'Create Restaurant'

            }

  scenario 'allow users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('so so', '3')
    leave_review('great', '5')
    expect(page).to have_content 'Average rating: ★★★★☆'
  end

  # context 'users cannot delete their own review they did not make' do

  #   scenario 'logged out user' do
  #     visit '/restaurants'
  #     expect(page).not_to have_link 'Delete KFC'
  #     restaurant = Restaurant.find_by_name('KFC')
  #     page.driver.submit :delete, "/restaurants/#{restaurant.id}/reviews/#{review.id}", {}
  #     expect(page).to have_content 'You need to sign in or sign up before continuing'
  #   end

  #   scenario 'logged in user' do
  #     sign_up('test@test.com', 'testtest')
  #     visit '/restaurants'
  #     expect(page).not_to have_link 'Delete KFC'
  #     restaurant = Restaurant.find_by_name('KFC')
  #     page.driver.submit :delete, "/restaurants/#{restaurant.id}/reviews/#{review.id}", {}
  #     expect(page).to have_content 'Users can only delete restaurants they have created!'
  #   end
  # end

  # scenario 'users can delete their own review' do
  #   visit '/restaurants'
  #   click_link 'Review KFC'
  #   fill_in 'Thoughts', with: 'so so'
  #   select '3', from: 'Rating'
  #   click_button 'Leave Review'
  #   expect(current_path).to eq '/restaurants'
  #   click_link 'Delete this review'
  #   expect(page).to have_content 'Review deleted'
  #   expect(page).not_to have_content 'so so'
  #   expect(current_path).to eq '/restaurants'
  # end
end