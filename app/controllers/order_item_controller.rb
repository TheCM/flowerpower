class OrderItemController < ApplicationController
  def new
    if (!session[:order_id])
      @current_order = Order.new({:first_name => "newName", :last_name => "newLastName", :address => "address", :email => "mail@mail.com", :status => "not initiated"})
      if @current_order.save
        @the_text = 'Current order has just created!'
      else
        @the_text = @current_order.save!
      end
      session[:order_id] = @current_order.attributes['id']
    else
      @current_order = Order.find(session[:order_id])
      @the_text = 'Current order is already done!'
    end
    @order_item = OrderItem.new(quantity: params[:quantity])
    @product = Product.find(product_params)
    @order_item.product = @product
    @the_error = @product.attributes
    #@the_error = @current_order.order_items.create!(order_id: session[:order_id], product_id: params[:product_id], quantity: params[:quantity])
    # session[:product_id] = product_params
    # <td><%= link_to 'add to cart', order_item_new_path(product_id: product.id, quantity: '1') %></td>
    # session[:product_id] = nil
    # @current_order.attributes
    @parameters = params
  end

  def create
  end

  def show
  end

  def index
    @order_items = OrderItem.all
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product_id)
  end
end
