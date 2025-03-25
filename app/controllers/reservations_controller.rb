class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  before_action :set_reservation, only: [:show, :destroy]

  def new
    @reservation = @room.reservations.build
  end

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to @reservation, notice: "Reservation created successfully."
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @reservation.destroy
    redirect_to rooms_path, notice: "Reservation cancelled successfully."
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time)
  end
end
