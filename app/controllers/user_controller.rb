class UserController < ApplicationController

  def login
    if user = User.authenticate(params[:username], params[:password])
      session[:username] = user.username
      session[:type] = user.utilizador_type
      session[:id] = user.utilizador.id
      render text: "success"
    
    else
      response.status = 500
      render text: "wronglol"
    end
  end

  def logout
    session[:username] = nil
    session[:id] = nil
    session[:type] = nil
    render :nothing => true
  end
  
  def profile
    @user = User.find_by_username(session[:username])
    render json: @user.to_json(
                                  :only => [:birthdate, :name, :username, :utilizador_type],
                                  :include => {
                                    :utilizador => {
                                        :only => [:sex, :photo, :address, :id]
                                    }
                                  })
  end
  
  # POST
  # curl "http://localhost:3000/user/create" -d "{\"name\":\"Pedro\", \"username\":\"ppedro\", \"password\":\"12345\"}" -X POST -v
  def create
    @json = ActiveSupport::JSON.decode(request.body.read)
=begin
    @patient = Patient.new :address => @json["address"],
                           :sex => @json["sex"],
                           :user => User.new( :name => @json["name"],
                                              :username => @json["username"],
                                              :password => @json["password"],
                                              :birthdate => @json["birthdate"])
=end
    @user = User.new( :name => @json["name"],
                             :username => @json["username"],
                             :password => @json["password"],
                             :birthdate => @json["birthdate"],
                             :utilizador => Patient.new( :address => @json["address"],
                                                      :sex => @json["sex"])
                             )
    
                                         
    if @user.save
      render json: []#nothing: true
    else
      response.status = 500
      render text: @user.errors.full_messages
    end
=begin
    @user = User.new :name => @json["name"],
             :username => @json["username"],
             :password => @json["password"]
             
    if @user.save
      Patient.create :user => @user
      render text: "success"
    else
      response.status = 500
      # render text: @user.errors.full_messages
      render text: @user.errors.to_json
    end
=end
  end

end
