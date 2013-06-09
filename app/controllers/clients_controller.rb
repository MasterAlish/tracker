class ClientsController < ApplicationController
  def show
    @client = Client.find(params[:id])
    @tickets = Ticket.find_all_by_client_id @client.id
  end

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new()
  end

  def create
    @client = Client.create(params[:client])
    if @client.valid?
      redirect_to client_path @client
    else
      render 'new'
    end
  end

  def destroy
    Client.delete(params[:id])
    redirect_to clients_path
  end
end
