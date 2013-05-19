class TasksController < ApplicationController
  def new
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end
end
