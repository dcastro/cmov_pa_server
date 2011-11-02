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
  
  def index
    
    unless session[:username]
      response.status = 401
      render nothing: true
      return
    end
    
    @patient = Patient.find(session[:id])#User.find_by_username(session[:username])
    
    @apps = []
    @apps << @patient.version
    #@apps += @patient.appointments
    
    @json = @patient.appointments.where(["scheduled_date > ?", DateTime.now ]).to_json(
        :include => {
          :patient => {
            :only => {},
            :include => {
              :user => {
                :only => :name
              }
            }
          }
        }
    )
    
    @array = ActiveSupport::JSON.decode(@json)
    
    @array.each do |app|
      app["scheduled_time"] = app["scheduled_date"].to_datetime.to_s(:time)
      app["scheduled_date"] = app["scheduled_date"].to_date
    end
    
    @apps += @array
    
    render json: @apps
    
    
  end
  
  def destroy
    
    @app = Appointment.find(params[:id])
    render nothing: true
    
    
    if ((@app.scheduled_date - DateTime.now) /60/60 ).to_i < 24
      response.status = 401 #Unauthorized
      return
    end
    
    unless @app.destroy
      response.status = 500
    end
    
  end

end
