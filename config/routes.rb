Rails.application.routes.draw do
  root   'static_pages#home'
  get    'static_pages/home'
  get    '/signup',         to: 'users#new'
  post   '/signup',         to: 'users#create'
  get    '/login',          to: 'sessions#new'
  post   '/login',          to: 'sessions#create'
  delete '/logout',         to: 'sessions#destroy'
  
  
  resources :users do
    resource :profiles, except: :show, path_names: { edit: "" }
    member do
      get 'matches'
    end
  end
end
