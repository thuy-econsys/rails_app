Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # devise_for :users, :controllers => { registrations: 'registrations' }

  root to: "pages#home"
end
