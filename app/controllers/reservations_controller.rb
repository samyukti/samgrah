class ReservationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def table
    @reservations = Reservation.all.includes(:item, :member)
    respond_to do |format|
      format.json { render json: ReservationsDatatable.new(view_context, @reservations) }
    end
  end

  def index
    @reservations = Reservation.order("status desc, id desc").page(params[:page])
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def edit
  end

  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def cancel
    @reservation = Reservation.find params[:reservation_id]
    respond_to do |format|
      if @reservation.cancel!
        format.html { redirect_to @reservation, notice: 'Reservation was successfully canceled.' }
      else
        format.html { redirect_to @reservation, notice: 'Reservation could not be canceled due to errors.' }
      end
    end
  end

  def close
    @reservation = Reservation.find params[:reservation_id]
    respond_to do |format|
      if @reservation.close!
        format.html { redirect_to @reservation, notice: 'Reservation was successfully closed.' }
      else
        format.html { redirect_to @reservation, notice: 'Reservation could not be closed due to errors.' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @reservation.destroy
        format.html { redirect_to reservations_url }
      else
        format.html { redirect_to @reservation, alert: @reservation.errors[:base][0] }
      end
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:item_id, :member_id, :reserved_date, :status, :notes)
  end
end
