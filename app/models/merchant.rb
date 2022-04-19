class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five
    customers.joins(:transactions)
    .group(:id)
    .where('transactions.result = ?', 'success')
    .order('count(customers.id) desc')
  end

  def items_and_invoice_items
    items.joins(:invoice_items)
    .select('items.*, invoice_items.quantity, invoice_items.unit_price')
    .group('items.id')
  end

  def most_popular_items
    items.joins(:transactions)
    .select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .where("transactions.result = 'success' AND invoices.status = 1")
    .group('items.id')
    .order('total_revenue desc')
    .pluck(:name)
    .limit(5)
  end

  def invoice_dates
    invoice.created_at.strftime("%A, %B %d, %Y")
  end

  def distinct_invoices
    invoices.distinct
  end

  def self.top_five_by_revenue
    joins(:items).joins(:transactions)
    .select('merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .where(transactions: { result: "success" })
    .group('merchants.name')
    .order('total_revenue desc')
    .limit(5)
  end
end
