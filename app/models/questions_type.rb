class Form::QuestionsType
  attr_reader @questions_types = {
      multiple_choice: 0, free_response: 1, multi_select: 2
  }

  def self.questions_types_title
    titled = {}
    Form::QuestionsType.questions_types.each do |k, v|
      titled[k.to_s.titleize] = v
    end
    titled
  end

  def self.questions_type_ids
    @questions_types.values
  end

  def self.questions_type_keys
    @questions_types.keys
  end

  @questions_types.each do |key, val|
    define_singleton_method key.to_s do
      val
    end
  end

end