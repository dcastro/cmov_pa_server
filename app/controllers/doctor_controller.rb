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
  
end
