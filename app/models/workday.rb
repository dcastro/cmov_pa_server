class Workday < ActiveRecord::Base
  belongs_to :schedule_plan
  #after_validation(:on => :create) { no_conflict }
  
=begin  
  def no_conflict
    return true if self.schedule_plan.active?
    
    self.schedule_plan.doctor.appointments.where(["scheduled_date > ?", self.scheduled_plan.start_date]).each do |ap|
      if ap.scheduled_date.wday == self.weekday and not (self.start .. self.end).include? ap.minutes
        errors.add(:time, "conflicts with appointment (id = #{ap.id})")
        return false
      end
    end
  end
=end
  
  def compatible_with(ap)
    return true if ap.scheduled_date.wday == self.weekday and (self.start .. self.end).include? ap.minutes
    return false
  end
  
  
end
