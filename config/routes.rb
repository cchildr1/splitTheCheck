Rails.application.routes.draw do
  root 'restaurants#index', as: 'restaurants_index'
  resources :restaurants, except: :destroy
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
