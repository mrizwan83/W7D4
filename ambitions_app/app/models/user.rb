# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#
class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true 
  validates :password_digest, presence: true 
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  has_many :goals,
  class_name: :Goal,
  foreign_key: :user_id

   has_many :cheers,
  class_name: 'Cheer',
  foreign_key: giver_id

  attr_reader :password 

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return user if @user && user.is_password?(password)
    nil
  end

  def is_password?
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
