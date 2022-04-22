require 'rails_helper'

RSpec.describe 'merchant bulk discount index' do
  it 'shows percentage_discount and quantity for each bulk discount' do
    fill_in 'Percentage Discount', with: '35'
    fill_in 'Quantity Threshold', with: '75'
    click_button 'Save'

    expect(page).to have_current_path('/merchants/#{@merchant.id}/bulk_discounts')
    within"#bulk_discounts" do
      expect(page).to have_content('35%')
      expect(page).to have_content('75')
    end
  end
end
