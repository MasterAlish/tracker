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

  def helper
    function = params[:function]
    case function
      when 'change_quote'
        change_quote(params[:task], params[:quote])
      else
    end
    render :inline => "{'success':true}"
  end

  private

    def change_quote(task_id, quote)
      task = Task.find(task_id)
      task.quoted_time=quote
      task.save
    end
end
