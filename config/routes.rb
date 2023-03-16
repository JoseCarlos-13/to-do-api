# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks, only: %i[index create show destroy]
  resources :users do
    put 'cancel_account', on: :member, to: 'users#cancel_account'
  end
end
