class V1::LecturesController < ApplicationController
  def index
    @lectures = Lecture.order(:date).all
    render :index, status: :ok
  end

  def show
    @lecture = Lecture.where(id: params[:id]).conducted.take!
    render :show, status: :ok
  end
end
