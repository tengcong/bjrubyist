require 'spec_helper'

describe Event do
  before(:each) do
    @event = Event.new
  end

  it "should respond to from and to" do
    @event.respond_to?(:from).should == true
    @event.respond_to?(:to).should == true
  end
end
