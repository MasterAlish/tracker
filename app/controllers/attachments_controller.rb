class AttachmentsController < ApplicationController
  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new
    @attachment.url = params[:attachment][:url]
    @attachment.save!
    redirect_to @attachment
  end

  def show
    @attachment = Attachment.find(params[:id])
  end
end
