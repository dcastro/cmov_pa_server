class VersionController < ApplicationController
  def show
    @hash = { :version => VersionLog.find_by_table("version").version }
    
    @user = User.find_by_username(session[:username])
    if @user and @user.utilizador.class == Patient
      @hash[:patient] = @user.utilizador.version
    end
    
    render json: @hash #@versions.to_json(:only => [:table, :version])
  end
  
  def update_db
    @json = Doctor.all
    @json << VersionLog.find_by_table("version").version
    render json: @json.to_json(
      :include => {
        :user => {
          :except => [:hashed_password, :salt, :username]
        },
        :schedule_plans => {
          :include => :workdays
        },
        :specialty => {:only => :name}
      }
    )
  end
  
  def update_my_appointments

    unless session[:username] and session[:type] == Patient.name
      response.status = 401
      render nothing: true
      return
    end
    
    @user = User.find_by_username(session[:username])
    render json: @user.utilizador.appointments
  end

end
