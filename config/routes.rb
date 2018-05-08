Rails.application.routes.draw do
  
  resources :events 
  
  get '/events/:id/subscribe', to: 'events#subscribe', as: 'subscribe_event'

  devise_for :users
  root 'home#index'
  

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
