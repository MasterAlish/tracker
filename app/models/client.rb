class Client < ActiveRecord::Base
  attr_accessible :name, :email, :sites
  has_many :sites
  validates :name, presence: true
  validates :email, presence: true

  def self.default
     Client.find_by_email(ENV['DEFAULT_CLIENT_EMAIL'])
  end

  def get_avatar
    "client.png"
  end
end
