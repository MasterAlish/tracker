class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :initials, :email, :password, :password_confirmation, :remember_me
  validates :initials, presence: true, length: { is:2}

  def get_initials
    "#{initials[0]}.#{initials[1]}."
  end

  def get_avatar
    "#{(Random.new_seed%8+1)}.png"
  end
end
