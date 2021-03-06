Rails.application.routes.draw do
  root   'static_pages#home'
  get    'static_pages/home'
  get    '/static_pages/:page' => 'static_pages#show'
  get    '/terms',        to:'static_pages#terms'
  get    '/support',        to:'static_pages#support'
  get    '/privacy',        to:'static_pages#privacy'
  get    '/faq',        to:'static_pages#faq'
  get    '/signup',         to: 'users#new'
  post   '/signup',         to: 'users#create'
  get    '/signin',          to: 'sessions#new'
  post   '/signin',          to: 'sessions#create'
  delete '/logout',         to: 'sessions#destroy'
  
   resources :users do
    member do
      get :likes, :likers
    end
  end
  
  resources :users do
    resource :profiles, except: :show, path_names: { edit: "" }
    member do
      get 'matches'
    end
  end
  resources :likeables,       only: [:create, :destroy]
end
