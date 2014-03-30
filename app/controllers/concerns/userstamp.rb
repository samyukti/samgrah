module Userstamp
  extend ActiveSupport::Concern

  def userstamp(model)
    model.created_by = model.updated_by = current_user.id
  end

  def userstamp_update(model)
    model.updated_by = current_user.id
  end
end
