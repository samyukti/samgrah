json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :item_id, :member_id, :reserved_date, :status, :notes, :created_by, :updated_by
  json.url reservation_url(reservation, format: :json)
end
