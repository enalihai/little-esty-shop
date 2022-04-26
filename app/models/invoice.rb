class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: ["in progress".to_sym, :completed, :cancelled]

  def self.incomplete
    joins(:invoice_items)
    .where('invoice_items.status != ?', '2')
    .distinct
    .order(:id)
  end

  def self.sorted_by_newest
    order(created_at: :desc)
  end

  def dates
    created_at.strftime("%A, %B %d, %Y")
  end

  def full_name
    customer.first_name + " " +  customer.last_name
  end

  def discount_for_merchant(merchant)
    discount = merchants.where(id: merchant.id)
                        .joins(:bulk_discounts)
                        .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
                        .select('invoice_items.*')
                        .group('invoice_items.item_id')
                        .max('invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage / 100')
                        .first_name
                        .sum
                        discount / 100.to_f 
  end
  def invoice_total_revenue
    invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def invoice_total_revenue_after_discount
    invoice_items.joins(:bulk_discounts)
    binding.pry
    # invoice_items.joins(item: {merchant: :bulk_discounts}).select('invoice_items.*, (100 - (bulk_discounts.percentage_discount)) / 100 * invoice_items.unit_price AS discounted_unit_price').group(:id)
    # # .sum('discounted_unit_price * invoice_items.quantity')
    # invoice_items.select('invoice_items.*, invoice_items.unit_price_after_discount AS discount_unit_price')
    # .sum('invoice_items.quantity * discount_unit_price')
  end
end
