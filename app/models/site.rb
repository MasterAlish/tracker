class Site < ActiveRecord::Base
  attr_accessible :url
  belongs_to :client
  has_many :access_credentials
end
