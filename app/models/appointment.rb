class Appointment < ActiveRecord::Base
  
  default_scope :order => 'scheduled_date'
  
  belongs_to :patient
  belongs_to :doctor

  validates :doctor, :patient, :scheduled_date, :presence => true
   
  validates :scheduled_date, :uniqueness => {:scope => :doctor_id}

  validate :divisible_by_thirty
  validate :correct_datetime
  after_validation(:on => :create) { validate_conflicts }
  
  #makes sure the scheduled_date behaves as a DateTime object, as in, it states a date AND a time,
  #unlike Date or Time objects.
  def correct_datetime
    errors.add(:scheduled_date, "doesn't behave as a DateTime (YYYY-MM-DD HH:MM)") unless self.scheduled_date.class == DateTime or self.scheduled_date.class == ActiveSupport::TimeWithZone
  end
  
  def minutes
    self.scheduled_date.hour * 60 + (self.scheduled_date.min)
  end
  
  def divisible_by_thirty
    errors.add(:scheduled_date, "is invalid.") unless self.scheduled_date and [0,30].include? self.scheduled_date.min
    #unless self.minutes%30 == 0
  end
  
  def validate_conflicts
    return false unless self.doctor
    
    @sch = self.doctor.schedule_plans.find_by_active(false)
    if not @sch or self.scheduled_date < @sch.start_date
      @sch = self.doctor.schedule_plans.find_by_active(true)
    end
    if not @sch
      errors.add(:doctor, "has no schedule plans to schedule this appointment on.")
      return false
    end
    
    @days = @sch.workdays.where(:weekday => self.scheduled_date.cwday)
    
    @days.each do |d|
      return true if (d.start .. (d.end-30)).include? self.minutes
    end

    
    errors.add(:schedule, ": no schedule matches this appointment.")
    return false    
  end

end
