class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :generate_authentication_token

  private

  def generate_authentication_token
    authentication_token = SecureRandom.hex(32)
    if User.find_by(authentication_token: authentication_token) != nil
      generate_authentication_token
    else
      self.authentication_token ||= authentication_token
    end
  end
end
