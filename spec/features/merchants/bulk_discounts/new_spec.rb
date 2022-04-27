require 'rails_helper'

RSpec.describe 'new merchant bulk discount' do
  it 'creates a new bulk discount then routes to the index page' do
    merchant_1 = Merchant.create(name: "Drew's")

    visit "/merchants/#{merchant_1.id}/bulk_discounts/new"

    fill_in 'percentage_discount', with: '35'
    fill_in 'quantity_threshold', with: '75'
    click_button 'Create'

    expect(page).to have_current_path("/merchants/#{merchant_1.id}/bulk_discounts")
    within"#bulk_discounts" do
      expect(page).to have_content('35%')
      expect(page).to have_content('75')
    end
  end
end
