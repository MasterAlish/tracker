class Client < ActiveRecord::Base
  attr_accessible :name, :email
  has_many :sites

  def self.default
     Client.find_by_email(ENV['DEFAULT_CLIENT_EMAIL'])
  end
end
