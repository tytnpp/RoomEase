class ReservationsController < ApplicationController
  before_action :set_room, only: [ :new, :create ]
  before_action :set_reservation, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :activity ]
  before_action :activity, only: [ :activity ]

  def new
    @reservation = @room.reservations.build
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if overlapping_reservation?(@room, @reservation)
      flash.now[:alert] = "This time slot has already been reserved."
      render :new, status: :unprocessable_entity
    elsif @reservation.save
      redirect_to activity_path, notice: "Reservation created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def cancel
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to activity_path, notice: "Reservation canceled successfully."
    else
      redirect_to activity_path, alert: "There was an error canceling the reservation."
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to activity_path, notice: "Reservation canceled successfully."
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
    @current_reservations = current_user.reservations
                                        .where("start_time >= ?", Time.zone.now)
                                        .order(start_time: :asc)

    # Reservation history (reservations that have already ended)
    @past_reservations = current_user.reservations
                                     .where("start_time <= ?", Time.zone.now)
                                     .order(end_time: :desc)
                                     .page(params[:page])
                                     .per(7)
  end

  def overlapping_reservation?(room, new_reservation)
    room.reservations
        .where.not(id: new_reservation.id)
        .where("start_time < ? AND end_time > ?", new_reservation.end_time, new_reservation.start_time)
        .exists?
  end
end
