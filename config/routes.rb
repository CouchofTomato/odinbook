Rails.application.routes.draw do
  

  devise_for :users
  resource :user do
    resources :profiles, except: [:index]
    resources :friendships
    resources :posts do
      resource :like
      resource :comment
    end
  end
  resources :profiles, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
