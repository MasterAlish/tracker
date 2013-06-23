require 'spec_helper'

describe Task do
  let(:task) {Task.new}

  describe 'delegation' do
    subject {task }
    it {should respond_to 'attachments'}
    it {should respond_to 'comments'}
    it {should respond_to 'ticket'}
    it {should respond_to 'quoted_time'}
    it {should respond_to 'real_time'}
    it {should respond_to 'task_type'}
    it {should respond_to 'current_state'}
    it {should respond_to 'tested_by'}
    it {should respond_to 'done_by'}
    it {should respond_to 'get_current_state'}
  end

  describe 'Current state' do
    subject{task}
    it "should have 'new' state when tested_by and done_by are nil" do
      task.tested_by = nil
      task.done_by = nil
      task.get_current_state.should eq('new')
    end

    it "should have 'done' state when tested_by is nil and done_by is not" do
      user = User.new
      task.tested_by = nil
      task.done_by = user
      task.get_current_state.should eq('done')
    end

    it "should have 'accepted' state when tested_by and done_by are not nil" do
      user = User.new
      task.tested_by = user
      task.done_by = user
      task.get_current_state.should eq('accepted')
    end

    it "should have 'rejected' state when tested_by is not nil and done_by is nil" do
      user = User.new
      task.tested_by = user
      task.done_by = nil
      task.get_current_state.should eq('rejected')
    end
  end
end
