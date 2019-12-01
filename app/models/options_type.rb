class Form::OptionsType
  attr_reader @options_types = {
      multiple_choices: 1,
      single_choice: 2,
      number: 3,
      text: 4,
      large_text: 5,
      file_upload: 6,
      linear_scale: 7,
      rating: 8,
      date: 9,
      time: 10,
      dropdown: 11,
      url: 12,
      multiple_url: 13
  }

  def self.options_types_title
    titled = {}
    Form::OptionsType.options_types.each { |k, v| titled[k.to_s.titleize] = v }
    titled
  end

  def self.options_type_ids
    @options_types.values
  end

  def self.options_type_keys
    @options_types.keys
  end

  @options_types.each do |key, val|
    define_singleton_method key.to_s do
      val
    end
  end
end