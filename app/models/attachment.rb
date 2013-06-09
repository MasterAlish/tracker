class Attachment < ActiveRecord::Base
  attr_accessible :name, :task, :type, :url
  mount_uploader :url, AttachmentUploader

  belongs_to :task
end
