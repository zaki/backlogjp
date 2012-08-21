require 'spec_helper'

describe Backlogjp::Project do
  context "getProjects" do
    it "retrieves all projects" do
      projects = Backlogjp::Project.all

      projects.should have(1).project
    end

    it "returns the proper projects" do
      projects = Backlogjp::Project.all

      projects.first.key.should == "TEST"
    end
  end

  context "getProject id" do
    it "returns the proper project" do
      project = Backlogjp::Project.find_by_id 1073773955

      project.key.should == "TEST"
    end

    it "returns nil if project is not found" do
      project = Backlogjp::Project.find_by_id 1

      project.should be_nil
    end
  end

  context "getProject key" do
    it "returns the proper project" do
      project = Backlogjp::Project.find_by_key "TEST"

      project.id.should == 1073773955
    end

    it "returns nil if project is not found" do
      project = Backlogjp::Project.find_by_key "NONEXISTENT"

      project.should be_nil
    end
  end
end

