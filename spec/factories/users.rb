FactoryBot.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password 'foobar'
  end
end
