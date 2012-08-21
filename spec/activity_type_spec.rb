require 'spec_helper'

describe Backlogjp::ActivityType do
  context "getActivityTypes" do
    it "returns the activity types" do
      activity_types = Backlogjp::ActivityType.all

      activity_types.map(&:name).should include("Comment")
    end
  end
end

