require 'spec_helper'

describe EmailThread do
  let(:email_thread) {EmailThread.new}

  describe 'integration' do
    subject {email_thread}
    it {should respond_to 'email'}
    it {should respond_to 'title'}
    it {should respond_to 'tags'}
    it {should respond_to 'removed'}
    it {should respond_to 'removed?'}
    it {should respond_to 'email_items'}
    it {should_not respond_to 'properties'}
  end
end
