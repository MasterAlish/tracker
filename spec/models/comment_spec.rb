require 'spec_helper'

describe Comment do
  let(:comment) {Comment.new}

  describe 'delegation' do
    subject {comment}
    it{ should respond_to 'content'}
    it{ should respond_to 'task'}
    it{ should respond_to 'user'}
  end
end
