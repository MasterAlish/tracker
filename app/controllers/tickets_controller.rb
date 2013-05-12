class TicketsController < ApplicationController
  include ApplicationHelper
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :new]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :is_admin?, only: [:destroy]

  def index
    @tickets = Ticket.all.sort_by{|t| t[:created_at]}.reverse
  end

  def new
    @ticket = Ticket.new(client: Client.default)
  end

  def create
    abort(YAML::dump(params))
    client = Client.find(params[:ticket_client_id])
    @ticket = Ticket.create(client: client, name: params[:ticket][:name])
    render 'show'
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def add_property
    @id = params[:id]
    respond_to do |format|
      format.html {head 200}
      format.js
    end
  end
end
