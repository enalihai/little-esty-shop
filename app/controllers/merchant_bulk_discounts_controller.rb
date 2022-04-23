class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:bulk_discounts_id])
  end
end
private
def bulk_discount_params
  params.permit(:percentage_discount, :quantity_threshold)
end
