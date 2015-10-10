FactoryGirl.define do
  factory :course do
    description "MyText"
    name "MyString"
    teacher_id 1
  end

  factory :student, traits: [:user]
  factory :teacher, traits: [:user]
  factory :user, traits: [:user]

  trait :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password "test1234"
    password_confirmation "test1234"
  end
end
