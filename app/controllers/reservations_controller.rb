class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

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
        format.json { render action: 'show', status: :created, location: @reservation }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @reservation = Reservation.find params[:reservation_id]
    respond_to do |format|
      if @reservation.cancel!
        format.html { redirect_to @reservation, notice: 'Reservation was successfully canceled.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @reservation, notice: 'Reservation could not be canceled due to errors.' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    @reservation = Reservation.find params[:reservation_id]
    respond_to do |format|
      if @reservation.return!
        format.html { redirect_to @reservation, notice: 'Reservation was successfully closed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @reservation, notice: 'Reservation could not be closed due to errors.' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end

private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:item_id, :member_id, :reserved_date, :status, :notes, :created_by, :updated_by)
  end
end
