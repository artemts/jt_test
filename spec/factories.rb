FactoryGirl.define do
  factory :user do
    login "exampleuser"
    email "user@example.com"
    password "foobarbaz"
    password_confirmation "foobarbaz"
  end
end