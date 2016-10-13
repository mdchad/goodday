Rails.application.routes.draw do
  get 'volunteer/failure' => 'volunteer#failure'
  get 'how/index'

  root 'main#index'

  get 'beneficiaries/index'

  # FACEBOOK AUTHENTICATION
  get 'auth/logout' => 'auth#logout'
  get 'auth/failure' => 'auth#failure'
  get 'auth/:provider/callback' => 'auth#callback'
  # get 'auth/:provider/callback', to: 'sessions#create'
  # AUTHENTICATION
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  # Users - custom routes for users, registration, profile, editing etc
  get "register" => "users#new"
  post "register" => "users#create"
  get "profile" => "users#show"
  get "profile/edit" => "users#edit"
  put "profile" => "users#update"
  patch "profile" => "users#update"
  resources :users, only: [:index, :destroy] do
    patch 'admin' => "users#toggle_admin", on: :member
  end

  # RESOURCES
  resources :goals, except: [:destroy, :update, :edit]
  resources :goals, only: [:destroy, :update, :edit] do
    patch 'admin' => "users#toggle_admin", on: :member
  end
  resources :goals do
    member do
      put "like", to: "goals#upvote"
      put "dislike", to: "goals#downvote"
    end
  end

  resources :pledges, except: [:destroy, :update, :edit]
  resources :campaigns do
    patch 'admin' => "users#toggle_admin", on: :member
  end
  resources :donations, except: [:destroy, :update, :edit]
  resources :volunteers, except: [:destroy, :update, :edit]
  resources :comments

end
