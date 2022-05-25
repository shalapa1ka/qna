Rails.application.routes.draw do
  resources :questions
  resources :answers

  root 'questions#index'
end
