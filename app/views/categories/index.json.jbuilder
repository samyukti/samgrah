json.array!(@masters) do |category|
  json.extract! category, :id, :parent_id, :code, :name, :kind, :notes, :created_by, :updated_by
  json.url category_url(category, format: :json)
end
