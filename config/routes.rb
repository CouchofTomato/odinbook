Rails.application.routes.draw do
  
  devise_for :users
  resource :user do
    resource :profile
    resources :friendships
    resources :posts do
      resource :like
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
