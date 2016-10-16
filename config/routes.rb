Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/products' => 'pages#products'
  get '/ingredients' => 'pages#ingredients'
  get '/cross_products' => 'pages#cross_products'
  get '/cross_ingredients' => 'pages#cross_ingredients'
  get '/search_products' => 'pages#search_products'
  get '/search_ingredients' => 'pages#search_ingredients'
end
