class User < ApplicationRecord
  has_secure_password

  has_many :my_movies, dependent: :destroy
  has_many :movies, through: :my_movies

  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates :email, uniqueness: { case_sensitive: false }
end
