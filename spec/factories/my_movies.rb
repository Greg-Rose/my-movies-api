FactoryBot.define do
  factory :my_movie do
    user
    movie
    watched true
    to_watch false
  end
end
