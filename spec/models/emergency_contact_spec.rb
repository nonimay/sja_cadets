# == Schema Information
#
# Table name: emergency_contacts
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  number       :string(255)
#  relationship :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  cadet_id     :integer
#

require 'spec_helper'


describe EmergencyContact do

  before(:each) do
    @cadet = Factory(:cadet)
    @attr = {
      :name => 'Jane McDonald',
      :number => '01915489498',
      :relationship => 'mother'
    }
  end

  it "should create a new instance given valid attributes" do
    @cadet.emergency_contacts.create!(@attr)
  end

  describe "contact name" do

    it "should have a name" do
      no_name_contact = EmergencyContact.new(@attr.merge(:name => ''))
      no_name_contact.should_not be_valid
    end

    it "should reject names that are too long" do
      long_name = "a" * 51
      long_name_contact = EmergencyContact.new(@attr.merge(:name => long_name))
      long_name_contact.should_not be_valid
    end
  end

  describe "contact number" do

    it "should have a contact number" do
      no_number_contact = EmergencyContact.new(@attr.merge(:number => ''))
      no_number_contact.should_not be_valid
    end

    it "should accept value contact numbers" do
      numbers = %w[07951217515 07651217513 07759647858 01915214785 02057895433 03045258978]
      numbers.each do |number|
        valid_number_contact = EmergencyContact.new(@attr.merge(:number => number))
        valid_number_contact.should be_valid
      end
    end

    it "should reject invalid contact numbers" do
      numbers = %w[1915489950 45120048759 05124700895 08951217515 04651217515 0795121751 079512175155]
      numbers.each do |number|
        invalid_number_contact = EmergencyContact.new(@attr.merge(:number => number))
        invalid_number_contact.should_not be_valid
      end
    end
  end

  describe "contact relationship" do

    it "should have a relationship" do
      no_relationship_contact = EmergencyContact.new(@attr.merge(:relationship => ''))
      no_relationship_contact.should_not be_valid
    end

    it "should reject names that are too long" do
      long_relationship = "a" * 51
      long_relationship_contact = EmergencyContact.new(@attr.merge(:relationship => long_relationship))
      long_relationship_contact.should_not be_valid
    end
  end

  describe "cadet associations" do

    before(:each) do
      @emergency_contact = @cadet.emergency_contacts.create(@attr)
    end

    it "should have a cadet attribute" do
      @emergency_contact.should respond_to(:cadet)
    end

    it "should have the right associated cadet" do
      @emergency_contact.cadet_id.should == @cadet.id
      @emergency_contact.cadet.should == @cadet
    end
  end
end
