json.array!(@masters) do |copy|
  json.extract! copy, :id, :item_id, :accession_no, :procured_date, :quality, :status, :notes, :created_by, :updated_by
  json.url copy_url(copy, format: :json)
end
