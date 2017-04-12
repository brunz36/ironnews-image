Rails.application.routes.draw do
  resources :stories do
    resources :comments
  end

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  mount Shrine::DownloadEndpoint => "/attachments"

  root 'stories#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
