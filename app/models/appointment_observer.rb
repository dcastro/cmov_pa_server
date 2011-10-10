class AppointmentObserver < ActiveRecord::Observer
  
  def before_save(model)
    @p = model.patient
    @p.version ||= 0
    @p.version += 1
    @p.save
  end
  
  def before_destroy(model)
    @p = model.patient
    @p.version ||= 0
    @p.version += 1
    @p.save
  end
  
end
