require 'spec_helper'

describe Backlogjp::Priority do
  context "getPriorities" do
    it "returns the priorities" do
      priorities = Backlogjp::Priority.all

      priorities.map(&:name).should include("High")
    end
  end
end

