module DataQuality
  extend ActiveSupport::Concern

  def either(o, h = {})
    o.presence || h[:or]
  end
end
