Rails.application.routes.draw do
  
  root 'posts#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resource :user do
    resource :profile, only: [:show, :edit, :update]
    resources :friendships, except: [:edit], path_names: { update: 'accepted' }
    resources :posts, except: [:show] do
      resource :like
      resource :comment
    end
  end
  resources :profiles
  resources :posts, only: [:show]
  get 'notifications', to: 'friendships#notifications'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
