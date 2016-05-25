Rails.application.routes.draw do
  root 'spotchecks#index'
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :spotchecks

  resources :spots

  resource :activities

  # patch '/activities/create' => 'activities#create'

end
