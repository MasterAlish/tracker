require 'spec_helper'

describe TicketsController do
  let(:ticket) {Ticket.new}

  describe 'format method' do
    it 'should return correct format' do
      format = TicketsController::format({:name=>'ftp', :format=> '{host}:{port}', :host=>'123.0.0.0', :port=>'3000'})
      format.should eq ("123.0.0.0:3000")
    end
  end

end
