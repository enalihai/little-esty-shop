class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @top_five = @merchant.top_five
    @ready_to_ship = @merchant.ready_to_ship
  end

  def invoices

  end
end
