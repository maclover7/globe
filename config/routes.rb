Rails.application.routes.draw do
  root to: 'pages#home'
  get 'auth' => 'pages#auth'

  resources :courses

  devise_for :users, skip: :registrations
  devise_for :students, :teachers, controllers: { registrations: "registrations" }, skip: :sessions

  ## FRONTEND API
  post '/enrollments' => 'enrollments#create'
end
