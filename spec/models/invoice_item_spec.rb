require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_many(:bulk_discounts).through(:item)}
    it { should have_many(:merchants).through(:item)}
  end

  describe 'class methods' do
    it '#total_revenue' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      item_2 = walmart.items.create!(name: "eraser", description: "rubber bit", unit_price: 200)

      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 6, status: 1, unit_price: 295)
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 2, status: 0, unit_price: 215)
      expect(InvoiceItem.total_revenue).to eq(2200)
    end
  end
    it '#unit_price_after_discounts' do
      walmart = Merchant.create!(name: "Wal-Mart")

      bulk_discount_1 = walmart.bulk_discounts.create!(quantity_threshold: 50, percentage_discount: 25)
      bulk_discount_2 = walmart.bulk_discounts.create!(quantity_threshold: 100, percentage_discount: 35)
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)

      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

      invoice_item = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 80, status: 1, unit_price: item_1.unit_price)

      expect(invoice_item.unit_price_after_discount).to eq(225)
    end
end
