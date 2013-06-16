class EmailThread < ActiveRecord::Base
  attr_accessible :email, :title, :tags, :removed, :email_items
  serialize :tags, Array
  belongs_to :ticket
  has_many :email_items, :dependent => :destroy
end
