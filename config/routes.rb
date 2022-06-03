# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, except: :index do
      member { patch :set_best }
    end
  end

  root 'questions#index'
end
