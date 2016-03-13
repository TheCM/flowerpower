class FlowerManagementController < ApplicationController


  def main_menu
    check_user
  end

  def flower_list
    check_user
    @uploader = FlowerPictureUploader.new
    @products = Product.all
    @headers = true
  end

  def new_product
    check_user
  end

  def create_product
    check_user
    if product_parameters_are_correct?
      product_parameters = product_params
      product_parameters[:status] = 'active'
      @product = Product.new(product_parameters)
      if @product.save!
        redirect_to flower_management_main_menu_path, notice: "Udalo sie zapisac produkt " + @product[:name]
        product_image[:image].original_filename = @product[:id].to_s + '.jpg'
        @product.image = product_image[:image]
        @product.save!
      else
        redirect_to flower_management_main_menu_path, alert: "Nie udalo sie zapisac produktu"
      end
    else
      redirect_to request.referer, alert: "Złe parametry!"
    end

  end

  def update_product
    check_user

    # variable contains info about product name before change
    product_update = product_params_for_update
    @product = Product.find(product_update[:id])
    # create variable with all updated informations needed to update product (except image)
    product_params_corrected = product_params
    product_params_corrected[:status] = product_params_corrected[:status] ? "active" : "not active"
    if @product.update(product_params_corrected)
      redirect_to flower_management_flower_list_path, notice: "Modyfikacja produktu " + @product[:name] + " zakończona sukcesem!"
    else
      redirect_to flower_management_flower_list_path, alert: "Modyfikacja produktu " + @product[:name] + " zakończona porażką."
    end
  end

  def correct_file?(file_name)
    if /\.jpg$|\.jpeg$|\.png$/i =~ file_name
      return true
    else
      return false
    end
  end

  def delete_all_bunches
    check_user
    @products = Product.all
    @products_before = @products.size()

    Product.delete_all "name = 'Bukiet'"

    respond_to do |format|
      format.html { redirect_to flower_management_main_menu_path, notice: 'Usunięto ' + (@products_before - @products.size).to_s + ' bukietow.' }
      format.json { head :no_content }
    end

  end

  def delete_all_order_items
    check_user
    OrderItem.delete_all

    respond_to do |format|
      format.html { redirect_to flower_management_main_menu_path, notice: ' Usunieto wszystkie produkty w zamowieniach. ' }
      format.json { head :no_content }
    end

  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :status)
  end

  def product_params_for_update
    params.require(:product).permit(:id ,:old_name, :name, :price, :description, :status)
  end

  def product_image
    params.require(:product).permit(:image)
  end

  def check_user
    if !current_user
      redirect_to root_path, notice: "Odmowa dostępu"
    end
  end

  def product_parameters_are_correct?
    return product_params[:name] && product_params[:price] && product_image[:image]
  end

end
