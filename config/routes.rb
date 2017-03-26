Rails.application.routes.draw do
  get 'users/new'

  get 'static_pages/home'

  root 'static_pages#home'
end
