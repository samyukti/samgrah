module MastersHelper
  def shared_master
    instance_variable_get("@#{controller_name.singularize}")
  end
end
