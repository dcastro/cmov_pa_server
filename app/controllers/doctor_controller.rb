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
  
end
