json.array!(@issues) do |issue|
  json.extract! issue, :id, :item_id, :member_id, :issued_date, :kind, :status, :return_date, :extension, :notes, :created_by, :updated_by
  json.url issue_url(issue, format: :json)
end
