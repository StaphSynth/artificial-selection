require './sentence'

SHAKESPEARE = 'methinks it is like a weasel'.freeze
sentence = Sentence.new(length: SHAKESPEARE.length)
generation = 1
start_time = Time.now

puts sentence.sentence

loop do
  if sentence == SHAKESPEARE
    break
  else
    daughter = sentence.breed

    sentence = daughter.similarity_points(SHAKESPEARE) > sentence.similarity_points(SHAKESPEARE) ? daughter : sentence

    generation += 1
  end
end

puts "Generation #{generation}: #{sentence}"
puts "Solved in #{Time.now - start_time} seconds"
