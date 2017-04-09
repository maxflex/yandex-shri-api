class V1::SchoolsController < ApplicationController
  def index
    @schools = School.all
    render :index, status: :ok
  end
end
