class VersionObserver < ActiveRecord::Observer
  
  observe Doctors, SchedulePlan
  
  
  
end
