require 'spec_helper'

describe Attachment do
  let(:attachment) { Attachment.new }

  describe "delegation" do
    subject {attachment}
    it {should respond_to 'task'}
    it {should respond_to 'name'}
    it {should respond_to 'type'}
    it {should respond_to 'url'}
  end
end
