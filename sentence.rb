class Sentence
  CHARSET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z \ ]

  attr_reader :sentence, :mutation_rate

  def initialize(length: 28, value: nil, mutation_rate: 1000)
    @sentence = value.nil? ? generate(length) : value
    @mutation_rate = mutation_rate # rate/1000 == percent. eg: 1000/1000 == 1%

    raise ArgumentError, 'Mutation rate out of bounds' unless valid_mutation_rate?
  end

  def similarity_points(operand)
    self_chars = sentence.chars
    operand_chars = operand.chars
    compare_set = self_chars[0...operand_chars.size]
      .zip(operand_chars[0...self_chars.size])

    compare_set.reduce(0) do |points, chars|
      point_value = chars.last == ' ' ? 2 : 1 # weight spaces higher

      chars.first == chars.last ? points += point_value : points
    end
  end

  def breed
    daughter_sentence = sentence.chars.map do |char|
      (0...mutation_rate).member?(rand(100000)) ? CHARSET.sample : char
    end.join

    Sentence.new(value: daughter_sentence, mutation_rate: mutation_rate)
  end

  def chars
    sentence.chars
  end

  def ==(operand)
    sentence == (operand.class == self.class ? operand.sentence : operand)
  end

  def to_s
    sentence
  end

  private

  def generate(length)
    (0...length).map do
      CHARSET.sample
    end.join
  end

  def valid_mutation_rate?
    mutation_rate > 0 && mutation_rate <= 100000
  end
end
