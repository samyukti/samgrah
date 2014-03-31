class MastersController < ApplicationController
  include Userstamp
  load_and_authorize_resource

  attr_writer :master_class
  attr_writer :klass
  before_action :set_class
  before_action :set_master, only: [:show, :edit, :update, :destroy]
  before_action :set_master_custom, only: [:copy, :lock, :unlock, :archive, :unarchive]

  def index
    @masters = @master_class.page(params[:page])
  end

  def show
  end

  def new
    @master = @master_class.new
  end

  def edit
  end

  def create
    @master = @master_class.new(master_params)
    userstamp @master

    respond_to do |format|
      if @master.save
        format.html { redirect_to @master, notice: "#{@klass.titleize} was successfully created." }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    userstamp_update @master
    respond_to do |format|
      if @master.update(master_params)
        format.html { redirect_to @master, notice: "#{@klass.titleize} was successfully updated." }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @master.destroy
        format.html { redirect_to @master_class }
      else
        format.html { redirect_to @master, alert: @master.errors[:base][0] }
      end
    end
  end

  def copy
    original = @master
    @master  = @master_class.new(original.attributes)
    render :new
  end

  def lock
    respond_to do |format|
      if @master.lock
        format.html { redirect_to @master, notice: "#{@klass.titleize} was successfully locked." }
      else
        format.html { redirect_to @master, notice: "#{@klass.titleize} could not be locked." }
      end
    end
  end

  def unlock
    respond_to do |format|
      if @master.unlock
        format.html { redirect_to @master, notice: "#{@klass.titleize} was successfully unlocked." }
      else
        format.html { redirect_to @master, notice: "#{@klass.titleize} could not be unlocked." }
      end
    end
  end

  def archive
    respond_to do |format|
      if @master.archive
        format.html { redirect_to @master_class, notice: "#{@klass.titleize} was successfully archived." }
      else
        format.html { redirect_to @master, notice: "#{@klass.titleize} could not be archived." }
      end
    end
  end

  def unarchive
    respond_to do |format|
      if @master.unarchive
        format.html { redirect_to @master, notice: "#{@klass.titleize} was successfully unarchived." }
      else
        format.html { redirect_to @master, notice: "#{@klass.titleize} could not be unarchived." }
      end
    end
  end

private

  def set_class
    self.klass = self.class.name.sub(/Controller/, '').classify
    self.master_class = @klass.constantize
  end

  def set_master
    @master = @master_class.find(params[:id])
  end

  def set_master_custom
    id = "#{@klass.underscore}_id".to_sym
    @master = @master_class.find(params[id])
  end

  def master_params
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
end
