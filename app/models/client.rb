class Client < ActiveRecord::Base
  attr_accessible :name, :email
  has_many :sites

  def self.default
     Client.find_by_email("sahne@gmail.com")#ENV['DEFAULT_CLIENT_EMAIL'])
  end
end
