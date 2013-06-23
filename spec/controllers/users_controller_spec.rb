require 'spec_helper'

describe UsersController do
  let(:user) { create_user }
  let(:admin) { create_admin }

  before do
   sign_in user
  end

  describe "#show" do
    it "should generally work" do
      get :show, id: user.id
      expect(response).to be_success
    end
  end

  describe "#index" do
    it "should redirect for not admin user" do
      get :index
      response.status.should be(302)
    end

    it "should work for admin" do
      sign_out user
      sign_in admin
      get :index
      response.should be_success
    end
  end

end
