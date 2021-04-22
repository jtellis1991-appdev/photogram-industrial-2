Rails.application.routes.draw do
  root "photos#index"

  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos

  get ":username/liked" => "photos#liked", as: :liked_photos
  get ":username/feed" => "photos#feed", as: :feed
  get ":username/followers" => "users#followers", as: :followers #list group (Bootstrap) with links to the other users
  get ":username/following" => "users#following", as: :following #list group (Bootstrap) with links to the other users
  get "/:username" => "users#show", as: :user
end
