# frozen_string_literal: true

require_relative '../lib/subdomain_constraint'

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  concern :can_start do
    post :start, on: :member
  end

  # TODO: Add subdomain constraint for production
  namespace :api, path: '/', defaults: { format: :json }, constraints: SubdomainConstraint.new('api') do
    namespace :v1 do
      resource :version, only: [:show]

      resources :users, only: [:create]

      namespace :missions do
        post :next
        post :cancel
      end

      scope ':store', store: /#{Payment.stores.keys.join('|')}/  do
        resources :payments, only: [:create]
      end

      resources :chapters, only: [:index] do
        resources :stories, only: [:index], concerns: :can_start
      end
    end
  end
end
