require 'spec_helper'

describe Backlogjp::Issue do
  context "getIssue id" do
    it "returns the proper issue" do
      issue = Backlogjp::Issue.find_by_id 1074800759

      issue.key.should == "TEST-1"
    end

    it "returns nil if project is not found" do
      issue = Backlogjp::Issue.find_by_id 1

      issue.should be_nil
    end
  end

  context "getIssue key" do
    it "returns the proper issue" do
      issue = Backlogjp::Issue.find_by_key "TEST-1"

      issue.id.should == 1074800759
    end

    it "raises if key is in invalid format" do
      expect {Backlogjp::Issue.find_by_key "INVALID"}.to raise_error(ArgumentError)
    end

    it "raises if key is invalid" do
      expect {Backlogjp::Issue.find_by_key 12345}.to raise_error(ArgumentError)
    end

    it "returns nil if project is not found" do
      issue = Backlogjp::Issue.find_by_key "INVALID-1"

      issue.should be_nil
    end
  end
end

