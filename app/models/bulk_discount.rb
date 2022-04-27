class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :invoices, through: :merchant
end
