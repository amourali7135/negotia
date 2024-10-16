Rails.application.routes.draw do
  mount RailsAdmin::Engine => 'fuckyouhackerz', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  
  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: "pghero"
  end
  
  mount Debugbar::Engine => Debugbar.config.prefix

  resources :conflicts, except: [:index] do
    resources :issues, except: [:index, :show]
    resources :practice_sessions, shallow: true do
      resources :issue_analyses, only: [:show, :new, :create, :edit, :update]
      resource :practice_session_outcome, only: [:new, :create, :show]
    end
    resources :negotiations, shallow: true
  end

  resources :negotiations, except: [:index] do 
    resources :proposals, only: [:new, :create, :show] do
      resources :proposal_responses, only: [:create]
    end
    resources :messages, only: [:create]
    resources :issues, only: [:index, :show]
  end

  resources :proposals, only: [] do
    resources :proposal_responses, only: [:create]
  end

  # User profile and dashboard routes
  get 'profile', to: 'users#show'
  get 'dashboard', to: 'dashboard#index'

  # API routes if needed
  # namespace :api do
  #   namespace :v1 do
  #     resources :conflicts, only: [:show, :create, :update]
  #     resources :negotiations, only: [:show, :create, :update]
  #   end
  # end


  # resources :negotiations do
  #   member do
  #     get :respond
  #     patch :accept
  #     patch :decline
  #   end
  #   resources :messages, only: [:create]
  #   resources :proposals, only: [:new, :create] do
  #     resources :proposal_responses, only: [:create]
  #   end
  #   resources :negotiation_issues, only: [:index, :create, :destroy]
  # end

end
