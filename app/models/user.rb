class User < ApplicationRecord
  has_secure_password

  has_many :my_movies, dependent: :destroy
  has_many :movies, through: :my_movies do
    def watched
      where("my_movies.watched = ?", true)
    end

    def to_watch
      where("my_movies.to_watch = ?", true)
    end
  end

  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates :email, uniqueness: { case_sensitive: false }

  def get_account_info
    account_info = { first_name: self.first_name, last_name: self.last_name, email: self.email }
  end
end
