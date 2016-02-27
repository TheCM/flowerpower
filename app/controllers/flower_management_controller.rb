class FlowerManagementController < ApplicationController
  def main_menu

  end

  def flower_list
    @products = Product.all
  end

  def new_product

  end

  def create_product
    product_parameters = product_params
    @product = Product.new({:name => product_parameters[:name],:price => product_parameters[:price],:description => product_parameters[:description]})
    image = product_parameters[:image]
    if correct_file?(image)
      #zapisz obrazek
      image = params[:product][:image].original_filename
      directory = "app/assets/images"
      path = File.join(directory, image)
      path2 = File.join(directory, product_parameters[:name])
      File.open(path, "wb") { |f| f.write(product_parameters[:image].read)}
      File.rename(path, path2)
      redirect_to flower_management_main_menu_path, notice: 'A teraz sprawdź lokalizację pliku! '
    else
      redirect_to flower_management_new_product_path, notice: 'Nie udało siś zapisać kwiatu - niepoprawny plik. Spróbuj ponownie!'
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
    @products = Product.all
    @products_before = @products.size()

    Product.delete_all "name = 'Bukiet'"

    respond_to do |format|
      format.html { redirect_to flower_management_main_menu_path, notice: 'Usunięto ' + (@products_before - @products.size).to_s + ' bukietow.' }
      format.json { head :no_content }
    end

  end

  def delete_all_order_items
    OrderItem.delete_all

    respond_to do |format|
      format.html { redirect_to flower_management_main_menu_path, notice: ' Usunieto wszystkie produkty w zamowieniach. ' }
      format.json { head :no_content }
    end

  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end

end
