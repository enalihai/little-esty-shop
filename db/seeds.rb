# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
walmart = Merchant.create!(name: "Wal-Mart")

bulk_discount_1 = walmart.bulk_discounts.create!(quantity_threshold: 50, percentage_discount: 25)
bulk_discount_2 = walmart.bulk_discounts.create!(quantity_threshold: 100, percentage_discount: 35)
bob = Customer.create!(first_name: "Bob", last_name: "Benson")
item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)

invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 80, status: 1, unit_price: item_1.unit_price)
InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 110, status: 1, unit_price: item_1.unit_price)
