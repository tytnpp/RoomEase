class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  before_action :set_reservation, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:activity]
  before_action :activity, only: [:activity]

  def new
    @reservation = @room.reservations.build
  end

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user
  
    if @reservation.save
      redirect_to rooms_path, notice: "Reservation created successfully."
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

  def activity
    # Current reservations (reservations that are active right now)
    @current_reservations = current_user.reservations.where("start_time <= ? AND end_time >= ?", Time.current, Time.current)
  
    # Reservation history (reservations that have already ended)
    @past_reservations = current_user.reservations.where("end_time < ?", Time.current).order(end_time: :desc)
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to activity_path, notice: "Reservation updated successfully."
    else
      render :edit
    end
  end
end
