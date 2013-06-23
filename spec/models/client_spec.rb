require 'spec_helper'

describe Client do
  let(:client) { Client.new }

  describe "delegation" do
    subject { client }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:sites) }
    it { should respond_to(:get_avatar) }
  end

  describe "Name" do
    it "can't be nil" do
      client.name = nil
      client.valid?
      client.errors['name'].should be
    end
  end

  describe "Email" do
    it "can't be nil" do
      client.email = nil
      client.valid?
      client.errors['email'].should be
    end
  end

  it "should be saved with email and name" do
    client.email = 'email@email.com'
    client.name = 'Client'
    client.valid?.should be
  end

  it "should have valid default instance" do
    Client.default.valid?.should be
  end
end
