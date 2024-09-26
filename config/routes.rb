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
  end

  resources :negotiations, except: [:index] do 

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
