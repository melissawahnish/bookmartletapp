# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider "MyString"
    uid "MyString"
    token "MyString"
    secret "MyString"
    user_id 1
  end
end
