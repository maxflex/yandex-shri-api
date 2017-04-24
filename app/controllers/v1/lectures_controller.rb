class V1::LecturesController < ApplicationController
  def index
    @lectures = Lecture.order(:date)
    filter_params.each do |key, value|
      @lectures = @lectures.public_send(key, value) if value.present?
    end
    render :index, status: :ok
  end

  def show
    @lecture = Lecture.where(id: params[:id]).conducted.take!
    render :show, status: :ok
  end

  # POST /gift_codes
  # POST /gift_codes.json
  def create
    @lecture = Lecture.new(lecture_params)
    if @lecture.save
      head :ok
    else
      render json: {errors: @lecture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gift_codes/1
  # PATCH/PUT /gift_codes/1.json
  def update
    Lecture.find(params[:id]).update_attributes(lecture_params)
  end

  # DELETE /gift_codes/1
  # DELETE /gift_codes/1.json
  def destroy
    Lecture.destroy(params[:id])
  end

  private

  # параметры, допустимые к фильтрации
  def filter_params
    params.slice(:school, :auditorium_id, :date_start, :date_end)
  end

  # параметры лекции
  def lecture_params
    params.require(:lecture).permit(:speaker_id, :auditorium_id, :topic, :students_count, :date, :time_start, :time_end, {:school_ids => []})
  end

end
