class EmailItem < ActiveRecord::Base
  attr_accessible :content, :removed, :owner, :email_thread, :uid, :prepared, :created_at, :new
  belongs_to :owner, polymorphic: true
  belongs_to :email_thread

  def removed?
    removed
  end

  def prepared?
    prepared
  end
end
