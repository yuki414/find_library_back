Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/auth/registrations'
    }
  end
  namespace :api, format: 'json' do
    get '/book_search' => 'books#search'
    resources :books, only: [:index, :search, :show]
    get '/user_additions_search' => 'user_additions#search'
    resources :user_additions, only: [:show, :create, :update, :search]
    resources :libraries, only: [:show, :create]
    delete '/library_relationships' => 'library_relationships#destroy'
    resources :library_relationships, only: [:create, :destroy]
  end
end