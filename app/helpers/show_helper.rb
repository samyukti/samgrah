module ShowHelper
  def display_field(field, hash = {})
    label = hash[:label] || ""
    content_tag(:div, class: 'form-group') do
      concat(content_tag(:label, label, class: 'display-label'))
      concat(content_tag(:div, field, class: 'display-field'))
    end
  end
end
