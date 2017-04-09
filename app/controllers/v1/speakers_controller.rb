class V1::SpeakersController < ApplicationController
  def show
    @speaker = Speaker.find(params[:id])
    render :show, status: :ok
  end
end
