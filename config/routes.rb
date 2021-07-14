Rails.application.routes.draw do
  devise_for :users, 
  path: 'account',
  controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get     '/users',           to: 'pages#index',    as: :dashboard
  get     '/users/:id/edit',  to: 'pages#edit',     as: :edit_user
  patch   '/users/:id',       to: 'pages#update',   as: :user
  delete  '/users/:id',       to: 'pages#destroy'

  root to: "pages#home"
end
