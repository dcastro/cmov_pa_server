class SchedulePlan < ActiveRecord::Base
  belongs_to :doctor
  has_many :workdays, :dependent => :destroy
  validates :doctor_id, :presence => true
  
  
  after_validation(:on => :create)  { ammount_of_plans }
  after_validation(:on => :create)  { correct_date }
  after_validation(:on => :create)  { active_state }
  
  def active_state
    return false unless self.doctor
    
    if self.doctor.schedule_plans.count == 1
      self.active = false
    else
      self.active = true
    end
  end
  
  
  def correct_date
    return false unless self.doctor
    if self.doctor.schedule_plans.count == 1 and not self.start_date
      errors.add(:start_date, "must be specified for future plan.")
      return false
    elsif self.doctor.schedule_plans.count == 0
      self.start_date = nil
    end
      
    return true    
  end
  
  def ammount_of_plans
    return false unless self.doctor
    if self.doctor.schedule_plans.count > 1
      errors.add(:doctor_id, "already reached his/her plan limit.")
      return false
    end
    return true
  end
  
end
