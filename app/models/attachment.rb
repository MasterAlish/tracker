class Attachment < ActiveRecord::Base
  attr_accessible :name, :task, :type, :url
  belongs_to :task
end
