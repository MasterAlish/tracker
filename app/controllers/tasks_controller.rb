class TasksController < ApplicationController
  def new
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

  def create
    ticket = Ticket.find(params[:ticket])
    task = ticket.tasks.create()
    task.comments.create(content: params[:text], user: current_user)
    task.save()
    render inline: "{'success':true}"
  end
end
