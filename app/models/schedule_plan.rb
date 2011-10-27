class SchedulePlan < ActiveRecord::Base
  belongs_to :doctor
  has_many :workdays, :dependent => :destroy
  validates :doctor_id, :presence => true
  
  
  after_validation(:on => :create)  { ammount_of_plans }
  after_validation(:on => :create)  { correct_date }
  after_validation(:on => :create)  { active_state }
  after_validation(:on => :create)  { no_conflict }
  
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
  
  def no_conflict
    return false unless self.doctor
    return true if self.active?
    
    self.doctor.appointments.where(["scheduled_date > ?", self.start_date]).each do |ap|
      @compatibilities = self.workdays.map do |w|
        w.compatible_with(ap)
      end
      
      if not @compatibilities.include? true
        errors.add(:workday, "incompatible with existing appointments (name = #{ap.patient.user.name} / id = #{ap.id}).")
        return false
      end
    end
  end
  
  def SchedulePlan.available_day(doctor, date, is_next)
    @sch = doctor.schedule_plans.find_by_active(true)
    @sch2 = doctor.schedule_plans.find_by_active(false)
    
    
    while true do
      if is_next
        date += 1.day
      else
        date -= 1.day
        return false if date < Date.today
      end
       
      @sch = @sch2 if @sch2 and date >= @sch2.start_date
      
      #determin which workdays match the given date
      @days = @sch.workdays.where(:weekday => date.wday).find(:all)
      
      if @days.empty?
     #   next
      end
      
      #determin possible scheduled times for appointments for the given date
      @hours = []
      #puts @days
      
      @days.each do |d|
        start = d.start
        e = d.end
        
        #puts start
        #puts d.end
        #puts @hours
        
        while start < e do
          @hours << start
          start += 30
          #puts @hours
          
        end
      end
      
      #retrieve the appointments for this day
      @apps = doctor.appointments.select {|a| a.scheduled_date.to_date == date.to_date}
      @busy_hours = @apps.collect {|a| a.minutes }
      
      #return @hours.any? {|h| not @busy_hours.include? h }
      
      #check if there's any hour available
      if @hours.any? {|h| not @busy_hours.include? h }
        @hash = {
          :date => date,
          :hours => (@hours - @busy_hours).collect {|x| (x/60).to_s + ":" + (x%60).to_s }
        }
        return @hash
      end   
     
    end
    
  end
  
  
  
end
