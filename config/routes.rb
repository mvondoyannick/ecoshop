Rails.application.routes.draw do
  resources :terminal_accesses
  devise_for :users
  
  # API Routes - Version 1
  scope '/api/v1' do
    get '/supermarches_all', to: 'mainapi#supermarches'
    get '/supermarches/:id/produits', to: 'mainapi#supermarche_produits'
    get '/produits_en_promotion', to: 'mainapi#produits_en_promotion'
    get '/produits_expiration_proche', to: 'mainapi#produits_expiration_proche'
    get '/recherche', to: 'mainapi#recherche'
  end
  
  resources :terminal_accesses, only: [:index, :show, :destroy] do
    member do
      patch :toggle_block
    end
    collection do
      get :stats
    end
  end

  resources :roles
  resources :societes
  resources :liste_de_prixes do
    member do
      patch :activate
    end
  end
  resources :produits
  resources :supermarches do
    collection do
      post :import
    end
    member do
      patch :suspend
      patch :reactivate
      patch :archive
    end
  end
  resources :villes
  # mount_avo
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "supermarches#index"
end
