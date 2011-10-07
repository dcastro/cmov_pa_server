class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
  validates :doctor, :patient, :scheduled_date, :presence => true
  validate :divisible_by_thirty
  validate :correct_datetime
  
  def correct_datetime
    self.scheduled_date.class == DateTime
  end
  
  def minutes
    self.scheduled_date.hour * 60 + (self.scheduled_date.min)
  end
  
  def divisible_by_thirty
    errors.add(:scheduled_date, "is invalid.") unless [0,30].include? self.scheduled_date.min
    #unless self.minutes%30 == 0
  end
end
