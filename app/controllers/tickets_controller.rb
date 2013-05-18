class TicketsController < ApplicationController
  include ApplicationHelper
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :new, :show]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :is_admin?, only: [:destroy]

  def index
    @tickets = Ticket.all.sort_by{|t| t[:created_at]}.reverse
  end

  def new
    @ticket = Ticket.new(client: Client.default)
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
    format_properties
  end

  def add_property
    @id = params[:id]
    respond_to do |format|
      format.html {head 200}
      format.js
    end
  end

  private

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
end
