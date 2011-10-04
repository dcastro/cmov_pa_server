class DoctorController < ApplicationController
  def index
    
    @doctors = Doctor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @doctors }
    end
  end
  
  def ind
    @doctors = Doctor.select([:name, :birthdate])
    render json: @doctors
  end
  
  

end
