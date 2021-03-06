class PinsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  # Before doing anything, find the pin in question first
  before_action :find_pin, only: [:show, :edit, :update, :upvote, :destroy]

  def index
    @pins = Pin.all.order('created_at DESC')
  end

  def show

  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      redirect_to @pin, notice: 'Successfully created new Pin!'
    else
      render 'new' # So you don't lose what wasn't submitted if errored
    end
  end


  def edit


  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was updated!'
    else
      render 'edit'
    end
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back #route back to where you were
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
