# == Schema Information
#
# Table name: cadets
#
#  id            :integer         not null, primary key
#  member_number :integer
#  firstname     :string(255)
#  lastname      :string(255)
#  dob           :date
#  street        :string(255)
#  town          :string(255)
#  county        :string(255)
#  postcode      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  email         :string(255)
#  landline      :string(255)
#  mobile        :string(255)
#

require 'spec_helper'



describe Cadet do

  before(:each) do
    @attr = {
      :firstname => 'Fiona',
      :lastname => 'McDonald',
      :member_number => 1370,
      :dob => Date.current - 15.years,
      :street => '33 Lunedale Avenue',
      :town => 'Sunderland',
      :county => 'Tyne and Wear',
      :postcode => 'SR68JX',
      :mobile => '07951217515',
      :landline => '01915894545',
      :email => "fiona.mcdonald@northumbria.sja.org.uk" }
  end

  it "should create a new instance given valid attributes" do
    Cadet.create!(@attr)
  end

  describe "first name" do

    it "should require a first name" do
      no_first_name_cadet = Cadet.new(@attr.merge(:firstname => ""))
      no_first_name_cadet.should_not be_valid
    end

    it "should reject names that are too long" do
      long_first_name = "a" * 21
      long_first_name_cadet = Cadet.new(@attr.merge(:firstname => long_first_name))
      long_first_name_cadet.should_not be_valid
    end
  end

  describe "last name" do

    it "should require a last name" do
      no_last_name_cadet = Cadet.new(@attr.merge(:lastname => ""))
      no_last_name_cadet.should_not be_valid
    end

    it "should reject names that are too long" do
      long_last_name = "a" * 31
      long_last_name_cadet = Cadet.new(@attr.merge(:lastname => long_last_name))
      long_last_name_cadet.should_not be_valid
    end
  end

  describe "date of birth" do

    it "should require a dob" do
      no_dob_cadet = Cadet.new(@attr.merge(:dob => nil))
      no_dob_cadet.should_not be_valid
    end

    it "should not allow anybody 18 or over to be a new cadet" do
      old_cadet = Cadet.new(@attr.merge(:dob => Date.current - 18.years))
      old_cadet.should_not be_valid
    end

    it "should not allow anybody younger than 9 to be a new cadet" do
      eight_yrs = Date.current - 8.years
      young_cadet = Cadet.new(@attr.merge(:dob => eight_yrs))
      young_cadet.should_not be_valid
    end
  end

  describe "member number" do

    it "should be a whole number" do
      wrong_member_number_cadet = Cadet.new(@attr.merge(:member_number => 10.5))
      wrong_member_number_cadet.should_not be_valid
    end

    it "should be unique if not null" do
      cadet = Cadet.new(@attr)
      cadet.save
      same_member_cadet = Cadet.new(@attr)
      same_member_cadet.should_not be_valid
    end
  end

  describe "address street line" do

    it "should require a street line" do
      no_street_cadet = Cadet.new(@attr.merge(:street => ''))
      no_street_cadet.should_not be_valid
    end

    it "should reject lines that are too long" do
      long_street = "a" * 201
      long_street_cadet = Cadet.new(@attr.merge(:street => long_street))
      long_street_cadet.should_not be_valid
    end
  end

  describe "address town line" do

    it "should require a town line" do
      no_town_cadet = Cadet.new(@attr.merge(:town => ''))
      no_town_cadet.should_not be_valid
    end

    it "should reject lines that are too long" do
      long_town = "a" * 201
      long_town_cadet = Cadet.new(@attr.merge(:town => long_town))
      long_town_cadet.should_not be_valid
    end
  end

  describe "address town line" do

    it "should require a county line" do
      no_county_cadet = Cadet.new(@attr.merge(:county => ''))
      no_county_cadet.should_not be_valid
    end

    it "should reject lines that are too long" do
      long_county = "a" * 101
      long_county_cadet = Cadet.new(@attr.merge(:county => long_county))
      long_county_cadet.should_not be_valid
    end
  end

  describe "postcode line" do

    it "should require a postcode" do
      no_postcode_cadet = Cadet.new(@attr.merge(:postcode => ''))
      no_postcode_cadet.should_not be_valid
    end

    it "should accept valid postcodes" do
      valid_postcode_cadet = Cadet.new(@attr)
      valid_postcode_cadet.should be_valid
    end

    it "should reject invalid postcodes" do
      ivalid_postcode_cadet = Cadet.new(@attr.merge(:postcode => 'SR68J'))
      ivalid_postcode_cadet.should_not be_valid
    end
  end

  describe "email address" do

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_cadet = Cadet.new(@attr.merge(:email => address))
        valid_email_cadet.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_cadet = Cadet.new(@attr.merge(:email => address))
        invalid_email_cadet.should_not be_valid
      end
    end

    it "should allow email address to be missing" do
      valid_email_cadet = Cadet.new(@attr.merge(:email => ''))
      valid_email_cadet.should be_valid
    end
  end

  describe "phone numbers" do

    describe "mobile number" do

      it "should reject invalid mobile numbers" do
        mobiles = %w[08951217515 07251217515 0795121751 079512175155]
        mobiles.each do |mobile|
          invalid_mobile_cadet = Cadet.new(@attr.merge(:mobile => mobile))
          invalid_mobile_cadet.should_not be_valid
        end
      end

      it "should accept valid mobile numbers" do
        mobiles = %w[07951217515 07651217513 07759647858]
        mobiles.each do |mobile|
          valid_mobile_cadet = Cadet.new(@attr.merge(:mobile => mobile))
          valid_mobile_cadet.should be_valid
        end
      end
    end

    describe "home telephone number" do

      it "should reject invalid landline numbers" do
        landlines = %w[1915489950 45120048759 05124700895]
        landlines.each do |landline|
          invalid_landline_cadet = Cadet.new(@attr.merge(:landline => landline))
          invalid_landline_cadet.should_not be_valid
        end
      end

      it "should accept valid landline numbers" do
        landlines = %w[01915214785 02057895433 03045258978]
        landlines.each do |landline|
          valid_landline_cadet = Cadet.new(@attr.merge(:landline => landline))
          valid_landline_cadet.should be_valid
        end
      end
    end

    it "should have at least one contact number present" do
      mobile_only_cadet = Cadet.new(@attr.merge(:landline => ''))
      mobile_only_cadet.should be_valid
      landline_only_cadet = Cadet.new(@attr.merge(:mobile => ''))
      landline_only_cadet.should be_valid
      no_phone_cadet = Cadet.new(@attr.merge(:mobile => '', :landline => ''))
      no_phone_cadet.should_not be_valid
    end
  end

  it "should return the home number as a default otherwise mobile number" do
    both_numbers_cadet = Cadet.new(@attr)
    both_numbers_cadet.telephone.should == both_numbers_cadet.landline
    mobile_only_cadet = Cadet.new(@attr.merge(:landline => ''))
    mobile_only_cadet.telephone.should == mobile_only_cadet.mobile
    landline_only_cadet = Cadet.new(@attr.merge(:mobile => ''))
    landline_only_cadet.telephone.should == landline_only_cadet.landline
  end
end
