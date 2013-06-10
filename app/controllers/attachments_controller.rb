class AttachmentsController < ApplicationController
  def new
    @attachment = Attachment.new
  end

  def create
    if params[:task]
      task = Task.find(params[:task])
      @attachment = task.attachments.create
      @attachment.url = params[:attachment][:url]
      @attachment.save!
      comment = task.comments.create
      comment.content = "'''Attached file''' [#{@attachment.url.url} #{get_file_name @attachment.url.current_path}]"
      comment.user = current_user
      comment.save
      redirect_to ticket_path(task.ticket)
    else
      redirect_to tickets_path
    end
  end

  def index
    @attachments = Attachment.all
  end

  def show
    @attachment = Attachment.find(params[:id])
  end

  private
    def get_file_name(path)
      path[/\/([^\/]+)$/][1..-1]
    end
end
