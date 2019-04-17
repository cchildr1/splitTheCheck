Rails.application.routes.draw do
  devise_for :users
  root 'restaurants#index', as: 'restaurants_index'
  resources :restaurants, except: :destroy do
    resources :comments
  end
  resources :favorite, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/upvote/:id", to: "restaurants#upvote", as: "restaurants_upvote"
  get "/downvote/:id", to: "restaurants#downvote", as: "restaurants_downvote"
  get '/search', to: 'restaurants#search', as: 'search_page'
end
