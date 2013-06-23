require 'spec_helper'

describe Ticket do
  let(:ticket) {Ticket.new}

  describe 'delegation' do
    subject {ticket}
    it {should respond_to 'site'}
    it {should respond_to 'client'}
    it {should respond_to 'name'}
    it {should respond_to 'tasks'}
    it {should respond_to 'attachments'}
    it {should respond_to 'email_threads'}
    it {should respond_to 'properties'}
    it {should respond_to 'state'}
  end

  describe 'Attachments' do
    it 'are consist of tasks attachments' do
      task = ticket.tasks.new
      attachment = task.attachments.new
      ticket.save
      ticket.attachments.should eq([attachment])
    end
  end
end
