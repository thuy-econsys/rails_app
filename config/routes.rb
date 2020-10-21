Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get '/users', to: 'pages#index', as: :dashboard

  root to: "pages#home"
end
