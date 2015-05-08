require 'rails_helper'

feature 'endorsing reviews' do

  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'abomination')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse KFC'
    expect(page).to have_content('1 endorsement')
    click_link 'Endorse KFC'
    expect(page).to have_content('2 endorsement')
    click_link 'Endorse KFC'
    click_link 'Endorse KFC'
    expect(page).to have_content('4 endorsement')
  end

end