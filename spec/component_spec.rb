require 'spec_helper'

describe Backlogjp::Component do
  before(:all) do
    @project = Backlogjp::Project.find_by_key "TEST"
    @components = @project.components
  end

  describe "#components" do
    it "returns the components for the project" do
      @components.should have(1).component
    end

    it "returns the proper component" do
      @components[0].name.should == "TEST-CATEGORY"
    end
  end
end

