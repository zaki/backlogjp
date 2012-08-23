require 'spec_helper'

describe Backlogjp::IssueType do
  before(:all) do
    @project = Backlogjp::Project.find_by_key "TEST"
    @issue_types = @project.issue_types
  end

  describe "#issue_types" do
    it "returns the issue types for the project" do
      @project.users.should have(1).issue_types
    end

    it "returns the proper issue types" do
      @project.issue_types.map(&:name).should include("Bug")
    end
  end

  context "CRUD" do
    # TODO: Separate out concerns
    it "creates, updates and deletes issue type" do
      # CREATE
      issue_type = nil
      expect{ issue_type = @project.create_issue_type 'CRITICAL BUG', :red }
           .to change{ @project.issue_types.length }.by(1)
      issue_type.name.should == 'CRITICAL BUG'
      issue_type.color.should == '#e30000'

      # UPDATE
      issue_type.update 'FATAL BUG', :red
      issue_type.name.should == 'FATAL BUG'

      # DELETE
      expect{ issue_type.delete }.to change{ @project.issue_types.length }.by(-1)
    end
  end
end

