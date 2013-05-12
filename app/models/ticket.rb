class Ticket < ActiveRecord::Base
  attr_accessible :site, :client, :name, :tasks, :attachments, :email_threads, :properties
  belongs_to :client
  has_many :tasks
  has_many :attachments, through: :tasks
  has_many :email_threads
  has_many :properties, as: :owner
end
