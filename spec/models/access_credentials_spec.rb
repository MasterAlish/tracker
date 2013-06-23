require 'spec_helper'

describe AccessCredentials do
  let(:access_credentials) { AccessCredentials.new }

  describe "delegation" do
    it {should respond_to 'properties'}
    it {should respond_to 'find_property'}
    it {should respond_to 'ssh'}
    it {should respond_to 'ftp'}
    it {should respond_to 'cpanel'}
    it {should respond_to 'admin'}
  end
end
