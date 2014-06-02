class ReceiptsDatatable < GenericDatatable
  private

  def data
    records.map do |receipt|
      [receipt.id,
       receipt.received_date,
       receipt.member.name,
       receipt.kind.titleize,
       receipt.mode.titleize,
       receipt.amount,
       receipt.status.titleize,
       action_links(receipt)
      ]
    end
  end

  def records
    @receipts ||= Receipt.all.includes(:member)
    receipts = @receipts.order("#{sort_column} #{sort_direction}")
    receipts = receipts.page(page).per(per)
    if params[:search][:value].present?
      receipts = receipts.where("members.name ilike :search or receipts.kind ilike :search or receipts.mode ilike :search", search: "%#{params[:search][:value]}%")
                   .references(:member)
    end
    receipts
  end

  def columns
    %w(receipts.id receipts.received_date receipts.member receipts.kind receipts.mode receipts.amount receipts.status)
  end
end
