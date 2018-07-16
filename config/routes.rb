Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  # TODO: Add subdomain constraint for production
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      scope ':store', store: /#{Payment.stores.keys.join('|')}/  do
        resources :payments, only: [:create]
      end
    end
  end
end
