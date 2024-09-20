Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :conflicts, except: [:index, ] do
    resources :issue, except: [:index, :show]
  end

  resources :negotiations, except: [:index] do 
    
  end

end
