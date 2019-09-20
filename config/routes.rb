Rails.application.routes.draw do
  namespace :users do
    get 'reviews/index'
  end
  get 'authors/show'
  get 'authors/index'
  get 'author/show'
  get 'author/index'
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

  resources :books do
    collection do
      get :search
    end
  end
  resources :users, only: [:show, :edit, :index, :update, :destroy] do
    resources :books, only: [:index, :update], controller: 'users/books'
    resources :reviews, only: [:index], controller: 'users/reviews'
    resources :monthlies, only: [:show, :index], param: :year, controller: 'users/monthlies'
  end

  namespace :users do
    resources :books, only: [:new, :create, :edit, :destroy]
  end

  resources :authors, only: [:show, :index]

end
