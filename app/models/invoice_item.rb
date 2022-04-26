class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item
  has_many :merchants, through: :item

  enum status: [:pending, :packaged, :shipped]


  def self.total_revenue
    sum('unit_price * quantity')
  end

  def unit_price_after_discount
  (100 - item.merchant.bulk_discounts.where("quantity_threshold < ?", quantity).max.percentage_discount.to_f)/100  * item.unit_price
  end

  def revenue_after_discount
    quantity * unit_price_after_discount
  end

  def invoice_dates
    invoice.created_at.strftime("%A, %B %d, %Y")
  end

  def self.ready_to_ship
    where(status: "packaged").order('created_at DESC')
  end

  def belongs_to_merchant(merchant_id)
    if item.merchant_id == merchant_id.to_i
      return true
    else
      return false
    end
  end
end
