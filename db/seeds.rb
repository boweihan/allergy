# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# test_product = Product.create(name: "Test Product")
# test_ingredient = Ingredient.create(name: "Test Ingredient", products: Product.where(name: "Test Product"))
require 'pry'

product_array = []
full_ingredient_array = []

File.open("product_names.txt", "r") do |product_names|
  product_names.each_line do |product|
    product_array << product
  end
end

File.open("ingredient_list.txt", "r") do |ingredient_list|
  ingredient_list.each_line do |ingredient_line|
    full_ingredient_array << ingredient_line
  end
end

for i in 0..product_array.length
  product_name = product_array[i]
  product_name.chop!
  product = Product.create(name: product_name)
  
  ingredient_line = full_ingredient_array[i].split(":")
  ingredient_line.pop
  
  puts i
  
  ingredient_line.each do |ingredient|
    if Ingredient.where(name: ingredient).first
      old_associations = Ingredient.where(name: ingredient).first.products
      old_associations << Product.where(name: product_array[i]).first
      Ingredient.where(name: ingredient).first.update(products: old_associations)
    else
      Ingredient.create(name: ingredient, products: [Product.where(name: product_array[i]).first])
    end
  
  end
end

# file.each_line do |ingredients|
#   ingredients_array = ingredients.split(":")
#   ingredients_array.each do |ingredient|
#     #check if ingredient exists, if it doesn't, put it into the database linked to the corresponding product
#     binding.pry
#     #if the ingredient does exist, modify the existing ingredient to add the corresponding product
  # end
# end