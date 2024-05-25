class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

  before_save :downcase_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    user && user.authenticate(password) ? user : nil
  end

  private

  def downcase_email
    self.email.downcase!
  end
end