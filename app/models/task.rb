class Task < ActiveRecord::Base
  attr_accessible :attachments, :ticket, :content, :quoted_time, :real_time, :task_type, :current_state, :tested_by, :done_by
  belongs_to :ticket
  belongs_to :current_state, class_name: 'TaskState', foreign_key: 'task_state'
  belongs_to :task_type
  belongs_to :tested_by, class_name: 'User', foreign_key: 'tested_by'
  belongs_to :done_by, class_name: 'User', foreign_key: 'done_by'
  has_many :attachments
  has_many :comments

  def get_current_state
    if done_by.nil?
      if tested_by.nil?
        'new'
      else
        'rejected'
      end
    elsif tested_by.nil?
      'done'
    else
      'accepted'
    end
  end
end
