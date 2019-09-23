Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

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
    resources :books, only: [:index, :update], controller: 'users/books' do
      collection do
        get :wish
        get :stacked
        get :reading
        get :read
      end
    end
    resources :reviews, only: [:index], controller: 'users/reviews'
    resources :monthlies, only: [:show, :index], param: :year, controller: 'users/monthlies'
  end

  namespace :users do
    resources :books, only: [:new, :create, :edit, :destroy]
  end

  resources :authors, only: [:show, :index]

  resources :rankings, only: [:index] do
    collection do
      get :books
      get :users
      get :authors
    end
  end
end
