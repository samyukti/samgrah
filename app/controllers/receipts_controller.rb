class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]

  def table
    @receipts = Receipt.all.includes(:member)
    respond_to do |format|
      format.json { render json: ReceiptsDatatable.new(view_context, @receipts) }
    end
  end

  def index
    @receipts = Receipt.order("received_date desc, id desc").page(params[:page])
  end

  def show
  end

  def new
    @receipt = Receipt.new
  end

  def edit
  end

  def create
    @receipt = Receipt.new(receipt_params)

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: 'Receipt was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: 'Receipt was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def cancel
    @receipt = Receipt.find params[:receipt_id]
    respond_to do |format|
      if @receipt.cancel!
        format.html { redirect_to @receipt, notice: 'Receipt was successfully canceled.' }
      else
        format.html { redirect_to @receipt, notice: 'Receipt could not be canceled due to errors.' }
      end
    end
  end

  def approve
    @receipt = Receipt.find params[:receipt_id]
    respond_to do |format|
      if @receipt.approve!
        format.html { redirect_to @receipt, notice: 'Receipt was successfully approved.' }
      else
        format.html { redirect_to @receipt, notice: 'Receipt could not be approved due to errors.' }
      end
    end
  end

  def destroy
    @receipt.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url }
    end
  end

  private

  def set_receipt
    @receipt = Receipt.find(params[:id])
  end

  def receipt_params
    params.require(:receipt).permit(:member_id, :received_date, :kind, :amount, :mode, :status, :reference_1, :reference_2, :reference_3, :notes)
  end
end
