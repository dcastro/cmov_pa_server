class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
  validates :doctor, :patient, :scheduled_date, :presence => true
  validates :scheduled_date, :uniqueness => {:scope => :doctor}
  
  validate :divisible_by_thirty
  validate :correct_datetime
  before_create :validate_conflicts
  
  #makes sure the scheduled_date behaves as a DateTime object, as in, it states a date AND a time,
  #unlike Date or Time objects.
  def correct_datetime
    self.scheduled_date.class == DateTime
  end
  
  def minutes
    self.scheduled_date.hour * 60 + (self.scheduled_date.min)
  end
  
  def divisible_by_thirty
    errors.add(:scheduled_date, "is invalid.") unless self.scheduled_date and [0,30].include? self.scheduled_date.min
    #unless self.minutes%30 == 0
  end
  
  def validate_conflicts
    @sch = self.doctor.schedule_plans.find_by_active(false)
    if not @sch or self.scheduled_date < @sch.start_date
      @sch = self.doctor.schedule_plans.find_by_active(true)
    end
    if not @sch
      errors.add(:doctor, "has no schedule plans to schedule this appointment on.")
      return false
    end
    
    @days = @sch.workdays.where(:weekday => self.scheduled_date.wday)
    
    @days.each do |d|
      return true if (d.start .. d.end).include? self.minutes
    end
    
    errors.add(:schedule, ": no schedule matches this appointment.")
    return false    
  end
  
end
