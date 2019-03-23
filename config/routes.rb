Rails.application.routes.draw do
  root 'restaurants#index', as: 'restaurants_index'
  resources :restaurants, except: :destroy
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/upvote/:id", to: "restaurants#upvote", as: "restaurants_upvote"
  get "/downvote/:id", to: "restaurants#downvote", as: "restaurants_downvote"
  get '/search', to: 'restaurants#search', as: 'search_page'
end
