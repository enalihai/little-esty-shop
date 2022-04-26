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


  def invoice_total_revenue
    invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def discount_for_merchant(merchant)
    discount = merchants.where(id: merchant.id)
                        .joins(:bulk_discounts)
                        .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
                        .select('invoice_items.id')
                        .group('invoice_items.item_id')
                        .maximum('invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount / 100')
                        .pluck(1)
                        .sum
                        discount
  end

  def total_invoice_discount
    discount = merchants.joins(:bulk_discounts)
                        .where(:id == :merchant_id)
                        .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
                        .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount / 100.0) AS discount_total')
                        .group('invoice_items.id')
                        discount.sum(&:discount_total)
  end

  def invoice_total_revenue_after_discount
    invoice_total_revenue - total_invoice_discount
  end
end
