class Duty < ActiveRecord::Base

  validates :event, :presence => true
  validates :nature, :presence => true
  validates :location, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :quota, :presence => true, :numericality => { :greater_than => 0}
  validate :start_before_end

  def start_before_end
    errors.add(:end_date, "The duty must start before it ends") if (end_date.present? && start_date.present?) && end_date < start_date
  end

end
