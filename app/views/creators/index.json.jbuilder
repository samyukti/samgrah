json.array!(@masters) do |creator|
  json.extract! creator, :id, :kind, :name, :first_name, :middle_name, :last_name, :sort_name, :notes, :created_by, :updated_by
  json.url creator_url(creator, format: :json)
end
