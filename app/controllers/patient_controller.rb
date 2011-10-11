class PatientController < ApplicationController
  def index
    
    @patients = Patient.find(:all, :include => [:user])
    render json: @patients.to_json( :only => [:name, :birthdate], :include => :user)
    
  end
  
  def show
    @pat = Patient.find(params[:patient_id])
    render json: @pat.to_json(
        :include => {
          :user => {
            :except => [:hashed_password, :salt, :username]
          }
        }
    )
  end

end
