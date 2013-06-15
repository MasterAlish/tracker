class EmailThread < ActiveRecord::Base
  attr_accessible :email, :title, :tags, :removed, :email_items
  serialize :tags, Array
  has_many :email_items
end
