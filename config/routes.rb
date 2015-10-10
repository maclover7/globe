Rails.application.routes.draw do
  root to: 'pages#home'
  get 'auth' => 'pages#auth'

  get '/assignments/:assignment_id/edit' => 'assignments#edit', as: 'edit_assignment'
  put '/assignments/:assignment_id/edit' => 'assignments#update', as: 'update_assignment'
  resources :courses
  get '/dashboard' => 'dashboard#index', as: 'student_dashboard'

  devise_for :users, skip: :registrations
  devise_for :students, :teachers, controllers: { registrations: "registrations" }, skip: :sessions

  ## FRONTEND API
  post '/courses/:course_id/assignments' => 'assignments#create', as: 'assignments'
  delete '/courses/:course_id/assignment/:assignment_id' => 'assignments#destroy', as: 'assignment'
  post '/enrollments' => 'enrollments#create', as: 'enrollments'
  patch "/student_assignments/:id/complete" => "student_assignments#complete", as: :complete_student_assignment

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
