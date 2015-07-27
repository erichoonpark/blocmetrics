Rails.application.routes.draw do
  resources :apps
  devise_for :users
  get 'welcome/index'
  root to:'welcome#index'

  #API Controller

  namespace :api, defaults: { format: :json } do
  #Namespace keeps the API route seperate from the other routes/Expect request in JSON
     #Checks to see if events can be created
     match 'create_event', to: 'events#create', via: [:options]
     resources :events, only: [:create]
     #The app need to support the API for one resource
  end
end
