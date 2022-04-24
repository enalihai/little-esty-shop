RSpec.describe 'merchant bulk discount edit' do
it 'has fields pre filled' do
  merchant_1 = Merchant.create(name: "Drew's")
  merchant_2 = Merchant.create(name: "Geddy's")

  bulk_discount_1 = merchant_1.bulk_discounts.create(percentage_discount: 20, quantity_threshold:15  )
  bulk_discount_2 = merchant_1.bulk_discounts.create(percentage_discount: 30, quantity_threshold:25  )
  bulk_discount_3 = merchant_2.bulk_discounts.create(percentage_discount: 10, quantity_threshold:22  )

  visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit"
  save_and_open_page
  expect(page).to have_field("Percentage discount", with: "20")
  expect(page).to have_field("Quantity threshold", with: "15")
end

end
