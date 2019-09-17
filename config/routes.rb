Rails.application.routes.draw do
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
    resources :monthlies, only: [:show, :index], param: :year, controller: 'users/monthlies'
  end
end
