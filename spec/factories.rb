require 'factory_girl'

FactoryGirl.define do
  factory :post do
    title "example post"
    content "Bob Law Blob"
    is_published true
  end

  factory :user do
    email "hussain283@gmail.com"
    password "123"
  end
end
