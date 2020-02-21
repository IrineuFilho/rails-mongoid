class ComplainsController < ApplicationController
  before_action :set_complain, only: [:show, :update, :destroy]

  def index
    @complains = Complain.all

    render json: @complains
  end

  def show
    render json: @complain
  end

  def create
    @complain = Complain.create(complain_params)
    if @complain.persisted?
      render json: @complain, status: :created, location: @complain
    else
      render json: @complain.errors, status: :unprocessable_entity
    end
  end

  def update
    if @complain.update(complain_params)
      render json: @complain
    else
      render json: @complain.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @complain.destroy
  end

  private

  def set_complain
    @complain = Complain.find(params[:id])
  end

  def complain_params
    params
        .require(:complain)
        .permit(:title,
                :description,
                :locale,
                :company)
  end
end
