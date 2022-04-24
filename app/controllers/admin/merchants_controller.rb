class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:disable]
      merchant.update(status: 0)
      redirect_to "/admin/merchants"
    elsif params[:enable]
      merchant.update(status: 1)
      redirect_to admin_merchants_path
    elsif merchant.update(merchant_params)
      redirect_to admin_merchant_path
      flash[:success] = "Information Successfully Updated"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def create
    merchant = Merchant.new(merchant_params)
    merchant.save
    redirect_to admin_merchants_path
  end

private
    def merchant_params
      params.permit(:name)
    end
end
