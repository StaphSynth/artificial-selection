MUTATION_RATES = [ # per cent chance
  0.001,
  0.002,
  0.004,
  0.008,
  0.016,
  0.032,
  0.064,
  0.125,
  0.25,
  0.5,
  1,
  2,
  4,
  8,
  16,
  32,
  64
]

results = Hash.new { |hash, key| hash[key] = [] }
start_time = Time.now

MUTATION_RATES.each do |rate|
  20.times do
    return_value = `ruby selection.rb #{rate}`
    results[rate] << return_value.match(/Generation\s(\d+):/)[1].to_i
  end
end

File.open("selection-results-#{Time.now.strftime('%Y-%m-%d-%k:%g')}.csv", 'w') do |file|
  results.each do |rate, generations|
    file.write("#{rate},#{generations.join(',')}\n")
  end
end

puts "Completed in #{Time.now - start_time} seconds."

