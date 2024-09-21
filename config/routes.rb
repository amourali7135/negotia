Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  
  mount Debugbar::Engine => Debugbar.config.prefix


  resources :conflicts, except: [:index, ] do
    resources :issue, except: [:index, :show]
  end

  resources :negotiations, except: [:index] do 

  end

end
