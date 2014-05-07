class MastersController < ApplicationController
  include Userstamp
  load_and_authorize_resource

  attr_writer :klass, :master_class, :master_string
  before_action :set_class
  before_action :set_master, only: [:show, :edit, :update, :destroy]
  before_action :set_master_custom, only: [:copy, :lock, :unlock, :archive, :unarchive]

  def index
    self.instance_variable_set("@#{controller_name}", @master_class.order(:id).page(params[:page]))
  end

  def show
  end

  def new
    self.master = @master_class.new
  end

  def edit
  end

  def create
    self.master = @master_class.new(master_params)
    userstamp self.master

    respond_to do |format|
      if self.master.save
        format.html { redirect_to self.master, notice: "#{@klass.titleize} was successfully created." }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    userstamp_update self.master
    respond_to do |format|
      if self.master.update(master_params)
        format.html { redirect_to self.master, notice: "#{@klass.titleize} was successfully updated." }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if self.master.destroy
        format.html { redirect_to @master_class }
      else
        format.html { redirect_to self.master, alert: self.master.errors[:base][0] }
      end
    end
  end

  def copy
    original = self.master
    self.master  = @master_class.new(original.attributes)
    render :new
  end

  def lock
    respond_to do |format|
      if self.master.lock
        format.html { redirect_to self.master, notice: "#{@klass.titleize} was successfully locked." }
      else
        format.html { redirect_to self.master, notice: "#{@klass.titleize} could not be locked." }
      end
    end
  end

  def unlock
    respond_to do |format|
      if self.master.unlock
        format.html { redirect_to self.master, notice: "#{@klass.titleize} was successfully unlocked." }
      else
        format.html { redirect_to self.master, notice: "#{@klass.titleize} could not be unlocked." }
      end
    end
  end

  def archive
    respond_to do |format|
      if self.master.archive
        format.html { redirect_to @master_class, notice: "#{@klass.titleize} was successfully archived." }
      else
        format.html { redirect_to self.master, notice: "#{@klass.titleize} could not be archived." }
      end
    end
  end

  def unarchive
    respond_to do |format|
      if self.master.unarchive
        format.html { redirect_to self.master, notice: "#{@klass.titleize} was successfully unarchived." }
      else
        format.html { redirect_to self.master, notice: "#{@klass.titleize} could not be unarchived." }
      end
    end
  end

  protected

  def master
    self.instance_variable_get("@#{@master_string}")
  end

  def master=(val)
    self.instance_variable_set("@#{@master_string}", val)
  end

  private

  def set_class
    self.klass = controller_name.classify
    self.master_class = @klass.constantize
    self.master_string = controller_name.singularize
  end

  def set_master
    self.master = @master_class.find(params[:id])
  end

  def set_master_custom
    id = "#{@klass.underscore}_id".to_sym
    self.master = @master_class.find(params[id])
  end

  def master_params
    method = "#{@master_string}_params"
    params[@master_string] &&= send(method) if respond_to?(method, true)
  end
end
