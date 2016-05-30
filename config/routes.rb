Rails.application.routes.draw do
  root 'spotchecks#index'
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :spotchecks

  get 'spotchecks/:id/download' => 'spotchecks#download', as: 'download_spotcheck'
  resources :spots
  resources :activities
end
