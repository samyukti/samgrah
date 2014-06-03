class IssuesController < ApplicationController
  load_and_authorize_resource
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def table
    @issues = Issue.all.includes(:item, :copy, :member)
    respond_to do |format|
      format.json { render json: IssuesDatatable.new(view_context, @issues) }
    end
  end

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
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def cancel
    @issue = Issue.find params[:issue_id]
    respond_to do |format|
      if @issue.cancel!
        format.html { redirect_to @issue, notice: 'Issue was successfully canceled.' }
      else
        format.html { redirect_to @issue, notice: 'Issue could not be canceled due to errors.' }
      end
    end
  end

  def close
    @issue = Issue.find params[:issue_id]
    respond_to do |format|
      if @issue.close!
        format.html { redirect_to @issue, notice: 'Item was successfully returned.' }
      else
        format.html { redirect_to @issue, notice: 'Item could not be returned due to errors.' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @issue.destroy
        format.html { redirect_to issues_url }
      else
        format.html { redirect_to @issue, alert: @issue.errors[:base][0] }
      end
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:copy_id, :member_id, :issued_date, :kind, :return_date, :notes)
  end
end
