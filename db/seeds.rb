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

ActiveRecord::Base.transaction do
  
  product_array = []
  full_ingredient_array = []
  p_array = []
  i_array = []
  
  File.open("./products_ingredients/product_names_sun.txt", "r") do |product_names|
    product_names.each_line do |product|
      product_array << product
    end
  end

  File.open("./products_ingredients/ingredient_list_sun.txt", "r") do |ingredient_list|
    ingredient_list.each_line do |ingredient_line|
      full_ingredient_array << ingredient_line
    end
  end
  
  for i in 0..product_array.length
    product_name = product_array[i]
    product_name.chop!
    p_array << Product.new(name: product_name, categories: "sun")
    
    ingredient_line = full_ingredient_array[i].split(":")
    ingredient_line.pop
    
    puts i;
    
    ingredient_line.each do |ingredient|
      current_ingredient = Ingredient.where(name: ingredient).first
      if current_ingredient
        old_associations = current_ingredient.products
        old_associations << Product.where(name: product_array[i]).first
        current_ingredient.update(products: old_associations)
      else
        Ingredient.new(name: ingredient, products: [Product.where(name: product_array[i]).first])
      end  
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