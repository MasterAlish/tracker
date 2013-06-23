require 'spec_helper'

describe Site do
  let(:site) { Site.new }

  describe "delegation" do
    subject { site }

    it { should respond_to(:url) }
    it { should respond_to(:client) }
    it { should respond_to(:access_credentials) }
  end
end
