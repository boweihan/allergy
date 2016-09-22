class PagesController < ApplicationController
  def products
    @products = Product.all
    render json: @products
  end
  
  def ingredients
    @ingredients = Ingredient.all
    render json: @ingredients
  end
end
