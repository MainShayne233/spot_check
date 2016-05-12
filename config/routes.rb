Rails.application.routes.draw do
  root 'spotchecks#home'
  devise_for :users

  resources :spotchecks

end
