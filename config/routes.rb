Rails.application.routes.draw do
  root to: 'pages#home'
  get 'auth' => 'pages#auth'

  resources :courses

  devise_for :users, skip: :registrations
  devise_for :students, :teachers, controllers: { registrations: "registrations" }, skip: :sessions

  ## FRONTEND API
  post '/courses/:course_id/assignments' => 'assignments#create', as: 'assignments'
  post '/enrollments' => 'enrollments#create', as: 'enrollments'
end
