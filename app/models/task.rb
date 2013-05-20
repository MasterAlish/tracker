class Task < ActiveRecord::Base
  attr_accessible :attachments, :ticket, :content, :quoted_time, :real_time, :task_type, :current_state, :quoted_by, :done_by
  belongs_to :ticket
  belongs_to :current_state, class_name: 'TaskState', foreign_key: 'task_state'
  belongs_to :task_type
  belongs_to :quoted_by, class_name: 'User', foreign_key: 'quoted_by'
  belongs_to :done_by, class_name: 'User', foreign_key: 'done_by'
  has_many :attachments
  has_many :comments
end
