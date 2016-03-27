Rails.application.routes.draw do
  use_doorkeeper
  namespace :v1 do
    jsonapi_resources :users, except: [:destroy]
    jsonapi_resources :conversations
    jsonapi_resources :user_conversations
  end
end
