class DoctorController < ApplicationController
  def index
    
    @doctors = Doctor.find(:all, :include => :specialty)
    

    respond_to do |format|
      format.html { render json: @doctors.to_json( :only => [:name, :birthdate], :include => :specialty) }# index.html.erb
      format.json { render json: @doctors.to_json( :only => [:name, :birthdate], :include => :specialty) }
    end
  end
    
  

end
