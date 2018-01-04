class MyMovie < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_presence_of :watched, :to_watch
end
