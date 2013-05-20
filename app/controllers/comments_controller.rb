class CommentsController < ApplicationController

  def create
    task = Task.find(params[:task])
    task.comments.create(content: params[:text], user: current_user)
    task.save()
    render inline:"'success:true'"
  end
end
