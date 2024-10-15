Rails.application.routes.draw do
  mount RailsAdmin::Engine => 'fuckyouhackerz', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  
  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: "pghero"
  end
  
  mount Debugbar::Engine => Debugbar.config.prefix


  resources :conflicts, except: [:index, ] do
    resources :issue, except: [:index, :show]
    resources :practice_sessions, shallow: true do
      resource :issue_analysis, only: [:show, :new, :create, :edit, :update] #       resources :practice_issues, only: [:show, :update]
      resource :session_outcome, only: [:new, :create]
    end
  end

  resources :negotiations, except: [:index] do 
    resources :proposals, only: [:new, :create, :show] do
      resources :proposal_responses, only: [:create]
    end
    resources :messages, only: [:create]
  end


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
