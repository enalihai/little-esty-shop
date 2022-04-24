require 'rails_helper'

RSpec.describe 'merchant bulk discount show' do
  it 'shows bulk discount attributes' do
    merchant_1 = Merchant.create(name: "Drew's")
    merchant_2 = Merchant.create(name: "Geddy's")

    bulk_discount_1 = merchant_1.bulk_discounts.create(percentage_discount: 20, quantity_threshold:15  )
    bulk_discount_2 = merchant_1.bulk_discounts.create(percentage_discount: 30, quantity_threshold:25  )
    bulk_discount_3 = merchant_2.bulk_discounts.create(percentage_discount: 10, quantity_threshold:22  )

    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}"
    expect(page).to have_content('20%')
    expect(page).to have_content('15')
    expect(page).to_not have_content('10%')
    expect(page).to_not have_content('22')
  end

  it 'has link to edit bulk discount' do
    merchant_1 = Merchant.create(name: "Drew's")
    merchant_2 = Merchant.create(name: "Geddy's")

    bulk_discount_1 = merchant_1.bulk_discounts.create(percentage_discount: 20, quantity_threshold:15  )
    bulk_discount_2 = merchant_1.bulk_discounts.create(percentage_discount: 30, quantity_threshold:25  )
    bulk_discount_3 = merchant_2.bulk_discounts.create(percentage_discount: 10, quantity_threshold:22  )

    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}"
    click_link("Edit")

    expect(page).to have_current_path("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit")
    expect(page).to have_field("Percentage Discount", with: "20")
    expect(page).to have_field("Quantity Threshold", with: "15")

  end
  it 'has fields pre filled' do
    merchant_1 = Merchant.create(name: "Drew's")
    merchant_2 = Merchant.create(name: "Geddy's")

    bulk_discount_1 = merchant_1.bulk_discounts.create(percentage_discount: 20, quantity_threshold:15  )
    bulk_discount_2 = merchant_1.bulk_discounts.create(percentage_discount: 30, quantity_threshold:25  )
    bulk_discount_3 = merchant_2.bulk_discounts.create(percentage_discount: 10, quantity_threshold:22  )

    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit"

    expect(page).to have_field("Percentage Discount", with: "20")
    expect(page).to have_field("Quantity Threshold", with: "15")

  end

end
