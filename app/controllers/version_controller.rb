class VersionController < ApplicationController
  def show
    @versions = VersionLog.all
    render json: @versions.to_json(:only => [:table, :version])
  end

end
