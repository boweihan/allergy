class PagesController < ApplicationController
  
  def products
    @products = Product.where('lower(name) LIKE ?', "%#{params[:name].downcase}%").first(100);
    render json: @products
  end
  
  def ingredients
    @ingredients = Ingredient.all
    render json: @ingredients
  end
  
  def cross_reference
    params[:product] = ["A+D Original Ointment, Diaper Rash \u0026 All Purpose Skincare Formula", "Avon Pink Suede Eau de Toilette Spray", "Avon Vintage Cologne Spray"]
    @products = Product.where(name: params[:product])
    ingredients_in_common = nil
    
    @products.each do |product|
      ingredients_in_common == nil ? ingredients_in_common = product.ingredients : ingredients_in_common = ingredients_in_common & product.ingredients
    end
    
    render json: ingredients_in_common
    #product[]=1&product[]=2 to pass an array of values into the query string
  end
  
  def search_products
    @products = Ingredient.where(name: params[:ingredient]).first.products
    render json: @products
  end
  
  def search_ingredients
    @ingredients = Product.where(name: params[:product]).first.ingredients
    render json: @ingredients
  end
  
end
