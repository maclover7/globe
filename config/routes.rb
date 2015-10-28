require 'sidekiq/web'

Rails.application.routes.draw do
  ## FRONTEND ROUTES
  root to: 'pages#home'
  get 'auth' => 'pages#auth'
  get '/assignments/:assignment_id/edit' => 'assignments#edit', as: 'edit_assignment'
  put '/assignments/:assignment_id/edit' => 'assignments#update', as: 'update_assignment'
  resources :courses
  get '/dashboard' => 'dashboard#index', as: 'student_dashboard'

  ## USER AUTHENTICATION
  devise_for :users, skip: :registrations
  devise_for :students, :teachers, controllers: { registrations: "registrations" }, skip: :sessions

  ## FRONTEND API
  post '/courses/:course_id/assignments' => 'assignments#create', as: 'assignments'
  delete '/courses/:course_id/assignments/:assignment_id' => 'assignments#destroy', as: 'assignment'
  post '/enrollments' => 'enrollments#create', as: 'enrollments'
  patch "/student_assignments/:id/complete" => "student_assignments#complete", as: :complete_student_assignment

  ## QUIZ CENTER
  get '/quizcenter' => "quiz_center#index", as: :quiz_center
  get '/quizcenter/manage/:id' => "quiz_center#manage", as: :quiz_center_manage
  post '/quizcenter/manage/:id/start' => "quiz_center#change_start_status"
  get '/quizcenter/take/:id' => "quiz_center#take", as: :quiz_center_take
  post '/quizcenter/take/:id/response' => 'quiz_center#update', as: :quiz_center_response
  post '/pusher/auth' => "quiz_center#pusher_auth"

  ## SCHOOL ADMIN
  resources :invite_codes

  ## TECH ADMIN
  authenticate :user, lambda { |u| u.tech_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
