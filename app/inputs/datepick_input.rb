class DatepickInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:class].push('datepicker-input')
    input_html_options["data-date-format"] = Settings.format.date
    @builder.text_field(attribute_name, input_html_options)
  end
end
