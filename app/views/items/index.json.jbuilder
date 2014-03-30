json.array!(@masters) do |item|
  json.extract! item, :id, :category_id, :code, :name, :creator_id, :subject, :kind, :format, :pages, :publisher, :published_date, :language, :isbn_10, :isbn_13, :rights, :tags, :excerpt, :rating, :notes, :created_by, :updated_by
  json.url item_url(item, format: :json)
end
