require 'spec_helper'

describe TaskType do
  let(:task_type) {TaskType.new}

  describe 'integration' do
    subject {task_type}
    it {should respond_to 'name'}
    it {should respond_to 'image'}
  end
end
