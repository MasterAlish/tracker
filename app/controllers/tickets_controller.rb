class TicketsController < ApplicationController
  include ApplicationHelper
  include TicketsHelper
  before_filter :store_location, except: [:edit, :update, :search]
  before_filter :signed_in_user
  before_filter :can_modify,   only: [:edit, :update]
  before_filter :is_admin?, only: [:destroy]

  def index
    @tickets = Ticket.all.sort_by{|t| t[:created_at]}.reverse
  end

  def search

  end

  def roadmap
    tickets = Ticket.all.sort_by{|t| t[:created_at]}.reverse
    @tickets = {}
    @invalid_tickets = []
    Ticket::STATES.each{|s| @tickets[s]=[]}
    tickets.each do |ticket|
      if ticket.state == Ticket::INVALID
        @invalid_tickets<<ticket
      else
        @tickets[ticket.state]<<ticket
      end
    end
  end

  def new
    client_id = params[:client] || Client.default.id
    client = Client.find(client_id)
    @ticket = Ticket.new(client: client)
  end

  def create
    collect_ticket_params
    @ticket = Ticket.create(client: $client, name: params[:ticket][:name], properties: $properties)
    redirect_to ticket_path(@ticket)
  end

  def update
    collect_ticket_params
    @ticket = Ticket.update(params[:id],client: $client, name: params[:ticket][:name], properties: $properties)
    redirect_to ticket_path
  end

  def edit
    @ticket = Ticket.find(params[:id])
    render 'new'
  end

  def show
    @ticket = Ticket.find(params[:id])
    make_old_new_email_items_for @ticket
    format_properties
    @attachment = Attachment.new
  end

  def add_property
    @id = params[:id]
    respond_to do |format|
      format.html {head 200}
      format.js
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    flash[:success] = "Ticket ##{@ticket.id} deleted successfully!"
    redirect_to tickets_path
  end

  def change_state
    @ticket = Ticket.find(params[:id])
    new_state_name = params[:state]
    new_state = Ticket::TRANSITIONS[@ticket.state].find{|t| t[:to]==new_state_name} || Ticket::TRANSITIONS[Ticket::ALL].find{|t| t[:to]==new_state_name}
    errors = []
    if new_state[:filters]
      new_state[:filters].each{ |filter|
        unless filter[:filter].call(@ticket)
          errors<<filter[:error_message]
          break
        end
      }
    end
    if errors.length == 0
      @ticket.state = new_state_name
      @ticket.save
    else
      flash[:error] = errors[0]
    end
    redirect_to @ticket
  end


  def collect_ticket_params
    $client = Client.find(params[:ticket_client_id])
    $properties =[]
    params[:property_name].each do |id,property_field_names|
      property = Property.new(name: params[:property_value][id]['1'].squeeze(' ').strip)
      property_field_names.each do |num,name|
        property.data[name]=params[:property_value][id][num] unless name.eql? 'name'
      end
      $properties<<property
    end unless  params[:property_name].nil?
  end

  def format_properties
    @properties=[]
    @ticket.properties.each do |property|
      @properties << {name: property.name, format: format(property.data)}
    end
  end

  def format(hash)
    format = hash['format']
    hash.each {|key,value| format.gsub! /\{#{key}\}/, value}
    format
  end

  def make_old_new_email_items_for (ticket)
    ticket.email_threads.each{|t| t.email_items.each{|i| i.new+=1; i.save }}
  end
end
