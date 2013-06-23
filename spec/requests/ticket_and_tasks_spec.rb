require 'spec_helper'

describe "TicketAndTasks" do
  describe "GET /" do
    it "works! (now write some real specs)", :js => true do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tickets_path
      response.status.should be(302)
    end
  end
end
