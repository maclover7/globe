FactoryGirl.define do
  factory :assignment do
    category "Quiz"
    course_id 1
    description { Faker::Lorem.paragraph }
    due_date "10/30/2015"
    name { Faker::Name.name }
  end

  factory :course do
    description { Faker::Lorem.paragraph }
    name { Faker::Name.name }
    teacher_id 1
  end

  factory :enrollment do
    course_id 1
    student_id 1
  end

  factory :invite_code do
    code "MyString"
  end

  factory :student, traits: [:user]
  factory :teacher, traits: [:user]
  factory :user, traits: [:user]

  factory :student_assignment do
    assignment_id 1
    student_id 1
  end

  trait :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password "test1234"
    password_confirmation "test1234"
  end
end
