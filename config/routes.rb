Rails.application.routes.draw do
  root to: 'pages#index'

  get 'auth/google_oauth2/callback' => 'sessions#create'

  resources :documents, except: [:index]

  resources :search, only: :index
end
