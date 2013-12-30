Rails.application.routes.draw do
  root to: 'pages#index'

  resources :documents, except: [:index, :destroy]
end
