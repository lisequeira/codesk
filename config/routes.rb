Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :spaces do
      resource :rates, only: [:create, :new]
      resources :bookings
      resources :listing
  end

end
