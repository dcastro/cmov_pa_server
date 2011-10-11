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
        :schedule_plans => {
          :include => :workdays
        },
        :specialty => {:only => :name}
      }
    )
  end

end
