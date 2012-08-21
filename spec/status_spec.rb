require 'spec_helper'

describe Backlogjp::Status do
  context "getStatuses" do
    it "returns the statuses" do
      statuses = Backlogjp::Status.all

      statuses.map(&:name).should include("Resolved")
    end
  end
end

