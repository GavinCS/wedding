require File.dirname(__FILE__) + '/../spec_helper'

describe Accomodation do
  it "should be valid" do
    Accomodation.new.should be_valid
  end
end
