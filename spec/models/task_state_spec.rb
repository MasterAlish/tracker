require 'spec_helper'

describe TaskState do
  let(:task_state) {TaskState.new}

  describe 'integration' do
    subject {task_state}
    it {should respond_to 'name'}
  end
end
