class CopiesReport
  def initialize(params)
    @params = params
  end

  def report
    { start_date: start_date, end_date: end_date, rows: header + rows }
  end

  private

  def start_date
    @params[:start_date].presence || Date.today.beginning_of_month.strftime('%F')
  end

  def end_date
    @params[:end_date].presence || Date.today.end_of_month.strftime('%F')
  end

  def copies
    Copy.includes(item: :category)
        .where('procured_date between :s and :e', s: start_date, e: end_date)
  end

  def header
    [['ID',
      'Accession No',
      'Category',
      'Category Type',
      'Item Code',
      'Item Name',
      'Item Type',
      'Subject',
      'Format',
      'Language',
      'Publisher',
      'Published Date',
      'Rating',
      'Quality',
      'Issued',
      'Status',
      'Location',
      'Procured Date',
      'Quantity',
      'Issued Quantity',
      'Cost',
      'Price',
      'Total Cost',
      'Total Price'
     ]]
  end

  def rows
    copies.map do |copy|
      [copy.id,
       copy.name,
       copy.item.category.name,
       copy.item.category.kind.titleize,
       copy.item.code,
       copy.item.name,
       copy.item.kind.titleize,
       copy.item.subject.to_s,
       copy.item.format.titleize,
       copy.item.language.titleize,
       copy.item.publisher.to_s,
       copy.item.published_date,
       copy.item.rating.to_s,
       copy.quality.titleize,
       copy.issued.to_s.titleize,
       copy.status.titleize,
       copy.location.to_s,
       copy.procured_date,
       copy.quantity.to_i,
       copy.issued_quantity.to_i,
       copy.cost.to_f,
       copy.price.to_f,
       copy.quantity.to_i * copy.cost.to_f,
       copy.quantity.to_i * copy.price.to_f
      ]
    end
  end
end
