module CancanHelper
  def user_can?(actions, resources)
    actions.each do |action|
      resources.each do |resource|
        return false if cannot? action, resource
      end
    end
    true
  end

  def user_may?(actions, resources)
    actions.each do |action|
      resources.each do |resource|
        return true if can? action, resource
      end
    end
    false
  end

  def index_link(object, options = {}, &block)
    if can?(:read, object)
      object_class = (object.kind_of?(Class) ? object : object.class)
      if block_given?
        link_to object_class, options do
          block.call
        end
      else
        link_to(object_class.name.titleize.pluralize, object_class, options)
      end
    end
  end

  def new_link(object, options = {}, &block)
    if can?(:create, object)
      object_class = (object.kind_of?(Class) ? object : object.class)
      if block_given?
        link_to [:new, object_class.name.underscore.to_sym], options do
          block.call
        end
      else
        link_to("New", [:new, object_class.name.underscore.to_sym], options)
      end
    end
  end

  def copy_link(object, options = {}, &block)
    if can?(:copy, object)
      if block_given?
        link_to [object, :copy], options do
          block.call
        end
      else
        link_to("New", [object, :copy], options)
      end
    end
  end

  def show_link(object, options = {}, &block)
    if can?(:read, object)
      if block_given?
        link_to object, options do
          block.call
        end
      else
        link_to("Show", object, options)
      end
    end
  end

  def edit_link(object, options = {}, &block)
    if can?(:update, object)
      if block_given?
        link_to [:edit, object], options do
          block.call
        end
      else
        link_to("Edit", [:edit, object], options)
      end
    end
  end

  def destroy_link(object, options = {}, &block)
    options[:method] = :delete
    options[:confirm] = "Are you sure?"
    if can?(:destroy, object)
      if block_given?
        link_to object, options do
          block.call
        end
      else
        link_to("Destroy", object, options)
      end
    end
  end

  def lock_link(object, options = {}, &block)
    options[:method] = :patch
    options[:confirm] = "Are you sure?"
    if can?(:lock, object)
      if block_given?
        link_to [object, :lock], options do
          block.call
        end
      else
        link_to("Lock", [object, :lock], options)
      end
    end
  end

  def unlock_link(object, options = {}, &block)
    options[:method] = :patch
    options[:confirm] = "Are you sure?"
    if can?(:unlock, object)
      if block_given?
        link_to [object, :unlock], options do
          block.call
        end
      else
        link_to("Unlock", [object, :unlock], options)
      end
    end
  end

  def archive_link(object, options = {}, &block)
    options[:method] = :patch
    options[:confirm] = "Are you sure?"
    if can?(:archive, object)
      if block_given?
        link_to [object, :archive], options do
          block.call
        end
      else
        link_to("Archive", [object, :archive], options)
      end
    end
  end

  def unarchive_link(object, options = {}, &block)
    options[:method] = :patch
    options[:confirm] = "Are you sure?"
    if can?(:unarchive, object)
      if block_given?
        link_to [object, :unarchive], options do
          block.call
        end
      else
        link_to("Unarchive", [object, :unarchive], options)
      end
    end
  end
end
