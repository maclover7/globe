FactoryGirl.define do
  factory :student, traits: [:user]
  factory :teacher, traits: [:user]
  factory :user, traits: [:user]

  trait :user do
    email { Faker::Internet.email }
    password "test1234"
    password_confirmation "test1234"
  end
end
