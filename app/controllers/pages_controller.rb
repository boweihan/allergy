class PagesController < ApplicationController
  def products
    @products = Product.all
    render json: @products
  end
  
  def ingredients
    @ingredients = Ingredient.all
    render json: @ingredients
  end
  
  def cross_reference
    #look through params for products being posted
    #loop through those products
    #check DB to find where product = params[product]
    #if product exists, grab ingredients and store in ingredients array
    #for each subarray in ingredients array, find the ones in common (uniq?)
    #render those ingredents as JSON
  end
  
  def search_products
    params[:ingredient] = "Lanolin"
    @products = Ingredient.where(name: params[:ingredient]).first.products
    render json: @products
  end
  
  def search_ingredients
    params[:product] = "AFM Safecoat WaterShield"
    @ingredients = Product.where(name: params[:product]).first.ingredients
    render json: @ingredients
  end
  
end
