class MyMovie < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_inclusion_of :watched, :to_watch, in: [true, false]
end
