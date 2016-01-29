class FlowerBunchController < ApplicationController
  def application
    @products = Product.all
  end


  def create
    #find order id or create new one
    if (!session[:order_id])
      @current_order = Order.new({:first_name => "newName", :last_name => "newLastName", :address => "address", :email => "mail@mail.com", :status => "not initiated"})
      @current_order.save
      session[:order_id] = @current_order.attributes['id']
    else
      @current_order = Order.find(session[:order_id])
    end

    #create new product
    #na koncu w description powinny sie znaleźć nazwy i ilość produktów składowych bukietu
    @bunch = Product.new(:name => "Bukiet", :price => params[:price], :description => params[:description])
    @bunch.save

    #create order item to current order
    @order_item = OrderItem.new(quantity: 1)
    @order_item.product = @bunch
    @order_item.order = @current_order
    @order_item.save!

    #Redirect to cart to show there is new product or redirect to FlowerBunch to create new bunch
    if (params[:check] == "false")
      respond_to do |format|
        format.html { redirect_to cart_show_path, notice: 'Dodano nowy bukiet!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to flower_bunch_application_path, notice: 'Dodano nowy bukiet!' }
      end
    end
  end

  private
  def product_params
    params.require(:product).permit(:price, :description)
  end
end
