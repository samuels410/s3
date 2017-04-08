Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "photos#index"
  end
  root to: "visitors#index"
  devise_for :users
  resources :users
  resources :photos do
    member do
      get :download
    end
    collection do
      get :download_zip
      post :upload_photos
    end
  end
end
