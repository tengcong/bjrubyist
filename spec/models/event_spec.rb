require 'spec_helper'
describe Event do

  before(:each) do
    @event = Event.create

    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
    @user = User.create!(@attr) unless User.all.first
    @user.events = []
    @user.save
    @user.reload
  end

  describe "#joined" do
    it "should let user join" do
      @user.events.should == []

      @event.joined @user
      @user.reload
      @user.events.include?(@event).should == true
    end
  end

  describe "#members_count" do
    it 'should return members size' do
      origin_count = @event.members_count
      @event.joined @user
      current_count = @event.reload.members_count
      current_count.should == (origin_count + 1)
    end
  end

  describe "#remove_member" do
    before(:each) do
      @event.joined @user
    end
    it "should remove the right member" do
      @event.members.include?(@user).should == true
      @event.remove_member @user
      @event.reload

      @event.members.include?(@user).should == false
    end
    it "should remove the right membership" do
      @event.joined?(@user).should_not be_nil
      @event.remove_member @user
      @event.reload

      @event.joined?(@user).should be_nil
    end
  end

end
