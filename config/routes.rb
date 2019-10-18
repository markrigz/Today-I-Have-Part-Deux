# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  devise_for :users

  root 'posts#index'

  # add this line to link tags to posts with the respective tag
  get 'tags/:tag', to: 'posts#index', as: :tag

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
