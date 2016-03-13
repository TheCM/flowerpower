# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# uploader = FlowerPictureUploader.new
Product.delete_all
@product = Product.create! id: 1, name: 'Truskawka', price: 8.0, description: 'This is example flower 1', status: 'active'
@product = Product.create! id: 2, name: 'Bratek', price: 5.0, description: 'This is example flower 2', status: 'active'
@product = Product.create! id: 3, name: 'Pokrzywa', price: 2.0, description: 'This is example flower 3', status: 'active'
@product = Product.create! id: 4, name: 'Róża', price: 13.0, description: 'This is example flower 4', status: 'active'
@product = Product.create! id: 8, name: 'Kaktus', price: 20.0, description: 'This is example flower 5', status: 'active'

@products = Product.all
@products.each do |product|
  File.open('app/assets/images/' + product.id.to_s + '.jpg') do |f|
    product.image = f
    product.save!
  end
end

OrderItem.delete_all
