Rails.application.routes.draw do
  root 'spotchecks#index'
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :spotchecks

  get 'spotchecks/:id/download' => 'spotchecks#download', as: 'download_spotcheck'

  get 'preferences/get' => 'preferences#get', as: 'get_preferences'

  post 'preferences/update' => 'preferences#update', as: 'update_preference'

  resources :spots do
    post :update_row_order, on: :collection
  end

  resources :activities
end
