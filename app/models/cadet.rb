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

class Cadet < ActiveRecord::Base
  
  has_many :emergency_contacts
  
  validates :firstname, :presence => true, :length => {:maximum => 20}
  validates :lastname, :presence => true, :length => {:maximum => 30}
  validates :member_number, :numericality => {:only_integer => true}, :uniqueness => true
  validates :street, :presence => true, :length => {:maximum => 200}
  validates :town, :presence => true, :length => {:maximum => 200}
  validates :county, :presence => true, :length => {:maximum => 100}
  validates :postcode, :format => /^([A-PR-UWYZ][A-HK-Y0-9][A-HJKS-UW0-9]?[A-HJKS-UW0-9]?)\s*([0-9][ABD-HJLN-UW-Z]{2})$/i
  validate :dob_is_in_range, :on => :create
  validate :contact_numbers
  validate :email_format
  
  
  
  def dob_is_in_range
    return errors.add(:dob, "DOB must be present") if dob.nil?
    return errors.add(:dob, "Cadet must be nine years or older") if dob > (Date.current - 9.years)
    return errors.add(:dob, "Cadet must be younger than 18 years") if dob <= (Date.current - 18.years)
  end
  
  def contact_numbers
    return errors.add(:landline, "A contact number must be present") if landline.blank? && mobile.blank?
    return errors.add(:landline, "Home telephone number is invalid") unless landline.blank? || landline =~ /^0(1|2|3)\d{9}$/
    return errors.add(:mobile, "Mobile number is invalid") unless mobile.blank? || mobile =~ /^07[5-9]\d{8}$/
  end 
  
  def email_format
    errors.add(:email, "Ivalid email format") unless email.blank? || email =~ /^\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z$/i
  end
  
end
