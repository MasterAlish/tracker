class EmailItem < ActiveRecord::Base
  attr_accessible :content, :removed, :owner, :email_thread, :uid
  belongs_to :owner, polymorphic: true
  belongs_to :email_thread
end
