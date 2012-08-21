require 'spec_helper'

describe Backlogjp::User do
  before(:all) do
    @project = Backlogjp::Project.find_by_key "TEST"
    @users = @project.users
  end

  describe "#users" do
    it "returns the users for the project" do
      @users.should have(1).user
    end

    it "returns the proper user" do
      @users[0].name.should == "ruby-api"
    end
  end

  context "getUser" do
    it "returns the user" do
      user = Backlogjp::User.find_by_id "ruby-api"

      user.name.should == "ruby-api"
    end

    it "returns nil if no user is found" do
      user = Backlogjp::User.find_by_id "invalid-user"

      user.should be_nil
    end
  end
end

