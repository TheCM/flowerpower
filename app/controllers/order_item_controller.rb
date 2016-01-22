class OrderItemController < ApplicationController
  def new
    @parameters = product_params
  end

  def create
  end

  def show
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:format)
  end
end
