module CollectionHelper
  def format_collection(collection)
    collection.map { |c| [c.titleize, c.underscore] }
  end
end
