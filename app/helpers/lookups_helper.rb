module LookupsHelper
  def lookup(setting, id)
    setting.select { |x| x.id == id }.first.name
  end
end
