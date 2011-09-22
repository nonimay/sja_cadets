require 'spec_helper'

describe Duty do

  before(:each) do
    @attr = {
      :event => 'An Event',
      :nature => 'Nature of the Event',
      :location => "Some Address",
      :start_date => Time.now,
      :end_date => Time.now + 1.hour,
      :quota => 2
    }  
  end

  it "should create a new instance given valid attributes" do
    Duty.create!(@attr)
  end

  describe "event" do

    it "should require an event name" do
      invalid = Duty.new(@attr.merge(:event => ""))
      invalid.should_not be_valid
    end
  end

  describe "nature" do

    it "should require an event nature" do
      invalid = Duty.new(@attr.merge(:nature => ""))
      invalid.should_not be_valid
    end
  end

  describe "location" do

    it "should require an event location" do
      invalid = Duty.new(@attr.merge(:location => ""))
      invalid.should_not be_valid
    end
  end

  describe "start datetime" do

    it "should require an event start datetime" do
      invalid = Duty.new(@attr.merge(:start_date => ""))
      invalid.should_not be_valid
    end
  end

  describe "end datetime" do

    it "should require an event end datetime" do
      invalid = Duty.new(@attr.merge(:end_date => ""))
      invalid.should_not be_valid
    end

    it "should not end before it has started" do
      invalid = Duty.new(@attr.merge(:end_date => Time.now - 1.hour))
      invalid.should_not be_valid
    end
      
  end

  describe "quota" do

    it "should require a cadet quota" do
      invalid = Duty.new(@attr.merge(:quota => nil))
      invalid.should_not be_valid
    end

    it "should require a cadet quota of 1 or more" do
      invalid = Duty.new(@attr.merge(:quota => 0))
      invalid.should_not be_valid
    end
  end
end
