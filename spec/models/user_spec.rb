require 'spec_helper'

describe User do
  let(:user) { User.new }

  describe "delegation" do
    subject { user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:initials) }
    it { should respond_to(:password) }
    it { should respond_to(:get_initials) }
    it { should respond_to(:get_avatar) }
  end

  describe "Name" do
    subject { user }
    it "can't be null" do
      user.name = nil
      user.save
      user.errors['name'].should be
    end
  end

  describe "Email" do
    subject { user }
    it "can't be null" do
      user.email = nil
      user.save
      user.errors['email'].should be
    end
  end

  it "should be saved with name, email, password and initials" do
    user.name = 'User'
    user.email = 'Email@email.com'
    user.initials = 'AA'
    user.password = 'asdasdasdasdasd'
    user.save
    user.valid?.should be
  end

  describe "Initials" do
    subject { user }
    it "can't be null" do
      user.initials = nil
      user.save
      user.errors['initials'].should be
    end

    it "can't contain 3 letters" do
      user.initials = "AAA"
      user.valid?
      user.errors['initials'].should be
    end

    it "can't contain only 1 letter" do
      user.initials = "A"
      user.valid?
      user.errors['initials'].should be
    end

    it "can contain exact 2 letter" do
      user.initials = "AA"
      user.valid?
      user.errors['initials'].length.should be(0)
    end

    it "must be returned with dots by get_initials() " do
      user.initials = 'AA'
      initials = user.get_initials()
      initials.should eq('A.A.')
    end
  end
end
