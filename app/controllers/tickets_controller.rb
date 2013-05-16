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
    client = Client.find(params[:ticket_client_id])
    properties =[]
    params[:property_name].each do |id,property_fields|
      property = Property.new(name: params[:property_value][id]['1'])
      property_fields.each do |key,field|
        property.data[field]=params[:property_value][id][key] unless field.eql? 'name'
      end
      properties<<property
    end
    @ticket = Ticket.create(client: client, name: params[:ticket][:name], properties: properties)
    render 'show'
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
