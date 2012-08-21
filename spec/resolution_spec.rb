require 'spec_helper'

describe Backlogjp::Resolution do
  context "getResolutions" do
    it "returns the resolutions" do
      resolutions = Backlogjp::Resolution.all

      resolutions.map(&:name).should include("Fixed")
    end
  end
end

