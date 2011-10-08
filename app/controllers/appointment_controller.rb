class AppointmentController < ApplicationController
  
  # curl -X POST -d "{\"doctor_id\":22, \"date\":\"2011-09-02 10:30\"}" localhost:3000/appointment/create
  def create
    @json = ActiveSupport::JSON.decode(request.body.read)
    @user = User.find_by_username(session[:username]).utilizador
    
    if @user.class == Patient
      @app = Appointment.new :doctor => Doctor.find(@json["doctor_id"]),
                             :patient => @user,
                             :scheduled_date => Time.parse(@json["date"])
      if @app.save
        render nothing: true
      else
        response.status = 500
        render text: @app.errors.full_messages        
      end
    else
      response.status = 401
      render nothing: true
    end                  
  end

end
