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
    
    
    @json = @apps.to_json(
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
    
    @hash = ActiveSupport::JSON.decode(@json)
    
    @hash.each do |app|
      app["scheduled_time"] = app["scheduled_date"].to_datetime.to_s(:time)
      app["scheduled_date"] = app["scheduled_date"].to_date
    end
    
    render json: @hash
  end
  
  def next_busy_day
    if params[:date]
      @date = Date.parse(params[:date])
    else
      @date = Date.today
    end
    @date += 1.day
    
    @doc = Doctor.find(session[:id])
    
    @busy_day = @doc.appointments.where(["scheduled_date > ?", @date]).minimum(:scheduled_date)
    
    unless @busy_day
      render json: []
      return
    end

    apps = @doc.appointments.select {|a| a.scheduled_date.to_date == @busy_day.to_date} #where(["scheduled_date = ?", @busy_day])
    
    @json = apps.to_json(
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
    
    @hash = ActiveSupport::JSON.decode(@json)
    
    @hash.each do |app|
      app["scheduled_time"] = app["scheduled_date"].to_datetime.to_s(:time)
      app["scheduled_date"] = app["scheduled_date"].to_date
    end
    
    render json: @hash
    
    
      
  end
  
  def previous_busy_day
    
    @date = Date.parse(params[:date])
    @doc = Doctor.find(session[:id])
    
    @busy_day = @doc.appointments.where(["scheduled_date < ?", @date]).maximum(:scheduled_date)
    
    unless @busy_day and @busy_day > Date.today    
      render json: []
      return
    end
    
    apps = @doc.appointments.select {|a| a.scheduled_date.to_date == @busy_day.to_date}  #where(["scheduled_date = ?", @busy_day])
    
    @json = apps.to_json(
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
    
    @hash = ActiveSupport::JSON.decode(@json)
    
    @hash.each do |app|
      app["scheduled_time"] = app["scheduled_date"].to_datetime.to_s(:time)
      app["scheduled_date"] = app["scheduled_date"].to_date
    end
    
    render json: @hash
    
  end
  
  
  def busy_days
    
    apps = Doctor.find(session[:id]).appointments.where(["scheduled_date >= ?", DateTime.now])
    
    dates = apps.map do |app|
      app.scheduled_date.to_date
    end

    render json: dates.uniq
    
  end
  
  
  
end
