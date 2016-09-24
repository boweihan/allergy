Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/products' => 'pages#products'
  get '/ingredients' => 'pages#ingredients'
  get '/cross_reference' => 'pages#cross_reference'
  get '/search_products' => 'pages#search_products'
  get '/search_ingredients' => 'pages#search_ingredients'
end
