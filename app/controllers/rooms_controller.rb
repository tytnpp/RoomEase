class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])

    # Define time slots (9 AM to 6 PM)
    start_time = Time.current.change(hour: 9, min: 0, sec: 0)
    end_time = Time.current.change(hour: 18, min: 0, sec: 0)
    @time_slots = []

    while start_time < end_time
      slot_end_time = start_time + 1.hour
      is_available = @room.reservations.where("start_time < ? AND end_time > ?", slot_end_time, start_time).empty?
      @time_slots << { start_time: start_time, end_time: slot_end_time, available: is_available }
      start_time = slot_end_time
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: "Room created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "Room updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "Room deleted successfully."
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :capacity, :status)
  end
end
