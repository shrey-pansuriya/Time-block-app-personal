# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      email { "user@example.com" }
      password { "securepassword" }  # Assuming your User model has a password
      # Add any other required or optional fields based on your User model
    end
  end
  
  