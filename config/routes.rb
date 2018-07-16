# frozen_string_literal: true

require_relative '../lib/subdomain_constraint'

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  # TODO: Add subdomain constraint for production
  namespace :api, path: '/', constraints: SubdomainConstraint.new('api') do
    namespace :v1 do
      resource :version, only: [:show]
      resources :users, only: [:create]
      scope ':store', store: /#{Payment.stores.keys.join('|')}/  do
        resources :payments, only: [:create]
      end
    end
  end
end
