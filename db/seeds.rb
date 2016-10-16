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

# sql = "COPY products (name, created_at, updated_at, id) FROM '#{Rails.root}/products_ingredients/product_names_sun.txt'"
# 
# ActiveRecord::Base.connection.execute sql

# ActiveRecord::Base.transaction do
#   
#   product_array = []
#   full_ingredient_array = []
#   
#   products = []
#   ingredients = []
#   
#   File.open("./products_ingredients/product_names_sun.txt", "r") do |product_names|
#     product_names.each_line do |product|
#       product_array << product
#     end
#   end
# 
#   File.open("./products_ingredients/ingredient_list_sun.txt", "r") do |ingredient_list|
#     ingredient_list.each_line do |ingredient_line|
#       full_ingredient_array << ingredient_line
#     end
#   end
#   
#   for i in 0..product_array.length
#     product_name = product_array[i]
#     product_name.chop!
#     
#     # using new here to take advantage of speed in activerecord-import
#     products << Product.new(name: product_name, categories: "sun")
# 
#     ingredient_line = full_ingredient_array[i].split(":")
#     ingredient_line.pop
#     
#     puts i;
#     
#     ingredient_line.each do |ingredient|
#       
#       #find_or_initialize by to just do one query and avoid saving
#       ing = Ingredient.where(name: ingredient).first
#       prod = Product.where(name: product_array[i]).first
#       if ing
#         products = ing.products
#         products << prod
#         ing.update(products: products)
#       else
#         Ingredient.create(name: ingredient, products: [prod])
#       end
#       
#     
#     end
#   end
#   
#   Product.import products
#   Ingredients.import ingredients
# end

categories = ["sun", "skin_care", "oral_care", "nails", "men", "makeup", "hair", "fragrance", "babies"]
prod_temp = {}
ing_temp = {}

categories.each do |category|
  
  product_array = []
  skip_array = []
  
  ActiveRecord::Base.transaction do
    
    File.open("./products_ingredients/product_names_" + category + ".txt", "r") do |product_names|
      counter = 0
      product_names.each_line do |product|
        if prod_temp.key?(product)
          #IF PRODUCT HAS been added, add line skip
          skip_array << counter
        else
          prod_temp[product] = true
          #create products and also store them in product_array to use when creating ingredients
          product_array << Product.create(name: product, categories: category)
        end
        counter += 1
      end
    end

    File.open("./products_ingredients/ingredient_list_" + category + ".txt", "r") do |ingredient_list|
      counter = 0
      skipped_products = 0
      ingredient_list.each_line do |ingredient_line|
        if skip_array.include?(counter)
          puts "skipped #{product_array[counter]}"
          skipped_products += 1
        else
          ingredients = ingredient_line.split(":")
          ingredients.pop
          ingredients.each do |ingredient|
            ing_temp.key?(ingredient) ? ing_temp[ingredient] = ing_temp[ingredient] << product_array[counter - skipped_products] :
              ing_temp[ingredient] = [product_array[counter - skipped_products]]
          end
        end
        counter += 1
        puts "counter = #{counter}, skipped_products = #{skipped_products}"
      end
    end
  
  end
end

counter = 0
ing_temp.each do |ingredient, products|
  Ingredient.create(name: ingredient, products: products)
  counter += 1
  puts counter
end