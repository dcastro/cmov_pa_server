class DoctorController < ApplicationController
  def index
    @doctors = Doctor.find(:all, :include => [:specialty, :user])
    
    respond_to do |format|
      format.html { render json: @doctors.to_json( :only => [:name, :birthdate], :include => [:specialty, :user]) }# index.html.erb
      format.json { render json: @doctors.to_json( :only => [:name, :birthdate], :include => [:specialty, :user]) }
    end
  end
  
  def show
    
    @doc = User.where("utilizador_type = 'Doctor'").find_by_name(params[:name])
    render json: @doc.to_json(:include => :utilizador)
    
  end
  
  def specialties
    render json: Specialty.all.to_json(:only => :name)  
  end
  
  def index_by_specialty
    @doctors = Specialty.find_by_name(params[:specialty]).doctors
    #Doctor.where(:specialty => params[:specialty]).find(:all, :include => [:specialty, :user])
    
    render json: @doctors.to_json( :only => [:name, :birthdate], :include => [:user])
  end
  
  def get_appointments
    if params[:date]
      @date = Date.parse(params[:date])
    else
      @date = Date.today
    end
    
    @doc = User.find_by_username(session[:username]).utilizador
    @apps = @doc.appointments.select {|a| a.scheduled_date.to_date == @date}
    
    render json: @apps.to_json(
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
  end
  
  
end
