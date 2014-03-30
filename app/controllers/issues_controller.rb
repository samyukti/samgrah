class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    @issues = Issue.order("status desc, id desc").page(params[:page])
  end

  def show
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @issue }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    @issue = Issue.find params[:issue_id]
    respond_to do |format|
      if @issue.cancel!
        format.html { redirect_to @issue, notice: 'Issue was successfully canceled.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @issue, notice: 'Issue could not be canceled due to errors.' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    @issue = Issue.find params[:issue_id]
    respond_to do |format|
      if @issue.close!
        format.html { redirect_to @issue, notice: 'Item was successfully returned.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @issue, notice: 'Item could not be returned due to errors.' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:copy_id, :member_id, :issued_date, :kind, :status, :return_date, :extension, :notes, :created_by, :updated_by)
  end
end
