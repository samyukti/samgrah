module SelectHelper
  def copy_collection(copies)
    copies.map do |copy|
      [copy.name, copy.id, data: { data: CopiesSelect.new([copy]).as_json.first }] \
        if copy
    end
  end

  def member_collection(members)
    members.map do |member|
      [member.name, member.id, data: { data: MembersSelect.new([member]).as_json.first }] \
        if member
    end
  end

  def item_collection(items)
    items.map do |item|
      [item.name, item.id, data: { data: ItemsSelect.new([item]).as_json.first }] \
        if item
    end
  end
end
