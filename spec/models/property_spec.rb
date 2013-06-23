require 'spec_helper'

describe Property do
  let(:property) { Property.new }

  describe 'delegation' do
    subject {property}
    it {should respond_to (:name)}
    it {should respond_to (:data)}
    it {should respond_to (:owner)}
  end

  it "can have owner of type Ticket" do
    ticket = Ticket.new()
    property.owner = ticket
    property.valid?.should be
  end
end
