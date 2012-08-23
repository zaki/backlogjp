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
      @versions[0].due_date.class.should == DateTime
    end
  end

  context "CRUD" do
    # TODO: Separate out concerns
    it "creates, updates and deletes version" do
      # CREATE
      version = nil
      expect{ version = @project.create_version "TEST-VERSION-1"}
          .to change{ @project.versions.length }.by(1)
      version.name.should == 'TEST-VERSION-1'

      # UPDATE
      version.update 'TEST-VERSION-2'
      version.name.should == 'TEST-VERSION-2'

      # DELETE
      expect{ version.delete }
          .to change{ @project.versions.length }.by(-1)
    end
  end
end

