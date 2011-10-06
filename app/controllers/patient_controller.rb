class PatientController < ApplicationController
  def index
    
    @patients = Patient.find(:all, :include => [:user])
    render json: @patients.to_json( :only => [:name, :birthdate], :include => :user)
    
  end

end
