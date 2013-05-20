class Comment < ActiveRecord::Base
  attr_accessible :content, :task, :user
  belongs_to :user
  belongs_to :task
end
