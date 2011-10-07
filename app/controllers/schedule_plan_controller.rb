class SchedulePlanController < ApplicationController
  
  # curl -X POST -d "{\"doctor_id\":22,\"days\":[{\"weekday\":2, \"start\":600, \"end\":720}, {\"weekday\":4, \"start\":840, \"end\":1140}]}" localhost:3000/schedule_plan/create
  # curl -X POST -d "{\"doctor_id\":22,\"days\":[{\"weekday\":2, \"start\":600, \"end\":720}, {\"weekday\":6, \"start\":840, \"end\":1140}], \"start_date\":\"08-10-2011\"}" localhost:3000/schedule_plan/create

  def create
    
    @json = ActiveSupport::JSON.decode(request.body.read)
    
    @sch = SchedulePlan.new :doctor => Doctor.find(@json["doctor_id"]),
                            :start_date => @json["start_date"]                            
    
    @json["days"].each do |d|
      @sch.workdays << Workday.new( :weekday => d["weekday"],
                                   :start => d["start"],
                                   :end => d["end"] )
    end
    
    begin
      @sch.save!  
      render nothing: true    
    rescue ActiveRecord::RecordInvalid => invalid
      response.status = 500
      render text: invalid.record.errors.full_messages
    rescue ActiveRecord::RecordNotSaved => not_saved
      response.status = 500
      render text: invalid.record.errors.full_messages
    end
    
  end

end
