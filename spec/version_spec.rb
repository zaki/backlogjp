require 'spec_helper'

describe Backlogjp::Version do
  before(:all) do
    @project = Backlogjp::Project.find_by_key "TEST"
    @versions = @project.versions
  end
  describe "#versions" do
    it "returns the versions for the project" do
      @versions.should have(1).version
    end

    it "returns the proper versions" do
      @versions[0].name.should == "TEST-VERSION"
    end

    it "has proper datetime as due date" do
      @versions[0].date.class.should == DateTime
    end
  end
end

