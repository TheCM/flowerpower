class CartController < ApplicationController
  def show
    @current_order = session[:order_id]
    @order_items = OrderItem.all
    @sum = 0
  end

  def payment
  end

  def thanks
    @current_order = Order.new({:first_name => "newName", :last_name => "newLastName", :address => "address", :email => "mail@mail.com", :status => "not initiated"})
    @current_order.save
    session[:order_id] = @current_order.attributes['id']
  end
end
