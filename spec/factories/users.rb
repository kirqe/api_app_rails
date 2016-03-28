FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "qqqqqqqq"
    password_confirmation "qqqqqqqq"
  end
end
