Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_for :students, :teachers, controllers: { registrations: "registrations" }, skip: :sessions
end
