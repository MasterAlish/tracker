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
      when 'task_done'
        task_done(params[:id])
      when 'test_accept'
        test_accept(params[:id])
      when 'test_reject'
        test_reject(params[:id])
      else
    end
  end

  private

    def change_quote(task_id, quote)
      task = Task.find(task_id)
      task.quoted_time=quote
      task.save
      render :inline => "{'success':true}"
    end

    def task_done(task_id)
      task = Task.find(task_id)
      task.done_by = current_user
      task.quoted_by = nil
      task.save
      redirect_to task.ticket
    end

    def test_accept(task_id)
      task = Task.find(task_id)
      task.quoted_by = current_user
      task.save
      redirect_to task.ticket
    end

    def test_reject(task_id)
      task = Task.find(task_id)
      task.quoted_by = current_user
      task.done_by = nil
      task.save
      redirect_to task.ticket
    end
end
