class VersionObserver < ActiveRecord::Observer
  
  observe Doctor, SchedulePlan, Appointment
  
  def before_save(model)
    #puts "****************"
    #puts model.class.name
    #puts "****************"
    
    @version = VersionLog.find_or_create_by_table(model.class.name)
    @version.version ||= 0
    @version.version += 1
    @version.save
    
  end
  
  def before_destroy(model)
    @version = VersionLog.find_or_create_by_table(model.class.name)
    @version.version ||= 0
    @version.version += 1
    @version.save
  end
  
  
  
end
