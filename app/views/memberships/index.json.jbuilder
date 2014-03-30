json.array!(@masters) do |membership|
  json.extract! membership, :id, :code, :name, :kind, :notes, :created_by, :updated_by
  json.url membership_url(membership, format: :json)
end
