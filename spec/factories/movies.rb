FactoryBot.define do
  factory :movie do
    title 'Movie Title'
    sequence(:tmdb_id) { |n| n }
    release_date DateTime.now
    runtime 120
    poster_path '/path'
  end
end
