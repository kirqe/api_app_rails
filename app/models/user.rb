class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true


  before_create :generate_authenticaion_token!
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy


  def generate_authenticaion_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

end
