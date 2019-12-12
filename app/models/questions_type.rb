class QuestionsType
  attr_reader :questions_types

  def self.questions_types
    @questions_types = {  multiple_choices: 1,
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
                          multiple_url: 13 }
    @questions_types.each do |key, val|
      define_singleton_method key.to_s do
        val
      end
    end
  end

  def self.questions_types_title
    questions_types
    titled = {}
    @questions_types.each do |k, v|
      titled[k.to_s.titleize] = v
    end
    titled
  end

  def self.question_type_id
    questions_types
    @questions_types.values
  end

  def self.question_type_key
    questions_types
    @questions_types.keys
  end



end