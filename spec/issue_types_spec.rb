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
end

