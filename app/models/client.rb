class Client < ActiveRecord::Base
  attr_accessible :name
  serialize :emails, class_name: String
  has_many :sites
end
