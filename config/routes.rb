Rails.application.routes.draw do
  root to: 'pages#home'
  get 'auth' => 'pages#auth'

  devise_for :users, skip: :registrations
  devise_for :students, :teachers, controllers: { registrations: "registrations" }, skip: :sessions
end
