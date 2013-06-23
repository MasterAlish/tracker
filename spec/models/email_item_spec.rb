require 'spec_helper'

describe EmailItem do
  let(:email_item) {EmailItem.new}

  describe 'integration' do
    #  attr_accessible :content, :removed, :owner, :email_thread, :uid, :prepared, :created_at, :new
    subject {email_item}
    it {should respond_to 'content'}
    it {should respond_to 'removed'}
    it {should respond_to 'removed?'}
    it {should respond_to 'owner'}
    it {should respond_to 'email_thread'}
    it {should respond_to 'prepared'}
    it {should respond_to 'prepared?'}
    it {should respond_to 'created_at'}
    it {should respond_to 'new'}
    it {should respond_to 'uid'}
  end

  describe 'uid' do
    it 'must be nil for new items' do
      email_item.uid.should be_nil
    end
  end
end
