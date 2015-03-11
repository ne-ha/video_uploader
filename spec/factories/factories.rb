FactoryGirl.define do 
  factory :user do 
    email "test@example.com"
    password "secretpassword"
    password_confirmation "secretpassword"
  end
end