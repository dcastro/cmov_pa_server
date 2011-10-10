class VersionObserver < ActiveRecord::Observer
  
  observe Doctor, SchedulePlan, Specialty
  
  def before_save(model)    
    @version = VersionLog.find_or_create_by_table("version")
    @version.version ||= 0
    @version.version += 1
    @version.save
    
  end
  
  def before_destroy(model)
    @version = VersionLog.find_or_create_by_table("version")
    @version.version ||= 0
    @version.version += 1
    @version.save
  end
  
  
  
end
