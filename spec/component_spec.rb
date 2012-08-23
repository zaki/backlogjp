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

  context "CRUD" do
    # TODO: Separate out concerns
    it "creates, updates and deletes component" do
      # CREATE
      component = nil
      expect{ component = @project.create_component "TEST-COMPONENT-1"}
          .to change{ @project.components.length }.by(1)
      component.name.should == 'TEST-COMPONENT-1'

      # UPDATE
      component.update 'TEST-COMPONENT-2'
      component.name.should == 'TEST-COMPONENT-2'

      # DELETE
      expect{ component.delete }
          .to change{ @project.components.length }.by(-1)
    end
  end
end

