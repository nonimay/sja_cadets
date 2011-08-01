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

class EmergencyContact < ActiveRecord::Base
  
  belongs_to :cadet
  validates :name, :presence => true, :length => {:maximum => 50}
  validates :number, :presence => true, :format => {:with => /^0(1|2|3|7)\d{9}$/}
  validates :relationship, :presence => true, :length => {:maximum => 50}
end
