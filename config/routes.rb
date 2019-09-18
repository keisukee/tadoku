Rails.application.routes.draw do
  namespace :users do
    get 'books/index'
    get 'books/new'
    get 'books/create'
    get 'books/edit'
    get 'books/update'
    get 'books/destroy'
  end
  root to: "home#index"
  devise_for :users, controllers: {
     sessions: 'users/sessions',
     registrations: 'users/registrations',
     passwords: 'users/passwords',
     confirmations: 'users/confirmations'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'books/search', to: 'books#search'
  resources :books
  resources :users, only: [:show, :edit, :index, :update, :destroy] do
    resources :books, only: [:index, :new, :create, :edit, :update, :destroy], controller: 'users/books'
    resources :monthlies, only: [:show, :index], param: :year, controller: 'users/monthlies'
  end
end
