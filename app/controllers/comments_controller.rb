class CommentsController < ApplicationController

  def create
    task = Task.find(params[:task])
    task.comments.create(content: params[:text], user: current_user)
    task.save()
    render inline:"'success:true'"
    end

  def update
    comment = Comment.find(params[:comment])
    comment.content=params[:text]
    comment.save()
    render inline:"'success:true'"
  end
end
