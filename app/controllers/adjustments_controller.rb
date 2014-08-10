class AdjustmentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_adjustment, only: [:show, :edit, :update, :destroy]

  def table
    @adjustments = Adjustment.all.includes(:item, :copy)
    respond_to do |format|
      format.json { render json: AdjustmentsDatatable.new(view_context, @adjustments) }
    end
  end

  def index
    @adjustments = Adjustment.order("status desc, id desc").page(params[:page])
  end

  def show
  end

  def new
    @adjustment = Adjustment.new
  end

  def edit
  end

  def create
    @adjustment = Adjustment.new(adjustment_params)

    respond_to do |format|
      if @adjustment.save
        format.html { redirect_to @adjustment, notice: 'Adjustment was successfully created.' }
        format.json { render :show, status: :created, location: @adjustment }
      else
        format.html { render :new }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @adjustment.update(adjustment_params)
        format.html { redirect_to @adjustment, notice: 'Adjustment was successfully updated.' }
        format.json { render :show, status: :ok, location: @adjustment }
      else
        format.html { render :edit }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @adjustment = Adjustment.find params[:adjustment_id]
    respond_to do |format|
      if @adjustment.cancel!
        format.html { redirect_to @adjustment, notice: 'Adjustment was successfully canceled.' }
      else
        format.html { redirect_to @adjustment, notice: 'Adjustment could not be canceled due to errors.' }
      end
    end
  end

  def close
    @adjustment = Adjustment.find params[:adjustment_id]
    respond_to do |format|
      if @adjustment.close!
        format.html { redirect_to @adjustment, notice: 'Adjustment was successfully closed.' }
      else
        format.html { redirect_to @adjustment, notice: 'Adjustment could not be closed due to errors.' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @adjustment.destroy
        format.html { redirect_to adjustments_url }
      else
        format.html { redirect_to @adjustment, alert: @adjustment.errors[:base][0] }
      end
    end
  end

  private

  def set_adjustment
    @adjustment = Adjustment.find(params[:id])
  end

  def adjustment_params
    params.require(:adjustment).permit(:copy_id, :item_id, :adjusted_date, :adjusted_quantity, :kind, :reason, :status, :return_date, :notes)
  end
end
