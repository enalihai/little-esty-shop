class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_five = Merchant.top_five_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to admin_merchant_path
    flash[:success] = "Information Successfully Updated"
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

private
    def merchant_params
      params.permit(:name)
    end
end
